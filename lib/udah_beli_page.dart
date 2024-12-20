import 'package:flutter/material.dart';
import 'package:freshy_fish/main_page.dart';

class UdahBeliPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrderConfirmedScreen(),
    );
  }
}

class OrderConfirmedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 0, 150, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Icon(Icons.check_circle_rounded, color: Colors.white, size: 220,)
            ),
            SizedBox(height: 16.0),
            Text(
              'Order Confirmed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Thank you for your order.\nYour order is being processed.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: Text('Continue Shopping', style: TextStyle(color: const Color.fromARGB(255, 0, 150, 200),)),
            ),
          ],
        ),
      ),
    );
  }
}