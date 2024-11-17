import 'package:flutter/material.dart';
import 'package:freshy_fish/confirm_order_page.dart';
import 'main_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  int _counter = 1;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 1) {
        _counter--;
      }
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
                    children: [
                      const SizedBox(width: 20),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MainPage()));
                        },
                        child: const Icon(Icons.arrow_back_rounded,
                            color: Colors.white, size: 35),
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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                                  image: const DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        'https://images.tokopedia.net/img/cache/700/VqbcmM/2021/11/17/534aa259-44f5-4e5d-935e-d9cd60f0eaf9.png'),
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                                        child: const Text(
                                          'Lele',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: 120),
                                      IconButton(
                                          onPressed: (){},
                                          icon: Icon(Icons.delete, color: Colors.red)
                                      ),
                                    ],
                                  ),

                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: const Text(
                                      'Beli ges',
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                        child: const Text(
                                          'Rp 80.000',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.cyan),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              _decrementCounter();
                                            },
                                            icon: const Icon(Icons.remove_circle,
                                                color: Colors.orange),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 3),
                                            child: Text(
                                              '$_counter',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              _incrementCounter();
                                            },
                                            icon: const Icon(Icons.add_circle,
                                                color: Colors.orange),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 197,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 150, 200),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
              ),
              child: Padding(
                  padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ongkir',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rp 1.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rp 10.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Rp 111.000.000',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfirmOrderPage()),
                        );
                      },
                        child: Text('ayo checkout', style: TextStyle(color: Colors.deepPurple)),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        minimumSize: WidgetStateProperty.all(Size(300, 40)),
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
