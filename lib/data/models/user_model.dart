class UserModel{
  int _id;
  int _idFunction;
  String _name;
  String _email;
  String _user;
  String _password;

  UserModel({required id, required idFunction, required name, required email, required user, required password}) : _id = id, _idFunction = idFunction, _name = name, _email = email, _user = user, _password = password;
  UserModel.forMap(Map<String, dynamic> userMap) : _id = userMap['id'], _idFunction = userMap['id_function'], _name = userMap['name'], _email = userMap['email'], _user = userMap['user'], _password = userMap['password'];

  int getId() => _id;
  int getIdFunction() => _idFunction;
  String getName() => _name;
  String getEmail() => _email;
  String getUser() => _user;
  String getPassword() => _password;
}