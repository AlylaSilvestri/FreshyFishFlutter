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
                    const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        child: Text(
                          'johndoe@example.com',
                          style: TextStyle(
                            fontSize: 16.0, // Font size for the email
                            fontWeight: FontWeight.bold, // Make the text bold
                            color: Colors.white, // Change the text color
                            letterSpacing: 1.2, // Add letter spacing for better readability
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Saved Addresses'),
                onTap: () {
                  // Go to saved addresses page
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              ListTile(
                title: const Text('Order History'),
                onTap: () {
                  // Go to order history page
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
              ListTile(
                title: const Text('Create Store'),
                onTap: () {
                  // Go to create store page
                },
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
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
