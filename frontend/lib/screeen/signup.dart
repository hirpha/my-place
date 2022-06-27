import 'dart:convert';
import 'dart:io';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:email_validator/email_validator.dart';
import 'dart:core';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  var _user = null;

  final Map<String, String> _formdata = {
    "name": "",
    "email": "",
    "address": "",
    "password": "",
  };

  @override
  void didChangeDependencies() {
    _user = Provider.of<UserProvider>(context, listen: false);
    // dependOnInheritedWidgetOfExactType();
    super.didChangeDependencies();
  }

  Widget FullnameTextFormField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Fullname must be filled";
          }
          // if (!EmailValidator.validate(value.toString().toLowerCase())) {
          //   return "Please type valid email";
          // }
        },
        onSaved: (value) {
          setState(() {
            _formdata['name'] = value.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              "Fullname",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
            prefixIcon: Icon(
              Icons.people_alt,
              color: Colors.green,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
            fillColor: Colors.white,
            filled: true),
      ),
    );
  }

  Widget EmailTextFormField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Email must be filled";
          }
          // if (!EmailValidator.validate(value.toString().toLowerCase())) {
          //   return "Please type valid email";
          // }
        },
        onSaved: (value) {
          setState(() {
            _formdata['email'] = value.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              "Email",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w100,
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

  Widget AddressTextFormField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Address must be filled";
          }
          // if (!EmailValidator.validate(value.toString().toLowerCase())) {
          //   return "Please type valid email";
          // }
        },
        onSaved: (value) {
          setState(() {
            _formdata['address'] = value.toString();
          });
        },
        decoration: InputDecoration(
            label: Text(
              "Address",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w100,
              ),
            ),
            prefixIcon: Icon(
              Icons.location_city,
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
      margin: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: TextFormField(
        validator: (value) {
          if (value.toString().isEmpty) {
            return "Password must be filled";
          }
          if (value.toString().length < 8) {
            return "password length must be greater or equal to 8";
          }
        },
        onSaved: (value) {
          setState(() {
            _formdata['password'] = value.toString();
          });
        },
        decoration: InputDecoration(
          label: Text(
            "Password",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.green,
          ),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget RepasswordTextFormField() {
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
        decoration: InputDecoration(
          label: Text(
            "Retype password",
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w100,
            ),
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.green,
          ),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void showAlert() {}
  void submitForm(BuildContext cxt, UserProvider user) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    try {
      _formKey.currentState!.save();
      // user.checkLoading(true);
      print(_formdata);

      setState(() {
        isLoading = true;
      });
      final provider = Provider.of<UserProvider>(cxt, listen: false);
      
      await provider.signup(
          _formdata['name'].toString(),
          _formdata['email'].toString(),
          _formdata['address'].toString(),
          _formdata['password'].toString(),
          );
      showDialog(
          context: cxt,
          builder: (cxt) {
            return AlertDialog(
              title: Text("Sign up status"),
              content: Text(provider.success),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(cxt);
                    },
                    child: Text("ok"))
              ],
            );
          });

      setState(() {
        isLoading = false;
      });

      // user.checkLoading(false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        title: Text("Create Account"),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Create Account",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.green,
                        ),
                      ),
                      const Text(
                        "Enter fullname, email, address and password for signup",
                        softWrap: true,
                      ),

                      SizedBox(
                        height: 30,
                      ),
                      FullnameTextFormField(),
                      EmailTextFormField(),
                      AddressTextFormField(),
                      PasswordTextFormField(),
                      // RepasswordTextFormField(),
                      // textFormField(),
                      SizedBox(
                        height: 10,
                      ),

                      Consumer<UserProvider>(builder: (cxt, user, child) {
                        return TextButton(
                          onPressed: () => submitForm(context, user),
                          style: TextButton.styleFrom(primary: Colors.white),
                          child: Container(
                            height: 60,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.green),
                            child: Text(
                              "Sign up",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        );
                      }),
                      SizedBox(
                        height: 5,
                      ),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * .9,
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: Text("Already have an Account?",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                      ),
                      // Padding(padding: EdgeInsets.only(bottom: 40))
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
