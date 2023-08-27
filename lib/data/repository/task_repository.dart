import 'package:mytask/data/models/task_model.dart';

abstract class TaskRepository{

  Future<List<TaskModel>> getAllTasks();

  Future<TaskModel> getTaskById(int id);

  Future<TaskModel> createTask(Map<String, dynamic> task);

  Future<TaskModel> updateTask(Map<String, dynamic> task);

  Future<bool> deleteTask(int id);

}