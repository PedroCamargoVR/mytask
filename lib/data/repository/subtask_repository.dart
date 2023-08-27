import 'package:mytask/data/models/subtask_model.dart';

abstract class SubTaskRepository{

  Future<List<SubTaskModel>> getAllSubTasks();

  Future<SubTaskModel> getSubTaskById(int id);

  Future<List<SubTaskModel>> getSubTaskByIdTask(int id);

  Future<SubTaskModel> createSubTask(Map<String, dynamic> subTask);

  Future<SubTaskModel> updateSubTask(Map<String, dynamic> subTask);

  Future<bool> deleteSubTask(int id);

}