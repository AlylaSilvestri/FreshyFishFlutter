import 'package:flutter/material.dart';
import 'main_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: const Color.fromARGB(255, 0, 150, 200),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()));
                        }, // Set background color to blue
                        child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 35),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Your Order',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Set text color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    ListTile(
                      leading: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: AssetImage('assets/Gurame.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
