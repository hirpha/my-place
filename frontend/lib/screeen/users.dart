import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/widget/user_place.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text("${provider.userDetailData["name"]}'s places"),
      ),
      body: ListView.builder(
          itemCount: provider.userDetailData['userPlace'].length,
          itemBuilder: (context, index) {
            String imageurl =
                "${provider.url}/${provider.userDetailData["userPlace"][index]["image"]}";
            imageurl = imageurl.replaceAll("\\", "/");
            return UserPlace(
              name: provider.userDetailData["userPlace"][index]["name"],
              desc: provider.userDetailData["userPlace"][index]["description"],
              imageurl: imageurl,
            );
          }),
    );
  }
}
