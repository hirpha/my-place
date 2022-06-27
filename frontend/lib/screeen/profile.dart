import 'dart:io';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;

  final formKey = GlobalKey<FormState>();

  String name = "";

  String desc = "";

  ImagePicker picker = ImagePicker();

  Future<void> _openCamera(UserProvider user) async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
    // user.checkLoading();
    setState(() {
      loading = true;
    });
    await user.uploadProfile(_image as File);
    setState(() {
      loading = false;
    });
    // user.checkLoading();
    // Navigator.pop(context);
  }

  bool loading = false;
  void _openGallery(UserProvider user) async {
    var image = await picker.pickImage(source: ImageSource.camera);
    print("image  = $_image");

    setState(() {
      _image = File(image!.path);
      loading = true;
    });
    await user.uploadProfile(_image as File);
    // user.checkLoading();
    setState(() {
      loading = false;
    });
    // Navigator.pop(context);
  }

  Future<void> _showChoiceDialog(BuildContext ctx, UserProvider user) async {
    return showDialog(
        context: ctx,
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
                      _openCamera(user);
                      Navigator.pop(context);
                    },
                    title: Text("Gallery"),
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
                      _openGallery(user);
                      Navigator.pop(context);
                    },
                    title: Text("Camera"),
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

  void sendImage() async {}
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    print(user.user);
    String url = "http://192.168.1.55:3000/${user.user["avatar"]}";
    url = url.replaceAll("\\", "/");
    String profileUrl = user.user["avatar"] == null ? "" : url;
    // profileUrl = profileUrl.replaceAll("\\", "/");
    // print(user.user);
    print("loading  $loading");
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("profile"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          loading
              ? CircularProgressIndicator(
                  color: Colors.green,
                )
              : CircleAvatar(
                  radius: 70,
                  backgroundImage: user.user["avatar"] == null
                      ? AssetImage("images/avatar.jpg")
                      : NetworkImage(profileUrl) as ImageProvider,
                ),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () async {
              await _showChoiceDialog(context, user);
              print("show.................");
            },
            icon: Icon(
              Icons.camera_alt_outlined,
            ),
            label: Text("change picture"),
          ),
          SizedBox(
            height: 30,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(user.user["name"]),
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text(user.user['address']),
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text(user.user['email']),
          ),
          Divider(),
          TextButton.icon(
            style: TextButton.styleFrom(
              primary: Colors.green,
            ),
            onPressed: () {},
            icon: Icon(
              Icons.edit,
            ),
            label: Text("Edit Profile"),
          ),
        ],
      ),
    );
  }
}
