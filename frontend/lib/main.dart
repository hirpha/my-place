import 'dart:ui';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screeen/add_place.dart';
import 'package:e_commerce/screeen/home.dart';
import 'package:e_commerce/screeen/login.dart';
import 'package:e_commerce/screeen/profile.dart';
import 'package:e_commerce/screeen/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'special_folder/camera.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const PlacementApp(),
  );
}

class PlacementApp extends StatelessWidget {
  const PlacementApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (contex) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.yellowAccent,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green.shade400,
            elevation: 0,
            foregroundColor: Colors.white,
            toolbarHeight: 80,
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.green)),
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            headline2: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            headline3: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w100,
            ),
            headline4: TextStyle(
              color: Colors.green,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        routes: {
          '/': (context) => Home(),
          'login': (context) => Login(),
          '/profile': (context) => Profile(),
          '/addplace': (context) => CameraActivator(),
          "signup": (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (contex) => UserProvider(),
                  ),
                ],
                child: Signup(),
              ),
        },
      ),
    );
  }
}
