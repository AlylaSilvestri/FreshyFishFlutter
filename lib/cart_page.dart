import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/confirm_order_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'main_page.dart';

class CartPage extends StatefulWidget {
  final String? userId;
  const CartPage({super.key, this.userId});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late Future<Map<String, dynamic>> me;
  late Future<List<Map<String, dynamic>>> keranjang;
  final StorageService storageService = StorageService();
  bool isLoading = false;
  double totalPrice = 0;
  double shippingCost = 0;

  @override
  void initState() {
    super.initState();
    me = getMe();
    keranjang = getKeranjang();
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

  Future<List<Map<String, dynamic>>> getKeranjang() async {
    setState(() => isLoading = true);
    try {
      String? token = await storageService.getToken();
      var response = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/keranjang?user_id=${widget.userId}"),
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
        throw Exception('Failed to load cart items');
      }
    } catch (e) {
      throw Exception('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> updateQuantity(String cartItemId, int quantity) async {
    try {
      String? token = await storageService.getToken();
      var response = await http.put(
        Uri.parse("https://freshyfishapi.ydns.eu/api/keranjang/$cartItemId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode({'quantity': quantity}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          keranjang = getKeranjang();
        });
      } else {
        throw Exception('Failed to update quantity');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<void> deleteCartItem(String cartItemId) async {
    try {
      String? token = await storageService.getToken();
      var response = await http.delete(
        Uri.parse("https://freshyfishapi.ydns.eu/api/cart/$cartItemId"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          keranjang = getKeranjang();
        });
      } else {
        throw Exception('Failed to delete item');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  void calculateTotals(List<dynamic> items) {

    double subtotal = 0;
    for (var item in items) {
      double price = 0;
      if(item['fish_price'] != null){
        String priceStr = item['fish_price'].toString()
            .replaceAll('Rp ', '')
            .replaceAll(',', '');

        try {
          price = double.parse(priceStr);
        } catch(e){
          print('Error parsing price: $e');
          price = 0;
        }
      }
      int quantity = item['order_quantity'] ?? 1;
      subtotal += price * quantity;
      }
    shippingCost = 10000;

    setState(() {
      totalPrice = subtotal + shippingCost;
    });
    //   subtotal += (item['fish_price'] ?? 0) * (item['order_quantity'] ?? 1);
    // }
    // shippingCost = 10000; // Fixed shipping cost
    // setState(() {
    //   totalPrice = subtotal + shippingCost;
    // });
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: keranjang,
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
                                          "https://freshyfishapi.ydns.eu/storage/fish_photos/${item['fish_photo']}",
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
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              onPressed: () => deleteCartItem(
                                                  item['id'].toString()),
                                              icon: const Icon(Icons.delete,
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Text(
                                            item['fish_description'] ?? '',
                                            style:
                                            const TextStyle(fontSize: 15),
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
                                                'Rp ${item['fish_price']?.toString() ?? '0'}',
                                                style: const TextStyle(
                                                  fontSize: 18,
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
                                                    if (item['quantity'] > 1) {
                                                      updateQuantity(
                                                        item['ID_produk'].toString(),
                                                        item['order_quantity'] - 1,
                                                      );
                                                    }
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
                                                    '${item['order_quantity']}',
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
                                                      item['order_quantity'] + 1,
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
                          'Shipping Cost',
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ConfirmOrderPage(),
                          ),
                        );
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