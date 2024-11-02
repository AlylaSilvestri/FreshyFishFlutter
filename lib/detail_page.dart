import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String imageUrl;
  const DetailPage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite_outline_rounded),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_checkout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/Gurame.png', height: MediaQuery.of(context).size.height / 1.8, fit: BoxFit.fill,),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Text(
                'Ikan Gurame',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text('Mau ikan gurame gak?'),
            ),
            const Padding(
                padding: EdgeInsets.all(16.0),
              child: Text('\Rp 31.000',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500) ,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ) ,
      ) ,
    );
  }
}
