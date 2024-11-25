import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/fish_detail_page.dart';
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
  late Future<List<Map<String, dynamic>>> produk;
  String? ID_user;
  StorageService storageService = StorageService();
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> filteredProducts = [];
  List<Map<String, dynamic>> allProducts = [];
  bool isLoading = false;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    me = getMe();
    produk = getProduk();
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
    var data = jsonDecode(response.body);
    setState(() {
      ID_user = data["data"]["ID_user"].toString();
      print(ID_user);
    });
    return data;
  }

  Future<List<Map<String, dynamic>>> getProduk() async {
    setState(() => isLoading = true);
    try {
      String? token = await storageService.getToken();
      var response = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/produk"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = jsonDecode(response.body);
        var products = data.map((item) => item as Map<String, dynamic>).toList();
        setState(() {
          allProducts = products;
          filteredProducts = products;
        });
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  void filterProducts(String query) {
    setState(() {
      isSearching = query.isNotEmpty;
      if (query.isEmpty) {
        filteredProducts = allProducts;
      } else {
        filteredProducts = allProducts.where((product) {
          final fishType = product['fish_type'].toString().toLowerCase();
          final searchLower = query.toLowerCase();
          return fishType.contains(searchLower);
        }).toList();
      }
    });
  }

  void clearSearch() {
    setState(() {
      searchController.clear();
      filteredProducts = allProducts;
      isSearching = false;
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
                  const SizedBox(height: 45),
                  Row(
                    children: [
                      const SizedBox(width: 20),
                      Image.asset('assets/logo_keranjang_doang.png', scale: 1.7),
                      const SizedBox(width: 25),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hi,',
                            style: TextStyle(
                              fontSize: 20,
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
                                return Text("Error: ${snapshot.error}");
                              } else {
                                return SizedBox(
                                  width: 200,
                                  height: 40,
                                  child: Text(
                                    snapshot.data?["data"]?["name"] ?? "User",
                                    style: const TextStyle(
                                      fontSize: 20,
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
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartPage()),
                          );
                        },
                        icon: const Icon(
                          Icons.shopping_cart_outlined,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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
                                controller: searchController,
                                onChanged: filterProducts,
                                decoration: const InputDecoration(
                                  hintText: "Search...",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            if (isSearching)
                              IconButton(
                                  onPressed: clearSearch,
                                  icon: const Icon(Icons.clear, color: Colors.grey),
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
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
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
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 5),
                  ),
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: produk,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting || isLoading) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return SliverFillRemaining(
                          child: Center(child: Text('Error: ${snapshot.error}')),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SliverFillRemaining(
                          child: Center(child: Text('No products available')),
                        );
                      }

                      var products = isSearching ? filteredProducts : snapshot.data!;

                      if (products.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                'No fish found matching your search',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
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
                            final product = products[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => FishDetailPage(
                                    fishName: product['fish_type'] ?? 'Unknown',
                                    fishPrice: 'Rp ${product['fish_price']?.toString() ?? '0'}',
                                    imageUrl: "https://freshyfishapi.ydns.eu/storage/fish_photos/${product["fish_photo"]}" ?? '',
                                    fishDesc: "${product["fish_description"]}" ?? "",
                                    productId: product['ID_produk']?.toString() ?? '',
                                    userId: 'ID_user' ?? '',
                                  )
                                  ),
                                );
                              },
                              child: fishCard(
                                imageUrl: "https://freshyfishapi.ydns.eu/storage/fish_photos/${product["fish_photo"]}" ?? '',
                                title: product['fish_type'] ?? 'Unknown',
                                price: 'Rp ${product['fish_price']?.toString() ?? '0'}',
                              ),
                            );
                          },
                          childCount: products.length,
                        ),
                      );
                    },
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 90,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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