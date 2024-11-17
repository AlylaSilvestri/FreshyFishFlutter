import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => OrderHistoryPageState();
}

class OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                    Text('Your Order History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(
            height: 550,
            child: ListView.builder(
              itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all( // This adds the border
                          color: const Color.fromARGB(255, 0, 150, 200), // Border color
                          width: 2.0,        // Border width
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(10),
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/11/17/534aa259-44f5-4e5d-935e-d9cd60f0eaf9.png'),
                              ),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10)),
                              border: Border.all( // This adds the border
                                color: Colors.grey, // Border color
                                width: 1.0,        // Border width
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: const Text(
                                  'Lele',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: const Text(
                                  'Ikan Tawar',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: const Text(
                                  'Total 1 produk: Rp 90.000',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 7), // Adjust padding as needed
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder: (context) => const CartPage()));
                                  },
                                  child: Text(
                                    'beli lagi yu',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 0, 150, 200),
                                    ),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10), // Circular border with radius 10
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

}