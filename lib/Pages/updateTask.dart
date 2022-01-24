import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:todo/Pages/HomePage.dart';
import 'package:todo/Pages/button.dart';
import 'package:todo/Pages/user_input.dart';
import 'package:intl/intl.dart';
// import 'package:todo/db/task.dart';
import 'package:todo/db/task_controller.dart';

class updateTaskPage extends StatefulWidget {
  updateTaskPage(BuildContext context);

  @override
  State<updateTaskPage> createState() => _updateTaskPageState();
}

class _updateTaskPageState extends State<updateTaskPage> {
  final _taskController = Get.put(TaskController());

  final TextEditingController _edittitleController = TextEditingController();
  final _editdescriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  // Color _selectedColor = Colors.blue;
  int _selectedColor = 0;
  // int index = index +1 ;

  @override
  Widget build(BuildContext context) {
    // int index = index + 1;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Edit Task"),
        ),
        body: _addTask(context));

    // body: Container(
    //   child: FutureBuilder<String>(
    //     future: _editTask(context, 1),
    //   ),
    // ));
  }

  // _showTask() {
  //   return Expanded(
  //     child: Obx(
  //       () {
  //         return ListView.builder(
  //           itemCount: _taskController.taskList.length,
  //           itemBuilder: (_, index) {
  //             print(_taskController.taskList[index].id);
  //             return _editTask(context, _taskController.taskList[index].id);
  //             // print(_taskController.taskList.length);
  //             // return AnimationConfiguration.staggeredList(
  //             //   position: index,
  //             //   child: SlideAnimation(
  //             //     child: FadeInAnimation(
  //             //       child: TaskTile(_taskController.taskList[index]),
  //             //     ),
  //             //   ),
  //             // );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  _editTask(BuildContext context, taskId) async {
    var tasks = await _taskController.readTaskbyId(taskId);
    setState(() {
      _edittitleController.text = tasks[0]['title'] ?? 'No Title';
      print(_edittitleController.text);
      _editdescriptionController.text =
          tasks[0]['description'] ?? 'No Description';
      _selectedDate = tasks[0]['date'] ?? 'No Date';
      _selectedColor = tasks[0]['color'] ?? 'No Color';
    });
    _addTask(context);
  }

  _addTask(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInput(
              title: "Title",
              hint: "Enter your task Title",
              Controller: _edittitleController,
            ),
            userInput(
              title: "Description",
              hint: "Write your task Description",
              Controller: _editdescriptionController,
            ),
            userInput(
              title: "Date",
              hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(
                icon: Icon(Icons.calendar_today_outlined),
                onPressed: () {
                  _getDate();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "Color",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(height: 8.0),
            _addColor(),
            SizedBox(
              height: 10,
            ),
            Button(
                label: "Update Task",
                onTap: () {
                  _validateData();
                })
          ],
        ),
      ),
    );
  }

  _getDate() async {
    DateTime? _pickerDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
        print(_selectedDate);
      });
    } else {
      print("Please Select Date");
    }
  }

  _validateData() {
    if (_edittitleController.text.isNotEmpty &&
        _editdescriptionController.text.isNotEmpty) {
      ListView.builder(itemBuilder: (context, index) {
        return _editTask(context, _taskController.taskList[index].id);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (Route<dynamic> route) => false,
        );
      });
    } else if (_edittitleController.text.isEmpty ||
        _editdescriptionController.text.isEmpty) {
      // print("Error");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => getAlertBox()),
      );
    }
  }

  // _editTask(BuildContext context, taskId) async {
  //   var tasks = await _taskController.readTaskbyId(taskId);
  //   setState(() {
  //     _edittitleController.text = tasks[0]['title'] ?? 'No Title';
  //     print(_edittitleController.text);
  //     _editdescriptionController.text =
  //         tasks[0]['description'] ?? 'No Description';
  //     _selectedDate = tasks[0]['date'] ?? 'No Date';
  //     _selectedColor = tasks[0]['color'] ?? 'No Color';
  //   });
  //   _addTask(context);
  // }

  // _addTaskDB() async {
  //   int value = await _taskController.addTask(
  //       task: Task(
  //     title: _edittitleController.text,
  //     description: _editdescriptionController.text,
  //     date: DateFormat.yMd().format(_selectedDate),
  //     color: _selectedColor,
  //   ));
  //   // print("My id is " + "$value");
  //   // print(value.);
  // }

  _addColor() {
    return Column(children: [
      Wrap(
        children: List<Widget>.generate(10, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedColor = index;
                // print(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: index == 0
                    ? Colors.blue
                    : index == 1
                        ? Colors.green
                        : index == 2
                            ? Colors.greenAccent
                            : index == 3
                                ? Colors.yellow
                                : index == 4
                                    ? Colors.orange
                                    : index == 5
                                        ? Colors.red
                                        : index == 6
                                            ? Colors.purple
                                            : index == 7
                                                ? Colors.cyan
                                                : index == 8
                                                    ? Colors.deepOrange
                                                    : index == 9
                                                        ? Colors.teal
                                                        : Colors.blue,
                child: _selectedColor == index
                    ? Icon(Icons.done, color: Colors.white, size: 20)
                    : Container(),
              ),
            ),
          );
        }),
      ),
    ]);
  }

  getAlertBox() {
    return AlertDialog(
      title: Text('All fields are required !'),
      content: Text('Please fill all fields.'),
      actions: [
        FlatButton(
          textColor: Color(0xFF6200EE),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => updateTaskPage(context)),
            // );
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
