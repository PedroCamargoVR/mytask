import 'package:mytask/data/models/function_model.dart';

abstract class FunctionRepository{

  Future<List<FunctionModel>> getAllFunctions();

  Future<FunctionModel> getFunctionById(int id);

  Future<FunctionModel> createFunction(String descricao);

  Future<FunctionModel> updateFunction(int id, String descricao);

  Future<bool> deleteFunction(int id);

}