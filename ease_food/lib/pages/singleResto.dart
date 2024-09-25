import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../modals/resto_modal.dart';
import './singleFood.dart';

class SingleResto extends StatefulWidget {
  final int restoId;

  const SingleResto({super.key, required this.restoId});

  @override
  State<SingleResto> createState() => _SingleRestoState();
}

class _SingleRestoState extends State<SingleResto> {
  RestoModal? restoData;
  List<dynamic> meals = [];
  @override
  void initState() {
    super.initState();
    fetchRestoData(widget.restoId);
    fetchMeals(widget.restoId);
    print(
        'This is the ID passed to SingleResto hhhshshhshshshhs: ${widget.restoId}');
  }

  Future<void> fetchRestoData(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('restos')
          .select()
          .eq('id', id)
          .single(); // Fetch a single restaurant by id
      print(response);
      setState(() {
        restoData = RestoModal.fromMap(response);
      });
      print('alll restos ////////// $response');
    } catch (error) {
      print('Error fetching restaurant data: $error');
    }
  }

  Future<void> fetchMeals(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('foods')
          .select()
          .eq('restoId', id);

      print("this is meals ///////// $response");

      setState(() {
        meals = response; // Store the meals data
        print(meals[0]['id']);
      });
    } catch (error) {
      print('Error fetching meals: $error');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Details'),
        ),
        body: restoData == null
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                children: [
                  RestoImage(
                      iconPath: restoData!.iconPath,
                      name: restoData!.name,
                      location: restoData!.location,
                      delivery: restoData!.delivery,
                      meals: meals),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Available Meals',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  meals.isEmpty
                      ? Center(child: Text('No available Meals'))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: meals.length,
                          itemBuilder: (context, index) {
                            final meal = meals[index];
                            print('meal at index $index is $meal');
                            return Card(
                              margin: EdgeInsets.only(bottom: 10),
                              child: SizedBox(
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 0.3)),
                                        child: Image.network(
                                          meal['food_image'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )),
                                    Container(
                                      width: 210,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.red, // Border color
                                          width: 0.3, // Border width
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              meal['food_name'],
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              meal['description'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              meal['food_price'],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          print('yes');
                                          Navigator.push(
                                              context,MaterialPageRoute(builder:(context) =>Singlefood(foodId: meal['id']) ,));
                                        },
                                        icon: Icon(Icons.forward_10_outlined))
                                  ],
                                ),
                              ),
                            );
                          }),
                ],
              )));
  }
}

class RestoImage extends StatelessWidget {
  final String iconPath;
  final String name;
  final String location;
  final String delivery;
  final List<dynamic> meals;
  const RestoImage({
    required this.iconPath,
    required this.name,
    required this.location,
    required this.delivery,
    required this.meals,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.network(
            iconPath,
            height: 200,
            fit: BoxFit.cover,
          ),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            name,
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              location,
              style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        SizedBox(
          width: 250,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                delivery,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Color(0xff633631))),
                  onPressed: () {
                    Navigator.pushNamed(context, '/Singlefood');
                  },
                  child: Text('Reserve',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ],
    );
  }
}
