import 'package:flutter/material.dart';
import 'package:freshy_fish/Models/user.dart';
import 'package:freshy_fish/log_in_page.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool passwordVisible = false;
  User user = User();

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
                    const SizedBox(height: 55),
                    Image.asset(
                      'assets/logo_putih.png',
                      scale: 1.5,
                    ),
                    const SizedBox(height: 30),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Text(
                        "Sign in to your account and start buying your fish.",
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
                      onChanged: (name) {
                        user.name = name;
                      },
                      decoration: InputDecoration(
                        labelText: 'Name',
                        prefixIcon: const Icon(Icons.person_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (email) {
                        user.email = email;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (phone_number) {
                        user.phone_number = phone_number;
                      },
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: const Icon(Icons.phone_rounded),
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
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.key_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (passwordConfirmation) {
                        user.password_confirmation = passwordConfirmation;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.key_sharp),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      height: 47,
                      width: 280,
                      child: FloatingActionButton(
                        onPressed: () {
                          http
                              .post(
                            Uri.parse(
                                'https://freshyfishapi.ydns.eu/api/auth/register'),
                            headers: <String, String>{
                              'Content-Type': 'application/json'
                            },
                            body: user.registertojson(),
                          )
                              .then((response) {
                            if (response.statusCode == 201) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogInPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      "Invalid username or password!"),
                                ),
                              );
                            }
                          });
                        },
                        backgroundColor:
                        const Color.fromARGB(255, 0, 150, 200),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 150, 200),
                      ),
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
