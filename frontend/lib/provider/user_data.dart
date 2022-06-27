import 'package:flutter/material.dart';

class UserData {
  final String name;
  final String passoword;
  final String address;
  final String emial;
  String place;
  Color color;
  UserData({
    required this.name,
    required this.address,
    required this.emial,
    required this.passoword,
    this.place = "0 place",
    this.color = Colors.white12,
  });
}



List user = [
  UserData(
      color: Colors.brown,
      name: "Hirpha Fayisa",
      address: "",
      emial: "hirphafayisa88@gmail.com",
      passoword: "passoword,",
      place: "3 place"),
  UserData(
    color: Colors.green,
    name: "Gemme Gudisa",
    address: "",
    emial: "hirphafayisa88@gmail.com",
    passoword: "passoword,",
    place: "2 places",
  ),
  UserData(
    color: Colors.yellowAccent,
    name: "Bel Yedata",
    address: "",
    emial: "hirphafayisa88@gmail.com",
    passoword: "passoword,",
    place: "4 places",
  ),
  UserData(
      color: Colors.pink,
      name: "Gadisa Aboma",
      address: "",
      emial: "hirphafayisa88@gmail.com",
      passoword: "passoword,",
      place: "2 places"),
  UserData(
    color: Colors.orange,
    name: "Getinet Silesh",
    address: "",
    emial: "hirphafayisa88@gmail.com",
    passoword: "passoword,",
    place: ("4 places"),
  ),
  UserData(
    color: Colors.redAccent,
    name: "Abdi Badilu",
    address: "",
    emial: "hirphafayisa88@gmail.com",
    passoword: "passoword,",
    place: ("5 places"),
  ),
];
