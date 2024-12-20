import 'package:flutter/material.dart';
import 'package:freshy_fish/splash_dua_page.dart';

class SplashSatuPage extends StatelessWidget {
  const SplashSatuPage({super.key});

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
              Image.asset('assets/splash1.png', scale: 1.5),
              const SizedBox(height: 100),
              const Text("More Practical", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 25), child: Text("Shopping for fresh consumer fish is now easier with our e-commerce app, straight from the fisherman to your kitchen!", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashDuaPage()) );
                  },
                  backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                  child: const Text("Next", style: TextStyle(color: Colors.white),),),
              ),
            ],
          ),
        ),
      ),
    );

  }


}