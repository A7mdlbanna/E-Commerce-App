// Login
import 'package:flutter_login/flutter_login.dart';

class UserLoginData{
  late bool status;
  late String message;
  UserData? data;

  UserLoginData.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    if(status)data = UserData.fromJSON(json['data']);
  }
}
class UserData{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;

  UserData.fromJSON(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}

// SignUp
class UserSignUpData{
  late bool status;
  late String message;
  SignUpData? data;

  UserSignUpData.fromJSON(Map<String, dynamic>? json){
    status = json?['status'];
    message = json?['message'];
    data = SignUpData.fromJSON(json?['data']);
  }
}
class SignUpData{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;

  SignUpData.fromJSON(Map<String, dynamic>? json){
    name =  json?['name'];
    id =    json?['id'];
    email = json?['email'];
    phone = json?['phone'];
    image = json?['image'];
    token = json?['token'];
  }
}

// LogOut
class UserLogOut {
  late bool status;
  late String message;
  LogOutData? data;

  UserLogOut.fromJSON(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
    data = LogOutData.fromJson(json['data']);
  }
}
class LogOutData{
  late int id;
  late String token;

  LogOutData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    token = json['token'];
  }
}
