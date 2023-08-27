import 'package:mytask/data/models/user_model.dart';
import 'package:mytask/data/repository/user_repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepositoryImpl implements UserRepository{
  
  Database db;
  String tableName = 'users';
  
  UserRepositoryImpl(this.db);
  
  @override
  Future<UserModel> createUser(Map<String, dynamic> user) async{
    int idInserted = await db.insert(tableName, user);
    if(idInserted > 0){
      return getUserById(idInserted);
    }
    throw Exception("Ocorreu um erro ao inserir o usuário");
  }

  @override
  Future<bool> deleteUser(int id) async{
    int affectedRows = await db.delete(tableName,where: 'id = ?', whereArgs: [id]);
    if(affectedRows > 0){
      return true;
    }
    return false;
  }

  @override
  Future<List<UserModel>> getAllUsers() async{
    List<Map<String,dynamic>> result = await db.query(tableName);
    if(result.isEmpty){
      throw Exception("Nenhum usuário encontrado");
    }
    List<UserModel> users = [];
    for(Map<String, dynamic> user in result){
      users.add(UserModel.forMap(user));
    }
    return users;
  }

  @override
  Future<UserModel> getUserById(int id) async{
    List<Map<String, dynamic>> result = await db.query(tableName,where: 'id = ?',whereArgs: [id],limit: 1);
    if(result.isEmpty){
      throw Exception("Nenhum usuário encontrado com este ID");
    }
    return UserModel.forMap(result[0]);
  }

  @override
  Future<UserModel> getUserByUser(String user) async{
    List<Map<String,dynamic>> result = await db.query(tableName,where: 'user = ?',whereArgs: [user],limit: 1);
    if(result.isEmpty){
      throw Exception("Usuário não encontrado");
    }else{
      return UserModel.forMap(result[0]);
    }
  }

  @override
  Future<UserModel> updateUser(Map<String, dynamic> user) async{
    List<Map<String, dynamic>> result = await db.query(tableName,where: 'id = ?', whereArgs: [user['id']]);

    if(result.isEmpty){
      throw Exception("Nenhum usuário encontrado com este ID");
    }

    int affectedRows = await db.update(tableName, user,where: 'id = ?', whereArgs: [user['id']]);
    if(affectedRows > 0){
      return UserModel.forMap(user);
    }
    throw Exception("Erro na atualização do usuário, nenhuma linha foi afetada");
  }

}