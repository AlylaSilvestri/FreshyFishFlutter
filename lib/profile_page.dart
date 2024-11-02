import 'package:flutter/material.dart';
import 'package:freshy_fish/profile_edit_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
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
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Isi Alamatnya",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(color: Colors.blue, height: 20),
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
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Isi Emailnya",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(color: Colors.blue, height: 20),
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
                padding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                child: Text(
                  "Isi Nomornya",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(color: Colors.blue, height: 20),
              SizedBox(height: 15),
              Center(
                child: SizedBox(
                  height: 47,
                  width: 200,
                  child: FloatingActionButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileEditPage()) );
                    },
                    backgroundColor: Color.fromARGB(255, 0, 150, 200),
                    child: Text('Edit', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
