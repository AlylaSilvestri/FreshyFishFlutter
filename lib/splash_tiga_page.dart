import 'package:flutter/material.dart';
import 'package:freshy_fish/log_in_page.dart';
import 'package:freshy_fish/sign_up_page.dart';

class SplashTigaPage extends StatelessWidget {
  const SplashTigaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 120,),
              Image.asset('assets/logo_black.png'),
              const SizedBox(height: 30),
              Image.asset('assets/splash3.png', scale: 1.5),
              const SizedBox(height: 100),
              const Text("Let’s Get Started!!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 20), child: Text("Order your favorite consumable fish anytime, anywhere, and enjoy the freshness all the way home!", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInPage()) );
                  },
                  backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                  child: const Text("Log In", style: TextStyle(color: Colors.white),),),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()) );
                  },
                  backgroundColor: Colors.white,
                  child: const Text("Sign Up", style: TextStyle(color: Color.fromARGB(255, 0, 150, 200)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }


}