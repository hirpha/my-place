import 'dart:convert';
import 'dart:typed_data';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screeen/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String id;
  var place;
  int count;
  var profile;
  // Color color;
  // final imageUrl;
  UserCard(
      {required this.name,
      required this.place,
      required this.id,
      required this.count,
      required this.profile});

  Uint8List _getImageBinary(dynamicList) {
    List<int> intList =
        dynamicList.cast<int>().toList(); //This is the magical line.
    Uint8List data = Uint8List.fromList(intList);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    String url = "http://192.168.1.55:3000/$place";
    url = url.replaceAll("\\", "/");
    String profileUrl =
        profile == null ? "" : "http://192.168.1.55:3000/$profile";
    profileUrl = profileUrl.replaceAll("\\", "/");

    final provider = Provider.of<UserProvider>(context, listen: false);
    print(url);

    return Card(
      elevation: 10,
      child: Container(
        height: 400,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      ),
                  child: Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Container(
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: profile == null
                            ? AssetImage("images/avatar.jpg")
                            : NetworkImage(profileUrl) as ImageProvider),
                    title: Text(
                      name.toString(),
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    subtitle: Text(
                      "Ambo and more other place",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    trailing: TextButton.icon(
                        onPressed: () async {
                          try {
                            await provider.userDetail(id);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UserScreen();
                            }));
                          } catch (e) {}
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle,
                          size: 25,
                        ),
                        label: Text(
                            count > 1 ? "$count more place" : "view place")),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
