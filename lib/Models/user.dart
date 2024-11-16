import 'dart:convert';

class User {
  String? name;
  String? email;
  String? address;
  String? phone_number;
  String? password;
  String? password_confirmation;

  User({
    this.name,
    this.email,
    this.address,
    this.phone_number,
    this.password,
    this.password_confirmation,
  });

  factory User.fromjson(Map<String, dynamic> json){
    return User(
      name: json['name'],
      email: json['email'],
      address: json['address'],
      phone_number: json['phone_number'],
      password: json['password'],
      password_confirmation: json['password_confirmation'],
    );
  }

  String registertojson() {
    return jsonEncode(<String, dynamic>{
      'name' : name,
      'email' : email,
      'address' : address,
      'phone_number' : phone_number,
      'password' : password,
      'password_confirmation' : password_confirmation
    });
  }

  String updatetojson() {
    return jsonEncode(<String, dynamic>{
      'email' : email,
      'phone_number' : phone_number,
      'password' : password,
      'address' : address,
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