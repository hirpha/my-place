import 'package:flutter/material.dart';

class UserPlace extends StatelessWidget {
  final imageurl;
  final name;
  final desc;
  UserPlace({required this.imageurl, required this.name, required this.desc});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(margin: EdgeInsets.all(10), child: Text(name)),
            Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  desc,
                  softWrap: true,
                )),
            Container(
              height: 330,
              alignment: Alignment.center,
              child: Image.network(
                imageurl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Column(
                children: [
                  Text("33 peoples likes and 20 comments"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.favorite),
                        label: Text("33"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.comment),
                        label: Text("20"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
