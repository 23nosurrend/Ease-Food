import 'package:ease_food/main.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Singlefood extends StatefulWidget {
  final String foodId;
  const Singlefood({super.key, required this.foodId});

  @override
  State<Singlefood> createState() => _SinglefoodState();
}

class _SinglefoodState extends State<Singlefood> {
  bool _isCheked = false;
  Map<String, dynamic>? foodData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSingleFood(widget.foodId);
    print("this is idddddddd of single food ${widget.foodId}");
  }

  Future<void> fetchSingleFood(String id) async {
    try {
      final supabase = Supabase.instance.client;
      final response =
          await supabase.from('foods').select().eq('id', id).single();
      setState(() {
        foodData = response;
        isLoading = false;
      });
      print("this is food $response");
    } catch (error) {
      print('error whiel fetching singelFood $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food order'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : foodData == null
              ? Center(
                  child: Text('No food Found'),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            height: MediaQuery.of(context).size.height * 0.3,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Image.network(
                              foodData!['food_image'],
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      foodData!['food_name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      foodData!['description'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Color(0xffFFCFC6),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'American Cusiine ',
                                            style: TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Additional Cookies'),
                                    Container(
                                      width: 80,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xffB4E1C3)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Required',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                CheckboxListTile(
                                  title: const Text('Chocolate Chips'),
                                  value: _isCheked,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheked = value ?? false;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Chocolate Chips'),
                                  value: _isCheked,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheked = value ?? false;
                                    });
                                  },
                                ),
                                CheckboxListTile(
                                  title: const Text('Chocolate Chips'),
                                  value: _isCheked,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isCheked = value ?? false;
                                    });
                                  },
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Add special Instructions ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 250,
                                      child: TextButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                          Color>(
                                                      const Color(0xffD42323))),
                                          onPressed: () {},
                                          child: Text(
                                            ' Procced to Pay ${foodData!['food_price']}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
    );
  }
}
