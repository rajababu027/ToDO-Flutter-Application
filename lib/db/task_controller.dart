import 'package:get/get.dart';
import 'db_helper.dart';
import 'task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  // get all the data from table

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
    // taskList.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    DBHelper.delete(task);
    // print("this is $val");
  }

  readTaskbyId(taskId) async {
    return await DBHelper.readDatabyId('tasks', taskId);
  }

  updateTask(id, title, description) async {
    return await DBHelper.updateData(id, title, description);
  }
}
