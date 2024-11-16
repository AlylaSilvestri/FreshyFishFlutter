import 'package:flutter/material.dart';
import 'package:freshy_fish/cart_page.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/order_history_page.dart';
import 'package:freshy_fish/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => NavbarState();
}

class NavbarState extends State<MainPage> {
  int selectedIndex = 0;
  List<Widget> page = <Widget>[
    HomePage(),
    OrderHistoryPage(),
    ProfilePage(),
  ];

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 350,
        height: 70,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 150, 200),
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            backgroundColor: Colors.transparent,
            indicatorColor: Color.fromARGB(250, 0, 140, 200),
            indicatorShape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            onDestinationSelected: (int index) {
              setState(() {
                selectedIndex = index;
                _pageController.animateToPage(page.indexOf(page[index]),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut);
              });
            },
            destinations: [
              NavigationDestination(
                  icon: Icon(Icons.home, color: Colors.white, size: 30),
                  label: 'Home'),
              NavigationDestination(
                icon: Icon(Icons.history_rounded, color: Colors.white, size: 30),
                label: 'Order History',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_rounded, color: Colors.white, size: 30),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration:
        const BoxDecoration(color: Color.fromARGB(255, 241, 244, 249)),
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                children: page,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
