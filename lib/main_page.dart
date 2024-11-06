import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';
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
    HomePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[cuttenIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                size: 35,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       cuttenIndex = 1;
            //     });
            //   },
            //   icon: const Icon(
            //     Icons.favorite_border_rounded,
            //     size: 25,
            //     color: Color.fromARGB(255, 0, 150, 200),
            //   ),
            // ),
            IconButton(
              onPressed: () {
                setState(() {
                  cuttenIndex = 1;
                });
              },
              icon: const Icon(
                Icons.shopping_cart_checkout_rounded,
                size: 35,
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
                Icons.person_2_outlined,
                size: 35,
                color: Color.fromARGB(255, 0, 150, 200),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
