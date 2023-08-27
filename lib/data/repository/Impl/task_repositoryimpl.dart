import 'package:mytask/data/models/task_model.dart';
import 'package:mytask/data/repository/task_repository.dart';
import 'package:sqflite/sqflite.dart';

class TaskRepositoryImpl implements TaskRepository{

  Database db;
  String tableName = 'tasks';

  TaskRepositoryImpl(this.db);

  @override
  Future<TaskModel> createTask(Map<String, dynamic> task) async{
    int idInserted = await db.insert(tableName, task);
    if(idInserted > 0){
      return getTaskById(idInserted);
    }
    throw Exception("Erro na criação da tarefa");
  }

  @override
  Future<bool> deleteTask(int id) async {
    int affectedRows = await db.delete(tableName,where: 'id = ?',whereArgs: [id]);
    if(affectedRows > 0){
      return true;
    }
    return false;
  }

  @override
  Future<List<TaskModel>> getAllTasks() async{
    List<Map<String, dynamic>> result = await db.query(tableName);
    if(result.isEmpty){
      throw Exception("Não existe tarefa cadastrada");
    }
    List<TaskModel> tasks = [];
    for(Map<String, dynamic> task in result){
      tasks.add(TaskModel.forMap(task));
    }
    return tasks;
  }

  @override
  Future<TaskModel> getTaskById(int id) async{
    List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [id],limit: 1);
    if(result.isEmpty){
      throw Exception("Nenhuma task com este ID foi encontrada");
    }
    return TaskModel.forMap(result[0]);
  }

  @override
  Future<TaskModel> updateTask(Map<String, dynamic> task) async{
    List<Map<String, dynamic>> result = await db.query(tableName,where: 'id = ?', whereArgs: [task['id']]);
    if(result.isEmpty){
      throw Exception("Não existe Task com o ID informado");
    }
    int affectedRows = await db.update(tableName, task, where: 'id = ?', whereArgs: [task['id']]);
    if(affectedRows > 0){
      return getTaskById(task['id']);
    }
    throw Exception("Erro ao realizar atualização da Task");
  }

}