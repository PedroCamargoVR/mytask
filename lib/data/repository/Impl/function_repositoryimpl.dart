import 'package:mytask/data/models/function_model.dart';
import 'package:mytask/data/repository/function_repository.dart';
import 'package:sqflite/sqflite.dart';

class FunctionRepositoryImpl implements FunctionRepository{

  Database db;
  String tableName = 'functions';

  FunctionRepositoryImpl(this.db);

  @override
  Future<FunctionModel> createFunction(String descricao) async{
    int idInserted = await db.insert(tableName, {'description' : descricao});
    if(idInserted > 0){
      return getFunctionById(idInserted);
    }
    throw Exception("Erro ao inserir função");
  }

  @override
  Future<bool> deleteFunction(int id) async{
    int affectedRows = await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    if(affectedRows > 0){
      return true;
    }
    return false;
  }

  @override
  Future<List<FunctionModel>> getAllFunctions() async{
    List<Map<String, dynamic>> result = await db.query(tableName);
    if(result.length > 0){
      List<FunctionModel> functions = [];
      for(Map<String, dynamic> function in result){
        functions.add(FunctionModel.forMap(function));
      }
      return functions;
    }
    throw Exception("Nenhuma função cadastrada.");
  }

  @override
  Future<FunctionModel> getFunctionById(int id) async{
    List<Map<String, dynamic>> result = await db.query(tableName,where: 'id = ?',whereArgs: [id]);
    if(result.isNotEmpty){
      if(result.length > 1){
        throw Exception("Retornado linhas duplicadas na busca pelo ID");
      }
      return FunctionModel.forMap(result[0]);
    }
    throw Exception("Nenhum registro encontrado com o ID informado");
  }

  @override
  Future<FunctionModel> updateFunction(int id, String descricao) async{
    List<Map<String, dynamic>> result = await db.query(tableName,where: 'id = ?', whereArgs: [id], limit: 1);
    if(result.isNotEmpty){
      if(result.length > 1){
        throw Exception("Retornado linhas duplicadas com o ID informado");
      }
      int affectedRows = await db.update(tableName, {'description' : descricao},where: 'id = ?', whereArgs: [id]);
      if(affectedRows > 0){
        return FunctionModel(id: id, description: descricao);
      }
      throw Exception("Erro ao realizar update, nenhuma linha afetada");
    }
    throw Exception("Não existe registro com o ID informado");
  }
  
}