import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:async';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

import 'package:e_commerce/provider/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class UserProvider extends ChangeNotifier {
  Map? fetchedData;

  bool isLoading = false;
  // {
  //   "users": {
  //     "name": "",
  //     "address": "",

  //     "emial": "",
  //   },
  //   "place": {
  //     [
  //       {
  //         "description": "",
  //         'image': "",
  //       }
  //     ]
  //   },
  //   "noOfPlace": 5
  // };
  //response[0][']

  // place[0].users.name
  // place[0].place[0].description
  List _users = [];
  List get users {
    return [..._users];
  }

  List getUsers() {
    return users;
  }

  Map<String, dynamic> registerResponse = {};

  // String url = "http://localhost:3000";
  String url = "http://192.168.1.55:3000";

  String token = "";
  String success = "";
  dynamic user;
  String loggedInUser = "";

  Future<void> signup(
      String name, String email, String address, String password) async {
    try {
      final response = await http.post(Uri.parse("$url/register"),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          },
          body: json.encode({
            "name": name,
            "password": password,
            "email": email,
            "address": address
          }));
      print("response: " + response.body);
      var decoded = json.decode(response.body);
      success = decoded["success"];

      notifyListeners();
    } catch (e) {
      print("upload image error $e");
      success = e.toString();
      // throw Error();
    }
  }

  Map<String, String> jsonData = {"name": "", "description": ""};

  Future<void> oploadPlace(String name, String desc, File image) async {
    jsonData = {"name": name, "description": desc};
    await onUploadImage(image, "placeImage", "$url/createPlace");
  }

  Uint8List? image;
//   Future<void> getImage(String url) async {
//     final ByteData imageData =
//         await NetworkAssetBundle(Uri.parse(url)).load("");
//     image = imageData.buffer.asUint8List();
// // display it with the Image.memory widget
//     notifyListeners();
//     // return bytes;
//   }

  Future<void> onUploadImage(
      File selectedImage, String name, String url) async {
    print("uplood===============================");

    // print("token: $token");
    // print(selectedImage);

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      Map<String, String> headers = {
        "Content-type": "multipart/form-data",
        "Authorization": "Bearer $token"
      };
      var im = await http.MultipartFile.fromPath(
        name,
        selectedImage.path,
      );
      request.files.add(im);
      // print("selected image $selectedImage");

      request.headers.addAll(headers);
      if (name == "placeImage") {
        request.fields["name"] = jsonData["name"].toString();
        request.fields["description"] = jsonData["description"].toString();
      }
      // if (name == "signup") {}
      var res = await request.send();
      http.Response response = await http.Response.fromStream(res);
      // print("request: " + request.toString());

      // await http.get(url)
      final decoded = json.decode(response.body);
      user = decoded["user"];
      print("response: ${response.body}");
      // image = response.bodyBytes;
      notifyListeners();
      await fetchAllPlace();
    } catch (e) {
      print("upload image errorrrrrrrrrrrrrrrr $e");
      // throw Error();
    }
  }

  Future<void> uploadProfile(File selectedImage) async {
    await onUploadImage(selectedImage, "profileImage", "$url/user/me/profile");
  }

  dynamic userDetailData;
  Future<void> userDetail(String id) async {
    final response = await http.get(Uri.parse("$url/user/$id/details"));
    final decoded = json.decode(response.body);
    userDetailData = decoded;
    print(decoded["userPlace"]);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    print("object");
    try {
      final response = await http.post(Uri.parse("$url/login"),
          body: json.encode({"email": email, "password": password}),
          headers: {
            "Content-type": "application/json",
            "Accept": "application/json",
          });
      var decoded = json.decode(response.body);
      loggedInUser = decoded["user"]["name"];
      token = decoded['token'];
      user = decoded["user"];
      print("token: $token");
      print(loggedInUser);
      notifyListeners();
      await userDetail(user["_id"]);
      // await fetchAllPlace();
      if (response.statusCode == 404) {
        print("erroe");
        throw Error();
      }
    } catch (e) {
      print("errore during login $e");
      throw Error();
    }
  }

  Future<void> fetchAllPlace() async {
    try {
      final response = await http.get(Uri.parse("$url/allPlaces"));

      final decodedData = json.decode(response.body);
      print(response.bodyBytes);

      // print(decodedData);
      List loadedData = [];
      decodedData.forEach((data) {
        loadedData.add(data);
      });
      _users = loadedData;
      print(loadedData);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    loggedInUser = "";
    notifyListeners();
  }

  void checkLoading() {
    isLoading = !isLoading;
    print(isLoading);
    notifyListeners();
  }
}
