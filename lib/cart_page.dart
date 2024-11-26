import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/confirm_order_page.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/order_review_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:freshy_fish/udah_beli_page.dart';
import 'package:http/http.dart' as http;
import 'main_page.dart';
import 'package:intl/intl.dart';

class CartPage extends StatefulWidget {
  final String? userId;
  final String? productId;
  const CartPage({super.key, this.userId, this.productId});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> keranjangFuture;
  late Future<Map<String, dynamic>> me;
  // late Future<List<Map<String, dynamic>>> keranjang;
  final StorageService storageService = StorageService();
  bool isLoading = false;
  double totalPrice = 0;
  double shippingCost = 0;
  String? ID_user;
  String? ID_product;

  @override
  void initState() {
    super.initState();
    keranjangFuture = Future.value([]);
    me = getMe();
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
      keranjangFuture = getKeranjang();
    });
    return data;
  }

  Future<List<Map<String, dynamic>>> getKeranjang() async {
    setState(() => isLoading = true);
    try {
      String? token = await storageService.getToken();
      var response = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/detail-keranjang/$ID_user"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> data = jsonDecode(response.body);
        calculateTotals(data);
        return data.map((item) => item as Map<String, dynamic>).toList();
      } else {
        print(response.body);
        print('Error response: ${response.body}');
        throw Exception('Failed to load cart: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    setState(() => isLoading = true);
    try {
      String? token = await storageService.getToken();

      var cartDetailsResponse = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/users/$ID_user/cart-details"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (cartDetailsResponse.statusCode == 200){
        var cartDetails = jsonDecode(cartDetailsResponse.body);
        String cartId = cartDetails['ID_keranjang'].toString();

        var response = await http.put(
          Uri.parse("https://freshyfishapi.ydns.eu/api/detail-keranjang/$cartId"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': "Bearer $token",
          },
          body: jsonEncode({
            'ID_produk': productId,
            'quantity': quantity + 1
          }),
        );

        if (response.statusCode == 200) {
          print(response.body);
          final updatedData = await getKeranjang();
          setState(() {
            keranjangFuture = Future.value(updatedData);
            isLoading = false;
          });
        } else {
          print(response.body);
          throw Exception('Failed to update quantity: ${response.body}');
        }
      }
    } catch (e) {
      print('Error updateing quantity: $e');
      throw Exception('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> reduceQuantity(String productId, int currentQuantity) async {
    setState(() => isLoading = true);
    try {
      String? token = await storageService.getToken();

      var cartDetailsResponse = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/users/$ID_user/cart-details"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (cartDetailsResponse.statusCode == 200) {
        var cartDetails = jsonDecode(cartDetailsResponse.body);
        String cartId = cartDetails['ID_keranjang'].toString();

        if (currentQuantity <= 1) {
          // Delete the item if quantity would become 0
          var response = await http.delete(
            Uri.parse("https://freshyfishapi.ydns.eu/api/detail-keranjang/$cartId"),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': "Bearer $token",
            },
          );

          if (response.statusCode == 200) {
            final updatedData = await getKeranjang();
            setState(() {
              keranjangFuture = Future.value(updatedData);
            });
          }
        } else {
          // Reduce quantity by 1
          var response = await http.put(
            Uri.parse("https://freshyfishapi.ydns.eu/api/detail-keranjang/$cartId"),
            headers: <String, String>{
              'Content-Type': 'application/json',
              'Authorization': "Bearer $token",
            },
            body: jsonEncode({
              'ID_produk': productId,
              'quantity': currentQuantity - 1
            }),
          );

          if (response.statusCode == 200) {
            final updatedData = await getKeranjang();
            setState(() {
              keranjangFuture = Future.value(updatedData);
            });
          }
        }
      }
    } catch (e) {
      print('Error reducing quantity: $e');
      throw Exception('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      String? token = await storageService.getToken();
      var response = await http.delete(
        Uri.parse("https://freshyfishapi.ydns.eu/api/keranjang/$cartItemId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          keranjangFuture = getKeranjang();
        });
      } else {
        print(response.body);
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void calculateTotals(List<dynamic> items) {
    double subtotal = 0;
    for (var item in items) {

      if (item['produk'] != null && item['produk']['fish_price'] != null) {
        String priceStr = item['produk']['fish_price'].toString();

        try {
          double price = double.parse(priceStr);
          int quantity = item['quantity'] ?? 1;
          subtotal += price * quantity;
        } catch (e) {
          print('Error parsing price: $e');
        }
      }
    }

    shippingCost = 3500;
    setState(() {
      totalPrice = subtotal + shippingCost;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Column(
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainPage(),
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        'Your Order',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(
              height: 450,
              child: FutureBuilder(
                future: keranjangFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('Your cart is empty'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final item = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(
                                          "https://freshyfishapi.ydns.eu/storage/fish_photos/${item['produk']['fish_photo']}",
                                        ),
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 10, 0, 0),
                                              child: Text(
                                                item['produk']['fish_type'] ?? 'Unknown',
                                                style: const TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            item['produk']['fish_description'] ?? '',
                                            style:
                                            const TextStyle(fontSize: 14),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              child: Text(
                                                'Rp ${item['produk']['fish_price']?.toString() ?? '0'}',
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.cyan,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    reduceQuantity(
                                                      item['ID_produk'].toString(),
                                                      item['quantity'],
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 3),
                                                  child: Text(
                                                    '${item['quantity']}',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    updateQuantity(
                                                      item['ID_produk'].toString(),
                                                      item['quantity'],
                                                    );
                                                  },
                                                  icon: const Icon(
                                                    Icons.add_circle,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 197,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 150, 200),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Handling Fees',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rp ${shippingCost.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rp ${totalPrice.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String? token = await storageService.getToken();
                        await http.post(
                          Uri.parse("https://freshyfishapi.ydns.eu/api/pesanan/buatpesanan"),
                          headers: <String, String>{
                            'Accept': 'application/json',
                            'Content-Type': 'application/json',
                            'Authorization': "Bearer $token",
                          },
                          body: jsonEncode({'payment_method': 'QRIS'}),
                        ).then((response) {
                          if (response.statusCode == 201) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => UdahBeliPage(),
                            ));
                          } else if (response.statusCode == 400) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response.body[0]),
                              ),
                            );
                          } else {
                            print(response.body);
                            print("Gagal Karena Adel");
                          }
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.white),
                        minimumSize:
                        MaterialStateProperty.all(const Size(300, 40)),
                      ),
                      child: const Text(
                        'Checkout',
                        style: TextStyle(color: Colors.deepPurple),
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