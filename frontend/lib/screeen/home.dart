import 'dart:convert';
import 'dart:typed_data';

import 'package:e_commerce/provider/user_provider.dart';
import 'package:e_commerce/screeen/drawer.dart';
import 'package:e_commerce/screeen/login.dart';
import 'package:e_commerce/screeen/search_place.dart';
import 'package:e_commerce/special_folder/camera.dart';
import 'package:e_commerce/widget/custom_shape.dart';
import 'package:e_commerce/widget/my_place.dart';
import 'package:e_commerce/widget/user_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;
  // String loggedInUser = "";
  bool _isLoading = false;
  int i = 0;

  @override
  void initState() {
    super.initState();
  }

  bool isInit = true;
  @override
  void didChangeDependencies() {
    print("didChangeDependencies");
    if (isInit) {
      setState(() {
        _isLoading = true;
      });

      final usersData = Provider.of<UserProvider>(context);
      usersData.fetchAllPlace().then((_) {
        setState(() {
          _isLoading = false;
        });
        print("users ${usersData.users}");
        // loggedInUser = usersData.loggedInUser.toString();
      }).catchError((onError) {
        setState(() {
          _isLoading = false;
        });
        print(onError);
      });
    }
    isInit = false;
    // print("object");

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);
    String url = "";
    String profileUrl = "";
    if (provider.loggedInUser.isNotEmpty) {
      if (provider.user["avatar"] != null) {
        url = "http://192.168.1.55:3000/${provider.user["avatar"]}";
        url = url.replaceAll("\\", "/");
        profileUrl = provider.user["avatar"] == null ? "" : url;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leadingWidth: 200,
        elevation: 0,
        leading: provider.loggedInUser.isEmpty
            ? Container()
            : TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
                child: Container(
                  width: 300,
                  height: 200,
                  child: Row(children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: profileUrl.isEmpty
                          ? AssetImage(
                              "images/avatar.jpg",
                            )
                          : NetworkImage(profileUrl) as ImageProvider,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(provider.loggedInUser.toString()),
                    SizedBox(
                      width: 5,
                    ),
                  ]),
                ),
              ),
        centerTitle: true,
        title: const Text("My place "),
        toolbarHeight: 60,
        shadowColor: Colors.blue,
        actions: [
          provider.loggedInUser.isEmpty
              ? TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white),
                  label: Text("Login"),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "login");
                  },
                  icon: const Icon(Icons.login),
                )
              : TextButton.icon(
                  style: TextButton.styleFrom(primary: Colors.white),
                  label: Text("Logout"),
                  onPressed: () async {
                    provider.checkLoading();
                    await provider.logout();
                    provider.checkLoading();
                    // Navigator.pushReplacementNamed(context, "/");
                  },
                  icon: const Icon(Icons.login),
                )
        ],
      ),
      // drawer: DrawerScreen(),
      body: provider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (index == 0)
                    _isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Colors.green,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: provider.users.isNotEmpty && !_isLoading
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: (provider.users).map((user) {
                                      var images;
                                      images = user["userPlaces"][0]["image"];
                                      i++;
                                      print("${user["user"]}");

                                      return UserCard(
                                          id: user["user"]['_id'],
                                          name: user["user"]['name'],
                                          place: images,
                                          profile:
                                              user["user"]["avatar"] != null
                                                  ? user["user"]["avatar"]
                                                  : null,

                                          // profile: null,
                                          count: user["countPlace"]);
                                    }).toList(),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    child: Center(
                                      child: Text("No data found"),
                                    ),
                                  ),
                            // child: Column(children: usersData.users.map(),),
                          ),
                  if (index == 1) SearchPlace(),
                  if (index == 2) MyPlace()
                ],
              ),
            ),
      floatingActionButton: index == 2
          ? FloatingActionButton(
              tooltip: "Add place",
              backgroundColor: Colors.green,
              onPressed: () {
                Navigator.pushNamed(context, "/addplace");
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            label: "search",
            icon: Icon(Icons.search),
          ),
          if (provider.token.isNotEmpty)
            BottomNavigationBarItem(
              label: "my place",
              icon: Icon(Icons.location_history),
            )
        ],
        selectedItemColor: Colors.green,
        onTap: (value) {
          setState(() {
            index = value;
          });
          // if (index == 2) {
          //   Navigator.pushReplacementNamed(context, "login");
          // }
        },
      ),
    );
  }
}
