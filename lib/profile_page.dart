import 'package:flutter/material.dart';
import 'package:freshy_fish/profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 0, 150, 200),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset('assets/logo_putih.png', scale: 1.5),
                    const SizedBox(height: 20),
                    const CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHDT8TZp9Ized8FRjPMwrliwxAbd6JqlxZqQ&s',
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child: Text(
                          "User Name",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(20, 15, 0, 0),
                child:Text(
                  'Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Jln Sancang Dalam no. 5, kel. Kijang Besar, kec. Bogor Utara'
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child:Text(
                  'Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                    'del@gmail.com'
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child:Text(
                  'Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  children: [
                    Text(
                      '*************',
                      style: TextStyle(fontSize: 18), // Optional styling for text
                    ),
                    SizedBox(width: 180), // Spacing between text and icon
                    Icon(
                      Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                      size: 25,
                    ),
                  ],
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child:Text(
                  'Store', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0), child: SizedBox(
                height: 47,
                width: 321,
                child: FloatingActionButton(
                  onPressed: (){},
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 2), // Blue border
                    borderRadius: BorderRadius.circular(10), // Ensures circular shape
                  ),
                ),
              ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                  padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200), // Set button color
                        ),
                        child: const Text(
                          'Edit',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200), // Set button color
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
