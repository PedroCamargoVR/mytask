import 'package:mytask/data/models/user_model.dart';
import 'package:mytask/data/models/user_model_session.dart';
import 'package:mytask/data/repository/Impl/user_repositoryimpl.dart';

class LoginService{

  UserRepositoryImpl repository;

  LoginService(this.repository);

  Future<UserModelSession> login(String user, String pass) async{
    try{
     UserModel result = await repository.getUserByUser(user);
     if(result.getPassword() != pass){
       throw Exception("Usuário ou senha inválidos");
     }
      return UserModelSession(idUsuario: result.getId(),idFunction: result.getIdFunction(), nome: result.getName(), email: result.getEmail(), user: result.getUser());
    }catch(e){
      throw Exception("Usuário ou senha inválidos");
    }
  }

}