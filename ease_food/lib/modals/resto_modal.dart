import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RestoModal {
  int id;
  String name;
  String iconPath;
  String location;
  String delivery;

  RestoModal(
      {required this.id,required this.name,
      required this.iconPath,
      required this.location,
      required this.delivery});
  factory RestoModal.fromMap(Map<String, dynamic> data) {
    return RestoModal(
      id:data['id'],
      name: data['name'],
      iconPath: data['iconpath'],
      location: data['location'],
      delivery: data['delivery'],
    );
  }

  @override
  String toString() {
    return 'RestolModal(id:$id,name:$name,iconPath:$iconPath,location:$location,delivery:$delivery)';
  }
}
