import 'package:flutter/material.dart';

class DietModal {
  String name;
  String iconPath;
  String level;
  String duration;
  String calorie;
  bool viewIsSelected;
  Color boxColor;

  DietModal(
      {required this.name,
      required this.iconPath,
      required this.level,
      required this.duration,
      required this.calorie,
      required this.viewIsSelected,
      required this.boxColor
      });

  static List<DietModal> getDiets() {
    List<DietModal> diets = [];

    diets.add(
      DietModal(
          name: 'meat',
          iconPath: 'assets/meat.jpeg',
          level: 'expensive',
          duration: '30min',
          calorie: '180Kcal',
          viewIsSelected: true,
          boxColor: const Color.fromARGB(255, 147, 195, 211)
          ),
    );

    diets.add(
      DietModal(
          name: 'meat',
          iconPath: 'assets/meat.jpeg',
          level: 'expensive',
          duration: '30min',
          calorie: '180Kcal',
          viewIsSelected: false,
           boxColor: const Color.fromARGB(255, 203, 223, 243)
          ),
    );

    diets.add(
      DietModal(
          name: 'meat',
          iconPath: 'assets/meat.jpeg',
          level: 'expensive',
          duration: '30min',
          calorie: '180Kcal',
          viewIsSelected: false,
           boxColor: const Color.fromARGB(255, 222, 177, 177)
          ),
          
    );
    return diets;
  }
}
