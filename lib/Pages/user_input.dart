import 'package:flutter/material.dart';

class userInput extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? Controller;
  final Widget? widget;
  // final Widget widget;

  userInput({
    Key? key,
    required this.title,
    required this.hint,
    this.Controller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Container(
            height: 52,
            // width: 480,
            margin: EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget == null ? false : true,
                    cursorColor: Colors.black,
                    controller: Controller,
                    decoration: InputDecoration(hintText: hint),
                  ),
                ),
                widget == null ? Container() : Container(child: widget)
              ],
            ),
            // widget==null?Container():Container(child:widget)
          )
        ],
      ),
    );
  }
}
