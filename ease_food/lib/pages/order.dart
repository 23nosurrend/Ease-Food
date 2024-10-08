import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import './PaymentScreen.dart';

class Orders extends StatefulWidget {
  final String foodid;
  final String description;
  final int quantity;
  const Orders(
      {super.key,
      required this.foodid,
      required this.description,
      required this.quantity});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Map<String, dynamic>> cartItems = [];
  Map<String, dynamic> foodDetails = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCartItems();
  }

  Future<void> _fetchCartItems() async {
    try {
      final supabase = Supabase.instance.client;

      // Fetch all cart items
      final cartResponse = await supabase.from('carts').select('*');
      List<Map<String, dynamic>> carts =
          List<Map<String, dynamic>>.from(cartResponse);
      print('carts response $cartResponse');
    } catch (e) {
      print('Error while fetching Carts $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Orders',
        style: TextStyle(color: Colors.black),
      )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 0.3)),
                    child: Image.asset(
                      'assets/meat.jpeg',
                      width: 80,
                      height: 80,
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
                  child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chapatti',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'High calorie food with sugar and salt',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  '200',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: screenWidth * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 0.2)),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text('Order Summary',
                          style: TextStyle(color: Colors.black, fontSize: 30))
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Sub total'), Text('100Rwf')],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text('Delivery Fees'), Text('100Rwf')],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text('7000 Rwf',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10), // Button padding
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            // Button background color
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, '/payment');
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Add Item '),
                              Icon(
                                Icons.add,
                                color: Colors.black,
                              )
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color(0xffD42323))),
                            onPressed: () {
                              print('yes');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Payment(),
                                  ));
                            },
                            child: const Text(
                              ' Proceed to payment',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
