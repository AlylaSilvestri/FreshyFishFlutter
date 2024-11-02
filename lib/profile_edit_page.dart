import 'package:flutter/material.dart';
import 'package:freshy_fish/profile_page.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  ProfileEditPageState createState() => ProfileEditPageState();
}

class ProfileEditPageState extends State<ProfileEditPage> {
  bool passwordVisible = false;

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
                color: Color.fromARGB(255, 0, 150, 200),
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Image.asset('assets/logo_putih.png', scale: 1.5),
                    SizedBox(height: 30),
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSHDT8TZp9Ized8FRjPMwrliwxAbd6JqlxZqQ&s',
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "User Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Padding(padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
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
                  obscureText: true,
                  decoration: InputDecoration(
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 40),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 200,
                  child: FloatingActionButton(
                    onPressed: (){
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => const ProfilePage()) );
                    },
                    backgroundColor: Color.fromARGB(255, 0, 150, 200),
                    child: Text('Save', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
