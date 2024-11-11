import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/ikan_laut_page.dart';
import 'package:freshy_fish/ikan_payau_page.dart';
import 'package:freshy_fish/ikan_tawar_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> me;
  StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();
    me = getMe();
  }

  Future<Map<String, dynamic>> getMe() async {
    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("http://192.168.1.7:8000/api/auth/me"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    return jsonDecode(response.body);
  }

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
                      Image.asset('assets/logo_keranjang_doang.png', scale: 1.5),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi,',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          FutureBuilder(
                            future: me,
                            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return const Text("error");
                              } else {
                                return SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: Text(
                                    "${snapshot.data["data"]["name"]}",
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                                  Text(
                                  "${snapshot.data["data"]["name"]}",
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          getMe();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const CartPage()),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_bag_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 320,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: const Row(
                      children: [
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset("assets/yakinikan.png"),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IkanPayauPage()),
                            );
                          },
                          label: const Text(
                            'Ikan Payau',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IkanLautPage()),
                            );
                          },
                          label: const Text(
                            'Ikan Laut',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const IkanTawarPage()),
                            );
                          },
                          label: const Text(
                            'Ikan Tawar',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        if (index == 0) {
                          return fishCard(
                            imageUrl:
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Javaen_barb.jpg/375px-Javaen_barb.jpg',
                            title: "Ikan Brek",
                            price: "Rp 20.000",
                          );
                        } else {
                          return fishCard(
                            imageUrl:
                            'https://www.deheus.id/siteassets/news/article/mengenal-ikan-bandeng/bandeng-hero-2.jpg?mode=crop&width=2552&height=1367',
                            title: "Ikan Bandeng",
                            price: "Rp 25.000",
                          );
                        }
                      },
                      childCount: 2,
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

  Widget fishCard({required String imageUrl, required String title, required String price}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                imageUrl,
                height: 90,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              price,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.cyan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
