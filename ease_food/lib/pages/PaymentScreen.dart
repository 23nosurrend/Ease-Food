import 'package:flutter/material.dart';
import './FlutterPayment.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool _isCheckedOne = false;
  bool _isCheckedTwo = false;
  bool _isCheckedThree = false;
  bool _isCheckedFour = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: screenWidth * 0.9,
              height: 80,
              decoration: BoxDecoration(
                color: Color(0xffFBE9E9),
              ),
              child: Container(
                width: 50,
                decoration: BoxDecoration(color: Colors.grey),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/shopping-basket.png'),
                    Text(
                      'Total Amount:   10,000 Rwf',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            CheckboxListTile(
              title: const Text('Paypal'),
              secondary: Image.asset('assets/paypal.png'),
              value: _isCheckedOne,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckedOne = value ?? true;
                });
              },
            ),
            SizedBox(height: 30),
            CheckboxListTile(
              title: const Text('Venmo'),
              secondary: Image.asset('assets/Venmo.png'),
              value: _isCheckedTwo,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckedTwo = value ?? true;
                });
              },
            ),
            SizedBox(height: 30),
            CheckboxListTile(
              title: const Text('MasterCard'),
              secondary: Image.asset('assets/Mastercard.png'),
              value: _isCheckedThree,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckedThree = value ?? true;
                });
              },
            ),
            SizedBox(height: 30),
            CheckboxListTile(
              title: const Text('FlutterWave'),
              secondary: Image.asset('assets/flutterWave.png'),
              value: _isCheckedFour,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _isCheckedFour = value ?? true;
                });
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10), // Button padding
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8), // Rounded corners
                      ),
                      // Button background color
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Add New Method '),
                        Icon(
                          Icons.add,
                          color: Colors.black,
                        )
                      ],
                    ))
              ],
            ),
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: TextButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                const Color(0xff212121))),
                        onPressed: () {
                          print('yes');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlutterPayment(),
                              ));
                        },
                        child: Text(
                          'Complete Purchase',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
