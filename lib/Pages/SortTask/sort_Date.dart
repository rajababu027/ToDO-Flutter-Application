import 'package:flutter/material.dart';
import 'package:todo/Pages/HomePage.dart';
import 'package:todo/Pages/SortTask/sort_des.dart';
import 'package:todo/Pages/SortTask/sort_title.dart';

class sortDate extends StatefulWidget {
  const sortDate({Key? key}) : super(key: key);

  @override
  _sortDateState createState() => _sortDateState();
}

class _sortDateState extends State<sortDate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Sort By date"),
      ),
      drawer: DrawerNavigation(),
    );
  }
}

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.date_range_rounded),
              title: Text('Date'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => CategoriesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.title),
              title: Text('Title'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => sortTitle()),
                  (Route<dynamic> route) => false,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => CategoriesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Description'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => sortDes()),
                  (Route<dynamic> route) => false,
                );
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => CategoriesScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
