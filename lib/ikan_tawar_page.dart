import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

class IkanTawarPage extends StatefulWidget {
  const IkanTawarPage({super.key});

  @override
  State<IkanTawarPage> createState() => IkanTawarPageState();
}

class IkanTawarPageState extends State<IkanTawarPage> {
  late Future<Map<String, dynamic>> me;
  late Future<List<dynamic>> freshwaterFish;
  StorageService storageService = StorageService();
  String searchQuery = '';
  bool isLoading = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    me = getMe();
    freshwaterFish = getFreshwaterFish();
  }

  Future<Map<String, dynamic>> getMe() async {
    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("https://freshyfishapi.ydns.eu/api/auth/me"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getFreshwaterFish() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      String? token = await storageService.getToken();
      final response = await http.get(
        Uri.parse('https://freshyfishapi.ydns.eu/api/produk${searchQuery.isNotEmpty ? "?search=$searchQuery" : ""}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['data'] as List<dynamic>;
      } else {
        throw Exception('Failed to load fish data');
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load fish data. Please try again later.';
      });
      return [];
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;
      // freshwaterFish = getFreshwaterFish();
    });
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 20),
                      Image.asset('assets/logo_keranjang_doang.png', scale: 1.2),
                      const SizedBox(width: 10),
                      const Text(
                        'Hi, ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      FutureBuilder(
                        future: me,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text("error");
                          } else {
                            return SizedBox(
                              width: 200,
                              child: Text(
                                "${snapshot.data?["data"]["name"] ?? 'User'}",
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(width: 15),
                      Container(
                        width: 280,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                onChanged: onSearchChanged,
                                decoration: const InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 15),
                        IconButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MainPage()),
                            );
                          },
                          color: const Color.fromARGB(255, 0, 150, 200),
                          icon: const Icon(Icons.arrow_back_rounded, size: 30),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Ikan Tawar',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 150, 200),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<dynamic>>(
                    future: freshwaterFish,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError || errorMessage != null) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Text(errorMessage ?? 'Error loading fish data'),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: Text('No fish found')),
                        );
                      }

                      return SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final fish = snapshot.data![index];
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        fish['image_url'] ?? 'https://via.placeholder.com/150',
                                        height: 90,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      fish['name'] ?? 'Unknown Fish',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Text(
                                      'Rp ${fish['price']?.toString() ?? '0'}',
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
                          },
                          childCount: snapshot.data!.length,
                        ),
                      );
                    },
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