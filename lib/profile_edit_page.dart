import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/Models/user.dart';
import 'package:freshy_fish/log_in_page.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:freshy_fish/profile_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  bool passwordVisible = false;
  StorageService storageService = StorageService();
  User user = new User();
  late String id;

  @override
  void initState() {
    super.initState();
    getMe();
  }

  Future<void> updateAddress() async {
    StorageService storageService = StorageService();
    String? token = await storageService.getToken();

    final response = await http.put(
      Uri.parse('https://freshyfishapi.ydns.eu/api/auth/user/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        'Accept': 'application/json'
      },
      body: user.updatetojson()
    );

    if (response.statusCode == 200) {
      // Navigate back to profile page after successful update
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to update address')),
      );
    }
  }

  void getMe() async {
    String? token = await storageService.getToken();
    var response = await http.get(
      Uri.parse("https://freshyfishapi.ydns.eu/api/auth/me"),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': "Bearer $token",
      },
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    setState(() {
      user.name = data["data"]["name"];
      user.email = data["data"]["email"];
      user.address = data["data"]["address"];
      user.phone_number = data["data"]["phone_number"];
      id = data["data"]["ID_user"].toString();
      print(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 0, 150, 200),
        title: Image.asset('assets/logo_putih.png', scale: 1.5),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: const Color.fromARGB(255, 0, 150, 200),
                child:
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHDT8TZp9Ized8FRjPMwrliwxAbd6JqlxZqQ&s',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "User Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    user.address = value;
                  },
                  style: TextStyle(fontSize: 13),
                  controller: TextEditingController(text: user.address),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 50),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    user.email = value;
                  },
                  controller: TextEditingController(text: user.email),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 50),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Phone",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value){
                    user.phone_number = value;
                  },
                  controller: TextEditingController(text: user.phone_number),
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    user.password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: (value) {
                    user.password_confirmation = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    constraints: const BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          updateAddress();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200), // Set button color
                        ),
                        child: const Text(
                          'Save',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          String? token = await storageService.getToken();
                          http.delete(Uri.parse("https://freshyfishapi.ydns.eu/api/auth/delete"),
                            headers: <String, String>{
                              'Content-Type': 'application/json',
                              'Authorization': "Bearer $token",
                            }).then((response) {
                            if (response.statusCode == 200){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogInPage()));
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something Went Wrong!")));
                            }
                          });
                          },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 220, 0, 0), // Set button color
                        ),
                        child: const Text(
                          'Delete Account',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
