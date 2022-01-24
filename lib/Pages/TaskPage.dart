import 'package:flutter/material.dart';
import 'package:todo/Pages/HomePage.dart';
import 'package:todo/Pages/button.dart';
import 'package:todo/Pages/user_input.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/task.dart';
import 'package:todo/db/task_controller.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final TaskController _taskController = TaskController();
  final TextEditingController _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  // Color _selectedColor = Colors.blue;
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Task"),
      ),
      body: _addTask(),
    );
  }

  _addTask() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInput(
              title: "Title",
              hint: "Enter your task Title",
              Controller: _titleController,
            ),
            userInput(
              title: "Description",
              hint: "Write your task Description",
              Controller: _descriptionController,
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
                label: "Create Task",
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
    if (_titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty) {
      _addTaskDB();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
        (Route<dynamic> route) => false,
      );
    } else if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty) {
      // print("Error");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => getAlertBox()),
      );
    }
  }

  _addTaskDB() async {
    int value = await _taskController.addTask(
        task: Task(
      title: _titleController.text,
      description: _descriptionController.text,
      date: DateFormat.yMd().format(_selectedDate),
      color: _selectedColor,
    ));
    print("My id is " + "$value");
    // print(value.);
  }

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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TaskPage()),
            );
          },
          child: Text('Ok'),
        ),
      ],
    );
  }
}
