import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/log_in_page.dart';
import 'package:freshy_fish/profile_edit_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> me;
  StorageService storageService = StorageService();

  @override
  void initState() {
    super.initState();
    me = getMe();
  }

  Future<Map<String, dynamic>> getMe() async {
    StorageService storageService = StorageService();
    String? token = await storageService.getToken();

    var response = await http.get(Uri.parse("https://freshyfishapi.ydns.eu/api/auth/me"), headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': "Bearer $token"
    });
    return jsonDecode(response.body);
  }



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
                height: 90,
                color: const Color.fromARGB(255, 0, 150, 200),
                child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(height: 45),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            Align(
                              child:
                              FutureBuilder(
                                  future: me,
                                  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const CircularProgressIndicator(
                                        color: Color.fromARGB(255, 0, 150, 200), // Your app's blue color
                                        backgroundColor: Colors.white,
                                      );
                                    } else if (snapshot.hasError) {
                                      return const Text("error");
                                    } else {
                                      return Text("${snapshot.data["data"]["name"]}", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,
                                      );
                                    }
                                  }
                              ),
                            ),
                          ],
                        ),
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
                child: FutureBuilder(
                    future: me,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 150, 200), // Your app's blue color
                          backgroundColor: Colors.white,
                        );
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      } else {
                        return Text("${snapshot.data["data"]["address"] ?? '[Your Address is not Added Yet]'}",);
                      }
                    }
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
                child: FutureBuilder(
                    future: me,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 150, 200), // Your app's blue color
                          backgroundColor: Colors.white,
                        );
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      } else {
                        return Text("${snapshot.data["data"]["email"]}"
                        );
                      }
                    }
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child:Text(
                  'Phone', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              const Divider(endIndent: 20, indent: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: FutureBuilder(
                    future: me,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 150, 200), // Your app's blue color
                          backgroundColor: Colors.white,
                        );
                      } else if (snapshot.hasError) {
                        return const Text("error");
                      } else {
                        return Text("${snapshot.data["data"]["phone_number"]}",
                        );
                      }
                    }
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
                  onPressed: () async {
                    final Uri url = Uri.parse('https://freshyfishapp.ydns.eu/');
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.add_rounded,
                    color: Colors.black,
                    size: 25,
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Color.fromARGB(255, 0, 150, 200), width: 2),
                    borderRadius: BorderRadius.circular(10),
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LogInPage()),
                          );
                        },
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
