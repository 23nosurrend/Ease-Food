import 'package:flutter/material.dart';

class Singlefood extends StatefulWidget {
  const Singlefood({super.key});

  @override
  State<Singlefood> createState() => _SinglefoodState();
}

class _SinglefoodState extends State<Singlefood> {
  bool _isCheked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food order'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Image.asset('assets/cookie.png')],
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
                            'Cookie SandWich',
                            style: TextStyle(
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
                            'Short Bread chocolate,\nand mayonaise and blueband\n8 ounces of cheese ',
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
                              mainAxisAlignment: MainAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Additional Cookies'),
                          Container(
                            width: 50,
                            height: 20,
                            decoration: BoxDecoration(color: Color(0xffB4E1C3)),
                            child: Text(
                              'Required',
                              style: TextStyle(color: Colors.green),
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
                            _isCheked=value??false;
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
                           _isCheked=value??false;
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
                           _isCheked=value??false;
                          });
                        },
                      ),
                      Row(
                        children: [Text('Add spcial Instructions ')],
                      ),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:WidgetStateProperty.all<Color>(
                                  const Color(0xffD42323)
                                )
                                
                              ),
                                onPressed: () {}, child: Text(' Procced to Pay 400Rwf',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold
                                ),
                                
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
