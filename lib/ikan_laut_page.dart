import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/fish_detail_page.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:freshy_fish/services/storage_service.dart';

class IkanLautPage extends StatefulWidget {
  const IkanLautPage({super.key});

  @override
  State<IkanLautPage> createState() => IkanLautPageState();
}

class IkanLautPageState extends State<IkanLautPage> {
  late Future<Map<String, dynamic>> me;
  late Future<List<dynamic>> seaFishProducts;
  StorageService storageService = StorageService();
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredProducts = [];
  List<dynamic> allProducts = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    me = getMe();
    seaFishProducts = getSeaFishProducts();
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

  Future<List<dynamic>> getSeaFishProducts() async {
    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("https://freshyfishapi.ydns.eu/api/produk/habitat/Ikan Laut"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      allProducts = data;
      return data;
    } else {
      throw Exception('Failed to load sea fish products');
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
                  const SizedBox(height: 50),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 20),
                      Image.asset('assets/logo_keranjang_doang.png', scale: 1.7),
                      const SizedBox(width: 10),
                      const Text('Hi, ',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
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
                                  icon: const Icon(Icons.clear, color: Colors.grey,)
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
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          },
                          color: const Color.fromARGB(255, 0, 150, 200),
                          icon: const Icon(Icons.arrow_back_rounded, size: 30),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Ikan Laut',
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
                    future: seaFishProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SliverToBoxAdapter(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (snapshot.hasError) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text('Error: ${snapshot.error}'),
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Center(child: Text('No sea fish available')),
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
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            var product = products[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FishDetailPage(
                                      fishName: product['fish_type'],
                                      fishPrice: 'Rp ${product['fish_price'].toString()}',
                                      imageUrl: 'https://freshyfishapi.ydns.eu/storage/fish_photos/${product['fish_photo']}',
                                      fishDesc: product['fish_description'],
                                      productId: product['id'].toString(),
                                      userId: product['ID_toko'].toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Card(
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
                                          'https://freshyfishapi.ydns.eu/storage/fish_photos/${product['fish_photo']}',
                                          height: 90,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error,
                                              stackTrace) =>
                                          const Icon(Icons.image_not_supported),
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        product['fish_type'],
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Rp ${product['fish_price']} /kg',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.cyan,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          childCount: products.length,
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