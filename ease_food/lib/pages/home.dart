import 'package:ease_food/modals/category_modal.dart';
import 'package:ease_food/modals/diet_modal.dart';
import 'package:ease_food/modals/popular_dietModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  List<CategoryModal> categories = [];
  List<DietModal> diets = [];
  List<PopularDietModal> popularDiets = [];

  void getCategories() {
    categories = CategoryModal.getCategories();
  }

  @override
  void getInitialInfo() {
    categories = CategoryModal.getCategories();
    diets = DietModal.getDiets();
    popularDiets = PopularDietModal.getPopularDiets();
  }

  @override
  Widget build(BuildContext context) {
    getInitialInfo();
    return Scaffold(
        appBar: appBar(),
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SearchField(),
            _categories(),
            const SizedBox(height: 40),
            _dietSection(),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 15),
                ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    itemBuilder: (context, index) {
                      return Container(
                        height: 100,
                        decoration: BoxDecoration(
                            color:popularDiets[index].viewIsSelected? Colors.white:Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: popularDiets[index].viewIsSelected?const [
                              BoxShadow(
                                color: Colors.black87,
                                offset: Offset(0,10),
                                blurRadius: 40,
                                spreadRadius: 0
                                )
                            ]:[]),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                               Image.asset('assets/meat.jpeg',
                               width:80,
                               height:80,
                               fit:BoxFit.cover
                               ),
                               Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(popularDiets[index].name,
                                  style:const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:Colors.black,
                                    fontSize: 16,
                                  ),
                                  
                                  ),
                                  Text(
                                      '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                                  style:const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color:Colors.grey,
                                    fontSize: 16,
                                  )
                                  )
                                ],
                               ),
                               GestureDetector(
                                onTap:(){

                                },
                                child:Image.asset('assets/right-arrow.png',
                                height:20,
                                width:20
                                
                                )
                               )
                              ],
                            )
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 25),
                    itemCount: popularDiets.length),
              ],
            )
          ],
        ));
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Recommendation \n for meals',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 15),
        Container(
            height: 240,
            child: ListView.separated(
              itemCount: diets.length,
              padding: const EdgeInsets.only(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 30),
              itemBuilder: (context, index) {
                return Container(
                    width: 210,
                    decoration: BoxDecoration(
                        color: diets[index].boxColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Image.asset(diets[index].iconPath),
                        Text(diets[index].name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            )),
                        Text(
                            '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                            )),
                        Container(
                          width: 100,
                          height: 30,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              diets[index].viewIsSelected
                                  ? Colors.blueAccent
                                  : Colors.transparent,
                              diets[index].viewIsSelected
                                  ? Colors.blueGrey
                                  : Colors.transparent
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text('View',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: diets[index].viewIsSelected
                                        ? Colors.white
                                        : const Color.fromARGB(
                                            255, 192, 120, 115),
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ));
              },
            ))
      ],
    );
  }

  Column _categories() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Category',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Container(
            height: 150,
            child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 10, right: 10),
              separatorBuilder: (context, index) => const SizedBox(width: 25),
              itemBuilder: (context, index) {
                return Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: categories[index].boxColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset('assets/meat.jpeg'),
                          ),
                        ),
                        Text(categories[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))
                      ],
                    ));
              },
            ))
      ],
    );
  }

  Container SearchField() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color.fromARGB(0, 121, 121, 163).withOpacity(0.11),
            blurRadius: 10,
            spreadRadius: 0.0)
      ]),
      child: TextField(
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
          hintText: 'Search meal',
          hintStyle: const TextStyle(color: Colors.black, fontSize: 16),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Meal ',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      centerTitle: true,
      leading: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: SvgPicture.asset(
            'assets/chevron-left.svg',
            height: 30,
            width: 30,
          )),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: SvgPicture.asset(
                'assets/more-vertical.svg',
                height: 20,
                width: 10,
              )),
        )
      ],
    );
  }
}
