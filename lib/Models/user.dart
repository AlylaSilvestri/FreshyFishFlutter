import 'dart:convert';

class User {
  String? name;
  String? email;
  String? address;
  String? password;
  String? password_confirmation;

  User({
    this.name,
    this.email,
    this.address,
    this.password,
    this.password_confirmation,
  });

  factory User.fromjson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      password: json['password'],
      password_confirmation: json['password_confirmation'],
    );
  }

  String registertojson() {
    return jsonEncode(<String, dynamic>{
      'name' : name,
      'email' : email,
      'address' : address,
      'password' : password,
      'password_confirmation' : password_confirmation
    });
  }

  String logintojson(){
    return jsonEncode(<String, dynamic>{
      'email' : email,
      'password' : password
    });
  }
}