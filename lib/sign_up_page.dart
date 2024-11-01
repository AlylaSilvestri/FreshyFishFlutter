import 'package:flutter/material.dart';
import 'package:freshy_fish/home_page.dart';
import 'package:freshy_fish/log_in_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});


  @override
  State<SignUpPage> createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Color.fromARGB(255, 0, 150, 200),
                  child: Column(
                  children: [
                    SizedBox(height: 90),
                    Image.asset('assets/logo_putih.png', scale: 1.5,),
                    SizedBox(height: 30),
                    Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0), child: Text("Sign in to your account and start buying your fish.", style: TextStyle(fontSize: 17, color: Colors.white),textAlign: TextAlign.center,),),
                    SizedBox(height: 30),
                ],),),
                SizedBox(height: 40),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(Icons.person_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_rounded),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.key_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.key_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (value) {}),
                              Text('Remember me'),
                            ],
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text('Forgot password?'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 47,
                        width: 280,
                        child: FloatingActionButton(
                          onPressed: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogInPage()) );
                          },
                          backgroundColor: Color.fromARGB(255, 0, 150, 200),
                          child: Text('Sign Up', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    TextButton(
                      onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LogInPage()) );
                      },
                      child: Text('Log In', style: TextStyle(color: Color.fromARGB(255, 0, 150, 200))),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
    );
  }
}