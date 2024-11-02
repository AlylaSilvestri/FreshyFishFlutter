import 'package:flutter/material.dart';
import 'package:freshy_fish/profile_edit_page.dart';
import 'package:freshy_fish/profile_page.dart';
import 'cart_page.dart';
import 'detail_page.dart';
import 'favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int cuttenIndex = 0;
  List screens = const [
    DetailPage(),
    FavoritePage(),
    HomePage(),
    CartPage(),
    ProfileEditPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: Color.fromARGB(255, 0, 150, 200),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Row(
                      children: [
                        SizedBox(width: 20 ),
                        Image.asset('assets/logo_keranjang_doang.png', scale: 1.2),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Hi,', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                            Text('User', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 10),

                    Container(
                      width: 320,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 30,
                          ),
                          SizedBox(width: 10), Flexible(
                              child: TextField(
                                decoration: InputDecoration(hintText: "Search...",
                                border: InputBorder.none),
                              ),
                          ),

                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child:
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Image.asset("assets/banner.jpg"),
                      ),
                    ),
                    SliverGrid(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10, childAspectRatio: 1),
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Card(
                              child: Text("Test")
                          );
                        },
                        childCount: 10))
                  ],
                ),
              ),
            ],
          ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        color: Colors.white,
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  cuttenIndex = 0;
                });
              },
              icon: const Icon(
                Icons.home_outlined,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()) );
                setState(() {
                  cuttenIndex = 2;
                });
              },
              icon: const Icon(
                Icons.favorite_border_rounded,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()) );
                setState(() {
                  cuttenIndex = 3;
                });
              },
              icon: const Icon(
                Icons.shopping_cart_checkout_rounded,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()) );
                setState(() {
                  cuttenIndex = 4;
                });
              },
              icon: const Icon(
                Icons.person_2_outlined,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

