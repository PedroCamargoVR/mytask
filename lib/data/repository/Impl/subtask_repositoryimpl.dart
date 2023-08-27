import 'package:mytask/data/database.dart';
import 'package:mytask/data/models/subtask_model.dart';
import 'package:mytask/data/repository/subtask_repository.dart';
import 'package:sqflite/sqflite.dart';

class SubTaskRepositoryImpl implements SubTaskRepository{

  Database db;
  String tableName = 'subtasks';

  SubTaskRepositoryImpl(this.db);

  @override
  Future<SubTaskModel> createSubTask(Map<String, dynamic> subTask) async{
    int idInserted = await db.insert(tableName, subTask);
    if(idInserted > 0){
      return getSubTaskById(idInserted);
    }
    throw Exception("Erro ao inserir Sub-tarefa");
  }

  @override
  Future<bool> deleteSubTask(int id)  async{
    int affectedRows = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    if(affectedRows > 0){
      return true;
    }
    return false;
  }

  @override
  Future<List<SubTaskModel>> getAllSubTasks() async{
    List<Map<String, dynamic>> result = await db.query(tableName);
    if(result.isEmpty){
      throw Exception("Nenhuma sub-tarefa cadastrada");
    }
    List<SubTaskModel> subTasks = [];
    for(Map<String, dynamic> subTask in result){
      subTasks.add(SubTaskModel.forMap(subTask));
    }
    return subTasks;
  }

  @override
  Future<SubTaskModel> getSubTaskById(int id) async{
    List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [id], limit: 1);
    if(result.isEmpty){
      throw Exception("Nenhuma sub-tarefa com o ID informado encontrada");
    }
    return SubTaskModel.forMap(result[0]);
  }

  @override
  Future<SubTaskModel> updateSubTask(Map<String, dynamic> subTask) async{
    List<Map<String, dynamic>> result = await db.query(tableName, where: 'id = ?', whereArgs: [subTask['id']]);
    if(result.isEmpty){
      throw Exception("Não existe nenhuma sub-tarefa com o ID informado");
    }
    int affectedRows = await db.update(tableName, subTask, where: 'id = ?', whereArgs: [subTask['id']]);
    if(affectedRows > 0){
      return SubTaskModel.forMap(subTask);
    }
    throw Exception("Ocorreu um erro ao atualizar sub-tarefa, nenhuma linha foi afetada");
  }

  @override
  Future<List<SubTaskModel>> getSubTaskByIdTask(int id) async{
    List<Map<String, dynamic>> result = await db.query(tableName, where: 'id_task = ?',whereArgs: [id]);
    if(result.isEmpty){
      throw Exception("Não existe subtarefa com o ID informado");
    }
    List<SubTaskModel> subTasks = [];
    result.forEach((element) {
      subTasks.add(SubTaskModel.forMap(element));
    });
    return subTasks;
  }

}