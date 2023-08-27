import 'package:mytask/data/models/user_model.dart';

abstract class UserRepository{

  Future<List<UserModel>> getAllUsers();

  Future<UserModel> getUserById(int id);

  Future<UserModel> getUserByUser(String user);

  Future<UserModel> createUser(Map<String, dynamic> user);

  Future<UserModel> updateUser(Map<String, dynamic> user);

  Future<bool> deleteUser(int id);

}