import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/confirm_order_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

import 'cart_page.dart';

class FishDetailPage extends StatefulWidget {
  final String fishName;
  final String fishPrice;
  final String imageUrl;
  final String fishDesc;
  final String productId;
  final String userId;

  FishDetailPage({
    required this.fishName,
    required this.fishPrice,
    required this.imageUrl,
    required this.fishDesc,
    required this.productId,
    required this.userId,

    Key? key,
  }) : super(key: key);

  @override
  _FishDetailPageState createState() => _FishDetailPageState();
}

class _FishDetailPageState extends State<FishDetailPage> {
  StorageService storageService = StorageService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.fishName,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
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
            const SizedBox(height: 20),
            Container(
              width: 330,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromARGB(255, 0, 150, 200),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
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
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.fishPrice,
                          style: const TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan,
                          ),
                        ),
                        Text(
                          widget.fishDesc,
                          style: const TextStyle(fontSize: 17),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () async {
                                  String? token = await storageService.getToken();
                                  http.post(
                                    Uri.parse('https://freshyfishapi.ydns.eu/api/keranjang'),
                                    headers: <String, String>{
                                      'Accept': 'application/json',
                                      'Content-Type': 'application/json',
                                      'Authorization': "Bearer $token",
                                    },
                                    body: jsonEncode({
                                      'order_quantity': 1,
                                      'ID_produk': widget.productId,
                                      'ID_user' : widget.userId,
                                    }),
                                  )
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      var res = jsonDecode(response.body);
                                      StorageService().saveToken(res["token"]);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartPage(userId: widget.userId),
                                        ),
                                      );
                                    } else {
                                      print(response.body);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Added to the cart!"),
                                        ),
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                                ),
                                child: const Icon(
                                  Icons.add_shopping_cart_outlined,
                                  color: Colors.white,
                                  size: 25,
                                ),
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
