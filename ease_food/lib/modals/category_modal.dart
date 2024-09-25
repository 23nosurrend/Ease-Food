import 'package:flutter/material.dart';

class CategoryModal {
  String name;
  String iconPath;
  Color boxColor;

  CategoryModal(
      {required this.name, required this.iconPath, required this.boxColor});

  static List<CategoryModal> getCategories() {
    List<CategoryModal> categories = [];
    categories.add(CategoryModal(
        name: 'Salad', iconPath: 'assets/meat.jpeg', boxColor: const Color.fromARGB(26, 169, 106, 106)));
    categories.add(CategoryModal(
        name: 'Fruits',
        iconPath: 'assets/fruit.jpeg',
        boxColor: Colors.blueAccent));
    categories.add(CategoryModal(
        name: 'meat',
        iconPath: 'assets/meat.jpeg',
        boxColor: Colors.blueAccent));
    categories.add(CategoryModal(
        name: 'Salad', iconPath: 'assets/meat.jpeg', boxColor: Colors.grey));

    return categories;
  }
}
