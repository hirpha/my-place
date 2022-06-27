import 'package:e_commerce/provider/user_provider.dart';
import "package:flutter/material.dart";
// import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class CameraActivator extends StatefulWidget {
  @override
  State<CameraActivator> createState() => _CameraActivatorState();
}

class _CameraActivatorState extends State<CameraActivator> {
  //  CameraActivator({Key? key}) : super(key: key);
  File? _image;
  final formKey = GlobalKey<FormState>();
  String name = "";
  String desc = "";

  ImagePicker picker = ImagePicker();

  void _openCamera() async {
    final image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
    // Navigator.pop(context);
  }

  void _openGallery() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    print("image  = $_image");

    setState(() {
      _image = File(image!.path);
    });
    // Navigator.pop(context);
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
                      _openCamera();
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
                      _openGallery();
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

  bool _isLoading = false;
  bool _isUploaded = false;
  void submitForm() async {
    setState(() {
      _isLoading = true;
    });
    formKey.currentState!.save();
    await Provider.of<UserProvider>(context, listen: false)
        .oploadPlace(name, desc, _image as File);
    setState(() {
      _isLoading = false;
      _isUploaded = true;
    });

    print("upload =============================================");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add place"),
      ),
      body:_isLoading?Center(child: CircularProgressIndicator(color: Colors.green,),): SingleChildScrollView(
        child: Form(
          key: formKey,
          child: _isUploaded
              ? Center(
                  child: Card(child: Text("place Uploaded successfully")),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text("Place Name"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(() {
                            name = value.toString();
                          });
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.location_city_rounded),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text("Description"),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: TextFormField(
                        onSaved: (value) {
                          setState(() {
                            desc = value.toString();
                          });
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.green,
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Text("Location"),
                        ),
                        MaterialButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () {},
                          child: Text("Add Location"),
                        ),
                      ],
                    ),
                    _image == null
                        ? Container(
                            padding: EdgeInsets.all(20),
                            child: Text("no image taken"),
                          )
                        : Container(
                            height: 300,
                            width: MediaQuery.of(context).size.width,
                            child: Image.file(
                              _image as File,
                              fit: BoxFit.cover,
                            )),
                    MaterialButton(
                      textColor: Colors.white,
                      color: Colors.green,
                      onPressed: () {
                        _showChoiceDialog(context);
                      },
                      child: Text("Select Image"),
                    ),
                    ElevatedButton(
                      onPressed: submitForm,
                      child: Text("upload"),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
