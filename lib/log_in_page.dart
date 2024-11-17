import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:freshy_fish/main_page.dart';
import 'package:freshy_fish/services/storage_service.dart';
import 'package:freshy_fish/sign_up_page.dart';
import 'package:http/http.dart' as http;

import 'Models/user.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  User user = User();
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: const Color.fromARGB(255, 0, 150, 200),
                child: Column(
                  children: [
                    const SizedBox(height: 90),
                    Image.asset(
                      'assets/logo_putih.png',
                      scale: 1.5,
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        "Log in to your account and start buying your fish.",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (email) {
                        user.email = email;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (password) {
                        user.password = password;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password (min: 6)',
                        prefixIcon: const Icon(Icons.lock_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: isRememberMe,
                              onChanged: (value) {
                                setState(() {
                                  isRememberMe = value!;
                                });
                              },
                            ),
                            const Text("Remember me"),
                          ],
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 47,
                      width: 280,
                      child: FloatingActionButton(
                        onPressed: () {
                          http
                              .post(
                            Uri.parse(
                                'https://freshyfishapi.ydns.eu/api/auth/login'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: user.logintojson(),
                          )
                              .then((response) {
                            if (response.statusCode == 200) {
                              var res = jsonDecode(response.body);
                              StorageService().saveToken(res["token"]);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Invalid username or password!"),
                                ),
                              );
                            }
                          });
                        },
                        backgroundColor:
                        const Color.fromARGB(255, 0, 150, 200),
                        heroTag: "button_login",
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style:
                      TextStyle(color: Color.fromARGB(255, 0, 150, 200)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
