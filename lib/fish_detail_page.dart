// import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/confirm_order_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
// import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

import 'cart_page.dart';

class FishDetailPage extends StatefulWidget {
  final String fishName;
  final String fishPrice;
  final String imageUrl;

  const FishDetailPage({
    required this.fishName,
    required this.fishPrice,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  _FishDetailPageState createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Opsional: Mengatur posisi elemen
          children: [
            Text(
              widget.fishName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                size: 30,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
        foregroundColor: Colors.white,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Container(
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 150, 200),
                  width: 2
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(widget.imageUrl),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          widget.fishName,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.fishPrice,
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.cyan
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: (){
                                      http
                                          .post(
                                        Uri.parse(
                                            'https://freshyfishapi.ydns.eu/api/produk'),
                                        headers: <String, String>{
                                          'Content-Type': 'application/json'
                                        },
                                        body: {

                                        }
                                      )
                                          .then((response) {
                                        if (response.statusCode == 200) {
                                          var res = jsonDecode(response.body);
                                          StorageService().saveToken(res["token"]);
                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const CartPage(),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Failed to add to the cart!"),
                                            ),
                                          );
                                        }
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(255, 0, 150, 200), // Set button color
                                    ),
                                    child: const Icon(
                                        Icons.add_shopping_cart_outlined,
                                        color: Colors.white,
                                      size: 25,
                                    ),
                                ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfirmOrderPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color.fromARGB(255, 0, 150, 200), // Set button color
                                  ),
                                  child: const Text(
                                      'Check Out',
                                    style: TextStyle(fontSize: 16, color: Colors.white),
                                  )
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
