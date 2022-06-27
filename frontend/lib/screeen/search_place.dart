import 'package:flutter/material.dart';

class SearchPlace extends StatelessWidget {
  const SearchPlace({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Text(
                "Search for popular place",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              alignment: Alignment.topLeft,
              child: Form(
                  child: Container(
                width: 250,
                child: TextFormField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              )),
            ),
            Container(
                width: 200,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Most vieited place",
                  style: Theme.of(context).textTheme.headline2,
                )),
            SizedBox(
              height: 20,
            ),
            ListTile(
              dense: true,
              minLeadingWidth: 20,
              minVerticalPadding: 20,
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
              ),
              title: Text(
                "name",
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Text(
                "Ambo and more other place",
                style: Theme.of(context).textTheme.headline3,
              ),
              trailing: Text(
                "4k views",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              dense: true,
              minLeadingWidth: 20,
              minVerticalPadding: 20,
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
              ),
              title: Text(
                "name",
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Text(
                "Ambo and more other place",
                style: Theme.of(context).textTheme.headline3,
              ),
              trailing: Text(
                "4k views",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ListTile(
              dense: true,
              minLeadingWidth: 20,
              minVerticalPadding: 20,
              leading: CircleAvatar(
                backgroundImage: AssetImage("images/profile.png"),
              ),
              title: Text(
                "name",
                style: Theme.of(context).textTheme.headline1,
              ),
              subtitle: Text(
                "Ambo and more other place",
                style: Theme.of(context).textTheme.headline3,
              ),
              trailing: Text(
                "4k views",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
