import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestoModal {
  String name;
  String iconPath;
  String location;
  String delivery;

  RestoModal(
      {required this.name, required this.iconPath, required this.location, required this.delivery});

    

  static List<RestoModal> getResto() {
    List<RestoModal> restos = [];

    restos.add(RestoModal(
        name: '67 Athil Hotel',
        delivery: 'Free Delivery ',
        iconPath: 'assets/resto.png',
        location: 'Remera-LANDO'));
        restos.add(RestoModal(
        name: '67 Athil Hotel',
        delivery: 'Free Delivery ',
        iconPath: 'assets/resto.png',
        location: 'DOWNTOWN-NYARUGENGE'));
        restos.add(RestoModal(
        name: 'K67 Top10 Hotel',
        delivery: 'Free Delivery ',
        iconPath: 'assets/resto.png',
        location: 'KACYIRU-GASABO'));
    return restos;
  }
}
