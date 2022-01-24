import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo/Pages/HomePage.dart';
import 'package:todo/Pages/SortTask/sort_Date.dart';
import 'package:todo/Pages/SortTask/sort_des.dart';
import 'package:todo/Pages/button.dart';
import 'package:todo/Pages/task_tile.dart';
import 'package:todo/Pages/user_input.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/task_controller.dart';
import 'package:todo/db/task.dart';

class sortTitle extends StatefulWidget {
  const sortTitle({Key? key}) : super(key: key);

  @override
  _sortTitleState createState() => _sortTitleState();
}

class _sortTitleState extends State<sortTitle> {
  final _taskController = Get.put(TaskController());
  var _task = Task();

  var tasks;

  final TextEditingController _edittitleController = TextEditingController();
  final _editdescriptionController = TextEditingController();
  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  // Color _selectedColor = Colors.blue;
  int _selectedColor = 0;
  // int index = index +1 ;

  _editTaskById(BuildContext context, taskId) async {
    tasks = await _taskController.readTaskbyId(taskId);
    setState(() {
      _edittitleController.text = tasks[0]['title'] ?? 'No Title';
      print(_edittitleController.text);
      _editdescriptionController.text =
          tasks[0]['description'] ?? 'No Description';
      // _selectedDate =
      // tasks[0][DateFormat.yMd().format.toString()]['date'] ?? 'no date';
      // _selectedColor = tasks[0][int];
      // print(_selectedColor);
    });
    _editTaskDialog(context);
  }

  _editTaskDialog(BuildContext) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => _completeTask()),
                  );
                },
                child: Text('Completed'),
                color: Colors.green,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
                color: Colors.red,
              ),
              FlatButton(
                onPressed: () async {
                  _task.id = tasks[0]['id'];
                  _task.title = _edittitleController.text;
                  _task.description = _editdescriptionController.text;
                  // await _taskController.updateTask(_task());
                  await _taskController.updateTask(
                      tasks[0]['id'],
                      _edittitleController.text,
                      _editdescriptionController.text);
                  print("updated task called ..... Done");

                  print("taskk added");
                  Navigator.pop(context);
                },
                child: Text('Update'),
                color: Colors.blue,
              ),
            ],
            title: Text('Edit Task'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _edittitleController,
                    decoration: InputDecoration(
                      hintText: 'write a title for sorting',
                      labelText: 'Title',
                    ),
                  ),
                  TextField(
                    controller: _editdescriptionController,
                    decoration: InputDecoration(
                      hintText: 'write a description',
                      labelText: 'Description',
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  _completeTask() {
    return Container(
      alignment: Alignment.center,
      child: FlatButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (Route<dynamic> route) => false,
          );
        },
        child: Text('    Task Completed    '),
        color: Colors.green,
      ),
      // child: Text(
      //   'Your Task is Comleted',
      //   textAlign: TextAlign.center,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("To Do List"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              icon: Icon(Icons.search),
              tooltip: "Save Todo and Retrun to List",
              onPressed: () {
                setState(() {
                  _titleController.text;
                });
                print(_titleController.text);
                // setState(() {
                //   _edittitleController.text;
                // });
                // print("search by title");
                // save();
              },
            ),
          )
        ],
      ),
      drawer: DrawerNavigation(),
      body: Column(
          children: <Widget>[_titleInput(), SizedBox(height: 12), _showTask()]),
    );
  }

  _titleInput() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'write a title',
                labelText: 'Title',
              ),
            ),
            // widgetttttttttttttttttt
          ],
        ),
      ),
    );
  }

  _showTask() {
    return Expanded(
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              if (_taskController.taskList[index].title ==
                  _titleController.text) {
                // print(_taskController.taskList[index].id);
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        // child: TaskTile(_taskController.taskList[index]),
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // _showDialogBox();
                            print("Before clecked");
                            _editTaskById(
                                context, _taskController.taskList[index].id);
                            print("After clecked");
                          },
                          child: TaskTile(_taskController.taskList[index]),
                        )
                      ],
                    )),
                  ),
                );
              } else {
                return Container();
              }
              // print(_taskController.taskList.length);
              // return AnimationConfiguration.staggeredList(
              //   position: index,
              //   child: SlideAnimation(
              //     child: FadeInAnimation(
              //       child: TaskTile(_taskController.taskList[index]),
              //     ),
              //   ),
              // );
            },
          );
        },
      ),
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
