import 'package:ease_food/main.dart';
import 'package:ease_food/pages/order.dart';
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
  bool isAddingToCart = false;
  final TextEditingController _descriptionController = TextEditingController();
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

      print("Added to Cart $response");
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('error while adding to cart $error');
    }
  }

  Future<void> addCart(String foodid, String description, int quantity) async {
    setState(() {
      isAddingToCart = true;
    });
    try {
      final supabase = Supabase.instance.client;
      final response = await supabase.from('carts').insert(
          {'foodid': foodid, 'description': description, 'quantity': quantity});
      if (mounted) {
        showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(content: Text('Product added to Cart'));
            }).then((_){
              Navigator.push(
              context, MaterialPageRoute(builder: (context) => Orders(foodid:foodid,description:description,quantity:quantity)));
            });
      }
      
      print("this is food $response");
    } catch (error) {
      print('error whiel fetching singelFood $error');
    } finally {
      setState(() {
        isAddingToCart = false; // Hide progress indicator
      });
    }
  }

  int quantity = 1; // Default quantity

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food order'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : foodData == null
              ? const Center(
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      foodData!['food_name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.black,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      foodData!['description'],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.none,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: Color(0xffFFCFC6),
                                      ),
                                      child: const Row(
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
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Additional Cookies'),
                                    Container(
                                      width: 80,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                          color: Color(0xffB4E1C3)),
                                      child: const Row(
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
                                const Row(
                                  children: [
                                    Text(
                                      'Add special Instructions ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 120,
                                        decoration:  BoxDecoration(
                                          borderRadius:BorderRadius.circular(8),
                                            color: Colors.grey),
                                        child: TextField(
                                          controller: _descriptionController,
                                          expands: true,
                                          maxLines: null,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(borderSide: BorderSide.none),
                                            fillColor: Colors.grey,
                                            hintText: "Write here .....",
                                          ),
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(Icons.remove),
                                            onPressed: _decrementQuantity,
                                          ),
                                          SizedBox(
                                            width: 50,
                                            child: TextField(
                                              textAlign: TextAlign.center,
                                              readOnly:
                                                  true, // Read-only, so users can't manually change the value
                                              controller: TextEditingController(
                                                  text: quantity.toString()),
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical:
                                                            5), // Adjust padding
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: _incrementQuantity,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isAddingToCart
                                        ? const CircularProgressIndicator()
                                        : Padding(
                                          padding: const EdgeInsets.only(bottom: 40.0),
                                          child: SizedBox(
                                              width: 250,
                                              child: TextButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty.all<
                                                                  Color>(
                                                              const Color(
                                                                  0xffD42323))),
                                                  onPressed: () {
                                                    print('yes');
                                                    String description =
                                                        _descriptionController
                                                            .text;
                                                    addCart(
                                                      widget.foodId,
                                                      description,
                                                      quantity,
                                                    ); // Default quantity to 1
                                                   
                                                  },
                                                  child: Text(
                                                    ' Add to cart ${(quantity* double.parse(foodData!['food_price']))} RWf',
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ),
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
