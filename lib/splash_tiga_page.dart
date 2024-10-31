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
              SizedBox(height: 120,),
              Image.asset('assets/logo_black.png'),
              SizedBox(height: 320,),
              Text("Let’s Get Started!!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.fromLTRB(14, 0, 14, 20), child: Text("Order your favorite consumable fish anytime, anywhere, and enjoy the freshness all the way home!", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()) );
                  },
                  backgroundColor: Color.fromARGB(255, 0, 150, 200),
                  child: Text("Log In", style: TextStyle(color: Colors.white),),),
              ),
              SizedBox(height: 8),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()) );
                  },
                  backgroundColor: Colors.white,
                  child: Text("Sign Up", style: TextStyle(color: Color.fromARGB(255, 0, 150, 200)),
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