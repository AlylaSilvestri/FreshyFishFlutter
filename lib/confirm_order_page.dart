import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ConfirmOrderPage extends StatefulWidget {
  const ConfirmOrderPage({super.key});
  @override
  ConfirmOrderPageState createState() => ConfirmOrderPageState();
}

class ConfirmOrderPageState extends State<ConfirmOrderPage> {
  late Future<Map<String, dynamic>> me;
  late Future<Map<String, dynamic>> orderDetails;
  StorageService storageService = StorageService();
  bool isLoading = false;
  String selectedPaymentMethod = 'transfer';


  @override
  void initState() {
    super.initState();
    me = getMe();
    orderDetails = getOrderDetails();
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

  Future<Map<String, dynamic>> getOrderDetails() async {
    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("https://freshyfishapi.ydns.eu/api/pesanan/buatpesanan"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    return jsonDecode(response.body);
  }

  void showMessage(String message, bool isError) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: isError ? 3 : 5),
      ),
    );
  }

  Future<void> confirmOrder() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storageService.getToken();
      final response = await http.post(
        Uri.parse("https://freshyfishapi.ydns.eu/api/pesanan/buatpesanan"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token",
        },
        body: jsonEncode({
          'payment_method' : selectedPaymentMethod,
         }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if(responseData['virtual_account'] != null){
          showMessage(
            'Order created successfully!\nVirtual Account: ${responseData['virtual_account']}',
          false
          );
        }
        Navigator.pushReplacementNamed(context, '/order-success');
      } else {
        final errorMessage = responseData['message'] ?? 'Failed to create order. Please try again.';
        showMessage(errorMessage, true);
      }
      } catch (e) {
      showMessage('An error occured: ${e.toString()}', true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool validateOrder(Map<String, dynamic> orderData, Map<String, dynamic> userData) {
    if (userData['data']['address'] == null || userData['data']['address'].toString().isEmpty) {
      showMessage('Please add your delivery address before placing an order', true);
      return false;
    }

    final items = orderData['data']['items'] as List<dynamic>? ?? [];
    if (items.isEmpty) {
      showMessage('Your cart is empty', true);
      return false;
    }

    if (selectedPaymentMethod.isEmpty) {
      showMessage('Please select a payment method', true);
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white,)
        ),
        title: const Text("Order Summary", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Delivery Address Section
              FutureBuilder(
                future: me,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 150, 200),
                    ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error loading address");
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${snapshot.data?["data"]["address"] ?? '[Your Address is not Added Yet]'}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  }
                },
              ),
              const Divider(height: 32),
              FutureBuilder(
                future: orderDetails,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 0, 150, 200),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Error loading order details");
                  } else {
                    final orderData = snapshot.data?["data"] ?? {};
                    final items = orderData["items"] as List<dynamic>? ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Order Details",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Order Items
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return ListTile(
                              title: Text(item["fish_type"], style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("${item["quantity"]} x \$${item["fish_price"]}", style: TextStyle(
                                color: Colors.cyan[600],
                              ),
                              ),
                              trailing: Text(
                                "\$${(item["quantity"] * item["price"]).toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            );
                          },
                        ),

                        const Divider(height: 32),

                        // Order Summary
                        DetailRow(
                          "Order Date",
                          DateTime.parse(orderData["created_at"] ?? DateTime.now().toString())
                              .toString().split('.')[0],
                        ),
                        DetailRow("Status", orderData["status"] ?? "Pending"),
                        DetailRow("Payment Method",
                            orderData["payment_method"] ?? "Not selected"),
                        if (orderData["virtual_account"] != null)
                          DetailRow("Virtual Account", orderData["virtual_account"]),
                        const Divider(height: 16),
                        DetailRow(
                          "Total Amount",
                          "\$${orderData["total_price"]?.toStringAsFixed(2) ?? "0.00"}",
                          isTotal: true,
                        ),
                        const SizedBox(height: 32),
                        // Confirm Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : confirmOrder,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              disabledBackgroundColor: Colors.grey,
                            ),
                            child: isLoading ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ) :
                            const Text(
                              "Confirm Order",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatefulWidget {
  final String label;
  final String value;
  final bool isTotal;

  const DetailRow(this.label, this.value, {this.isTotal = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.black : Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color.fromARGB(255, 0, 150, 200) : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}