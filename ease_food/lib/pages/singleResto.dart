import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../modals/resto_modal.dart';

class SingleResto extends StatefulWidget {
  final int restoId;

  const SingleResto({super.key, required this.restoId});

  @override
  State<SingleResto> createState() => _SingleRestoState();
}

class _SingleRestoState extends State<SingleResto> {
  RestoModal? restoData;
  @override
  void initState() {
    super.initState();
    fetchRestoData(widget.restoId);
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
      if (response != null) {
        setState(() {
          restoData = RestoModal.fromMap(response);
        });
      }
    } catch (error) {
      print('Error fetching restaurant data: $error');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Restaurant Details'),
        ),
        body: restoData == null
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  RestoImage(
                    iconPath: restoData!.iconPath, // Restaurant image URL
                    name: restoData!.name, // Restaurant name
                    location: restoData!.location, // Restaurant location
                    delivery: restoData!.delivery, // Delivery info
                  ),
                ],
              ));

    //  Container(
    //   color: Colors.white,
    //   child: ListView(children: [
    //     RestoImage(),
    //   ]),
    // );
  }
}


class RestoImage extends StatelessWidget {
  final String iconPath;
  final String name;
  final String location;
  final String delivery;
  const RestoImage({
     required this.iconPath,
    required this.name,
    required this.location,
    required this.delivery,
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
            ' Bavaris',
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
                  onPressed: () {},
                  child: Text('Reserve',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
