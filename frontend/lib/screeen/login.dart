import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
import 'dart:core';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool isLoading = false;

  Widget EmailTextFormField() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Email must be filled";
          }
          // if (!EmailValidator.validate(value.toString().toLowerCase())) {
          //   return "Please type valid email";
          // }
        },
        onSaved: (newValue) {
          setState(() {
            email = newValue.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              "Email",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.green,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget PasswordTextFormField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Password must be filled";
          }
          if (value.toString().length < 8) {
            return "password length must be greater or equal to 8";
          }
        },
        onSaved: (newValue) {
          setState(() {
            password = newValue.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              "Password",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.green,
            ),
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            fillColor: Colors.white,
            focusColor: Colors.green),
      ),
    );
  }

  void submitForm(BuildContext ctx) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      isLoading = true;
    });
    try {
      final user = Provider.of<UserProvider>(ctx, listen: false);
      await user.login(email, password);
      setState(() {
        isLoading = false;
      });
      Navigator.pushReplacementNamed(ctx, "/");
    } catch (e) {
      print(e);
      showDialog(
          context: ctx,
          builder: (ctx) {
            return AlertDialog(
              title: Text("error"),
              content: Text("unable to login"),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: Text("ok"))
              ],
            );
          });
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.green),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(),
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage("images/avatar.jpg"),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   "My Place",
                      //   style: TextStyle(
                      //     fontSize: 40,
                      //     fontWeight: FontWeight.bold,
                      //     fontStyle: FontStyle.italic,
                      //     color: Colors.green,
                      //   ),
                      // ),
                      SizedBox(
                        height: 30,
                      ),
                      EmailTextFormField(),
                      PasswordTextFormField(),
                      // textFormField(),

                      Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () => submitForm(context),
                        style: TextButton.styleFrom(primary: Colors.white),
                        child: Container(
                          height: 60,
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.green),
                          child: Text(
                            "Sign in",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Don't have an account?",
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "signup");
                        },
                        child: const Text("Create an account",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
