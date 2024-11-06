import 'package:flutter/material.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/main_page.dart';

class IkanTawarPage extends StatefulWidget {
  const IkanTawarPage({super.key});

  @override
  State<IkanTawarPage> createState() => IkanTawarPageState();
}

class IkanTawarPageState extends State<IkanTawarPage> {
  late Future<dynamic> me;

  @override
  void initState() {
    super.initState();
    // me = getMe();
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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(width: 20),
                      Image.asset('assets/logo_keranjang_doang.png', scale: 1.2),
                      const SizedBox(width: 10),
                      Text('Hi, ', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('User', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 320,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 15),
                        FloatingActionButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainPage()) );
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          backgroundColor: Colors.blue, // Set background color to blue
                          child: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
                        ),
                        SizedBox(width: 10),
                        const Text(
                          'Ikan Tawar',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Set text color
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1,
                    ),
                    delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          if (index == 0) {
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Javaen_barb.jpg/375px-Javaen_barb.jpg', // Replace with the actual image URL
                                        height: 90,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Ikan Payau",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    const Text(
                                      "Rp 60.000",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }  else {
                            return Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        'https://www.deheus.id/siteassets/news/article/mengenal-ikan-bandeng/bandeng-hero-2.jpg?mode=crop&width=2552&height=1367', // Replace with a different image URL
                                        height: 90,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Ikan Bandeng",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[800],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    const Text(
                                      "Rp 25.000 /kg", // Different price
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.cyan,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          // Return an empty container for other indices
                        },
                        childCount: 4), // Set the number of children here

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
