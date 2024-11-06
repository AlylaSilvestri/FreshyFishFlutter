import 'package:flutter/material.dart';
import 'package:freshy_fish/splash_tiga_page.dart';

class SplashDuaPage extends StatelessWidget {
  const SplashDuaPage({super.key});

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
              Image.asset('assets/splash2.png', scale: 1.5),
              const SizedBox(height: 100),
              const Text("Various Options", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 25), child: Text("Find a wide selection of high-quality fresh fish at affordable prices only on our consumer fish e-commerce app.", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
              SizedBox(
                width: 250,
                height: 40,
                child: FloatingActionButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SplashTigaPage()) );
                  },
                  backgroundColor: const Color.fromARGB(255, 0, 150, 200),
                  child: const Text("Next", style: TextStyle(color: Colors.white),
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