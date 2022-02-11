import 'package:get/get.dart';
import 'package:todoapp/db/db_helper.dart';
import 'package:todoapp/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  Future<int> addTask({required Task task}) async {
    return await DBHelper.insert(task);
  }

  void deleteTasks({required Task task}) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void markAsCompleted({required int id}) async {
    await DBHelper.update(id);
    getTasks();
  }
}
