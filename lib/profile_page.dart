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
    var response = await http.get(
        Uri.parse("https://freshyfishapi.ydns.eu/api/auth/me"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': "Bearer $token"
        });
    return jsonDecode(response.body);
  }

  Widget _buildInfoCard({
    required String title,
    required Future<Map<String, dynamic>> future,
    required String dataKey,
    String? defaultText,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[700],
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder(
              future: future,
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 0, 150, 200),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Error loading data',
                    style: TextStyle(color: Colors.red[300]),
                  );
                } else {
                  final value = snapshot.data["data"][dataKey] ?? defaultText;
                  return Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueGrey[600],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 50.0,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: SizedBox(
                width: 200, // Specify desired width
                child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                  child: FutureBuilder(
                    future: me,
                    builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Text('Profile');
                      } else {
                        return Text(
                          snapshot.data["data"]["name"],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 0, 150, 200),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 16),
              _buildInfoCard(
                title: 'Address',
                future: me,
                dataKey: 'address',
                defaultText: 'No address added',
              ),
              _buildInfoCard(
                title: 'Email',
                future: me,
                dataKey: 'email',
              ),
              _buildInfoCard(
                title: 'Phone',
                future: me,
                dataKey: 'phone_number',
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child:
                ListTile(
                  title: Text(
                    'Visit Store',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  trailing: Icon(Icons.open_in_browser, color: Colors.blueGrey[600]),
                  onTap: () async {
                    final Uri url = Uri.parse('https://freshyfishapp.ydns.eu/auth/login');
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not launch $url'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white,
                child:
                ListTile(
                  title: Text(
                    'See Articles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                  trailing: Icon(Icons.article_outlined, color: Colors.blueGrey[600]),
                  onTap: () async {
                    final Uri url = Uri.parse('https://freshyfishapp.ydns.eu');
                    if (!await launchUrl(url)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not launch $url'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileEditPage()),
                          );
                        },
                        icon: const Icon(Icons.edit, color: Colors.white),
                        label: const Text('Edit Profile', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LogInPage()),
                          );
                        },
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text('Logout', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ],
      ),
    );
  }
}
