import 'dart:io';
import 'dart:typed_data';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddPlace extends StatefulWidget {
  AddPlace({Key? key}) : super(key: key);

  @override
  State<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  var loggedInUser = "";
  File? _image;
  bool isLoading = false;
  ImagePicker picker = ImagePicker();
  void _openGallery() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    print(image);
    setState(() {
      _image = File(image!.path);
      isLoading = true;
    });

    await Provider.of<UserProvider>(context, listen: false)
        .uploadProfile(_image as File);

    setState(() {
      isLoading = false;
    });

    // Navigator.pop(context);
  }

  void _openCamera(BuildContext ctx) async {
    var image = await picker.pickImage(source: ImageSource.camera);
    // print("image  = $_image");
    setState(() {
      _image = File(image!.path);
    });
    await Provider.of<UserProvider>(ctx, listen: false)
        .uploadProfile(_image as File);

    // Navigat
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.green),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.green,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                      Navigator.pop(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.green,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.green,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery();
                      Navigator.pop(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    print("object................................");
    final provider = Provider.of<UserProvider>(context, listen: false);
    loggedInUser = provider.loggedInUser;
    // print(provider.image.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("My places "),
        toolbarHeight: 60,
        shadowColor: Colors.blue,
        actions: [
          loggedInUser.length < 1
              ? TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white),
                  label: Text("Login"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "login");
                  },
                  icon: const Icon(Icons.login),
                )
              : Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      child: provider.image != null
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.memory(
                                provider.image as Uint8List,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Container(
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  : null,
                            ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(loggedInUser.toString()),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
        ],
      ),
      body: Center(
        child: MaterialButton(
          textColor: Colors.white,
          color: Colors.green,
          onPressed: () {
            _showChoiceDialog(context);
          },
          child: Text("Select Image"),
        ),
      ),
    );
  }
}
