import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';
import 'package:freshy_fish/favorite_page.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => NavbarState();
}

class NavbarState extends State<MainPage> {
  int cuttenIndex = 0;
  List screens = const [
    FavoritePage(),
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            cuttenIndex = 2;
          });
        },
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
        child: const Icon(Icons.home, color: Colors.white, size: 35),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
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
                Icons.grid_view_outlined,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttenIndex = 1;
                });
              },
              icon: const Icon(
                Icons.favorite_border_rounded,
                size: 25,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
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
