import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:http/http.dart' as http;
import 'package:freshy_fish/services/storage_service.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<Map<String, dynamic>> me;
  late Future<Map<String, dynamic>> orderFuture;
  final StorageService storageService = StorageService();
  String? ID_user;

  @override
  void initState() {
    super.initState();
    me = getMe();
    orderFuture = Future.value({});
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

    if (response.statusCode != 200) {
      throw Exception('Failed to get user data: ${response.body}');
    }

    var data = jsonDecode(response.body);
    setState(() {
      ID_user = data["data"]["ID_user"].toString();
      orderFuture = getOrderHistory();
    });
    return data;
  }

  Future<Map<String, dynamic>> getOrderHistory() async {
    if (ID_user == null) throw Exception('User ID not found');

    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("https://freshyfishapi.ydns.eu/api/pesanan/histori/$ID_user"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print(response.body);
      throw Exception('Failed to load order history: ${response.body}');
    }
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return
      Column(
        children: [
        // Status Container
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Completed',
                style: TextStyle(
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                order['order_date'] ?? 'Unknown Date',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),

        Column(
          children: List.generate(
            order['produk'].length,
                (index) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  // Product Details
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://freshyfishapi.ydns.eu/storage/fish_photos/${order['produk'][index]['fish_photo']}' ??
                                      'https://via.placeholder.com/80'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order['produk'][index]['fish_type'] ?? 'Unknown Product',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${order['produk'][index]['pivot']['quantity'] ?? 1} item • ${order['produk'][index]['habitat'] ?? 'Unknown Category'}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Price and Actions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price per Item',
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              'Rp ${order['produk'][index]['fish_price'] ?? '0'}',
                              style: TextStyle(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Buy Again',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
        elevation: 1,
        title: const Text(
          'Order History',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: me,
        builder: (context, meSnapshot) {
          if (meSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (meSnapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${meSnapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(() { me = getMe(); }),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          return FutureBuilder(
            future: orderFuture,
            builder: (context, orderSnapshot) {
              if (orderSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 0, 150, 200),));
              }

              if (orderSnapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Empty.\nPlace Your Order First.',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              final orders = orderSnapshot.data!["order_history"];

              if (orders!.isEmpty) {
                return const Center(
                  child: Text('No order history yet'),
                );
              }

              return Container(
                height: 580,
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) => _buildOrderItem(orders[index]),
                ),
              );


            },
          );
        },
      ),
    );
  }
}