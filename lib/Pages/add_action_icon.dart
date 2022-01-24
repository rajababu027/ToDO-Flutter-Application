import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:todo/db/task_controller.dart';

import 'TaskPage.dart';

class addactionIcon extends StatefulWidget {
  final task;

  addactionIcon(this.task);
  // const addactionIcon({Key? key}) : super(key: key);

  @override
  _addactionIconState createState() => _addactionIconState();
}

class _addactionIconState extends State<addactionIcon> {
  final _taskController = Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 50),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("edit Button called");
                    });
                    // print("edit Button called");
                  },
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      print("Complete Button called");
                    });
                    // print("Complete Button called");

                    // setState(() {
                    //   _taskController.delete(widget.task!);
                    // });
                  },
                  child: Icon(
                    Icons.check_box,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _taskController.delete(widget.task!);
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
