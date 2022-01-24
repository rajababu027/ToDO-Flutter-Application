import 'package:flutter/material.dart';
import 'package:todo/db/db_helper.dart';

class updatePage extends StatefulWidget {
  final String title;
  final String description;

  updatePage(this.title, this.description);

  @override
  _updatePageState createState() => _updatePageState();
}

class _updatePageState extends State<updatePage> {
  DBHelper _dbHelper = DBHelper();

  // String? title;
  // String? description;

  final TextEditingController _edittitleController = TextEditingController();
  final _editdescriptionController = TextEditingController();

  void updateTitle() {
    var title = _edittitleController.text;
  }

  void updateDescription() {
    var description = _editdescriptionController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UPDATE DATA"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: _edittitleController,
              // style: TextStyle(),
              onChanged: (value) {
                debugPrint('Something changed in Title Text Field');
                updateTitle();
              },
              decoration: InputDecoration(
                  labelText: 'Title',
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: TextField(
              controller: _editdescriptionController,
              // style: textStyle,
              onChanged: (value) {
                debugPrint('Something changed in Description Text Field');
                updateDescription();
              },
              decoration: InputDecoration(
                  labelText: 'Description',
                  // labelStyle: textStyle,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
            ),
          ),
        ],
      ),
    );
  }
}
