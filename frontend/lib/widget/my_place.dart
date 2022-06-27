import 'package:e_commerce/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyPlace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context, listen: false);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 110),
          itemCount: provider.userDetailData["userPlace"].length,
          itemBuilder: (context, index) {
            String profileUrl =
                "http://192.168.1.55:3000/${provider.userDetailData["userPlace"][index]["image"]}";
            profileUrl = profileUrl.replaceAll("\\", "/");
            return Container(
              margin: EdgeInsets.only(top: 10),
              child: Card(
                elevation: 10,
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Image.network(
                        profileUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 60,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FittedBox(
                            child: Column(
                              children: [
                                Text("33 likes"),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                          FittedBox(
                            child: Column(
                              children: [
                                Text("23 Comments"),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.comment,
                                    color: Colors.green,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
