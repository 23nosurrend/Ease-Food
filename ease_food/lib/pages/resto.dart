import 'package:ease_food/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../modals/resto_modal.dart';
import './singleResto.dart';
import '../powersync.dart';

class Resto extends StatefulWidget {
  Resto({super.key});

  @override
  State<Resto> createState() => _RestoState();
}

class _RestoState extends State<Resto> {
  List<RestoModal> restos = [];
  List<RestoModal> filteredResto = [];
  TextEditingController searchController = TextEditingController();

  void initState() {
    super.initState();
    // openDatabase();
    getInitInfo();
    searchController.addListener(_filterResto);
  }

  @override
  Future<void> getInitInfo() async {
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('restos').select();

      if (response.isNotEmpty) {
        final List<dynamic> data = response;
        setState(() {
          restos = data.map((item) => RestoModal.fromMap(item)).toList();
          filteredResto = restos;
        });

        print('this is the data //////////////////// $restos');
        print(restos[0].name);
      }
    } catch (error) {
      print('Error while fetching restos:$error');
    }
  }

  void _filterResto() {
    final query = searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        filteredResto = restos;
      } else {
        filteredResto = restos
            .where((resto) => resto.name.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // getInitInfo();
    return Container(
      child: ListView(children: [
        Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(0, 121, 121, 163).withOpacity(0.11),
                blurRadius: 10,
                spreadRadius: 0.0)
          ]),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(20),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset('assets/search.svg'),
              ),
              suffixIcon: Container(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VerticalDivider(
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                        thickness: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset('assets/more.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              hintText: 'Search Resto name',
              hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StreamBuilder<List<RestoModal>>(
                stream: RestoModal.watchRestaurants(), // The PowerSync method
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }

                  final restos = snapshot.data ?? [];

                  // Filtering the restaurants based on search query
                  final filteredResto = restos.where((resto) {
                    return resto.name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();

                  if (filteredResto.isEmpty) {
                    return Text('No restaurants found');
                  }
                  return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: filteredResto.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Container(
                            width: 240,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                    left: BorderSide(color: Colors.grey))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        filteredResto[index].iconPath,
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        fit: BoxFit.cover,
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        filteredResto[index].name,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      filteredResto[index].location,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 250,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        filteredResto[index].delivery,
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                          Color>(
                                                      Color(0xff633631))),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleResto(
                                                          restoId:
                                                              filteredResto[
                                                                      index]
                                                                  .id,
                                                        )));
                                          },
                                          child: Text('View More',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10)
                              ],
                            ),
                          ),
                        );
                      });
                })
          ],
        )
      ]),
    );
  }
}
