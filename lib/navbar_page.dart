import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';
import 'package:freshy_fish/favorite_page.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/profile_page.dart';

class NavbarPage extends StatefulWidget {
  const NavbarPage({super.key});

  @override
  State<NavbarPage> createState() => NavbarState();
}

class NavbarState extends State<NavbarPage> {
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
