import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:todo/db/db_helper.dart';
import 'package:todo/db/task.dart';
import 'package:todo/db/task_controller.dart';

import 'add_action_icon.dart';

class TaskTile extends StatefulWidget {
  final Task? task;

  TaskTile(this.task);

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  final _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    setState(() {
      _taskController.getTasks();
    });

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(widget.task?.color ?? 0),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task?.title ?? "",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  widget.task?.description ?? "",
                  style: TextStyle(fontSize: 15, color: Colors.grey[100]),
                ),
                SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    Text(
                      widget.task?.date ?? "",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 180),
                      child: GestureDetector(
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
                    ),
                    // addactionIcon(widget.task),
                    SizedBox(width: 4),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

_getBGClr(int no) {
  switch (no) {
    case 0:
      return Colors.blue;
    case 1:
      return Colors.green;
    case 2:
      return Colors.greenAccent;
    case 3:
      return Colors.yellow;
    case 4:
      return Colors.orange;
    case 5:
      return Colors.red;
    case 6:
      return Colors.purple;
    case 7:
      return Colors.cyan;
    case 8:
      return Colors.deepOrange;
    case 9:
      return Colors.teal;

    default:
      return Colors.blue;
  }
}
