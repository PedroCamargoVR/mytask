class UserModelSession{
  int _idUsuario;
  int _idFunction;
  String _nome;
  String _email;
  String _user;

  UserModelSession({required idUsuario, required idFunction,required String nome,required String email,required String user}) : _idUsuario = idUsuario, _idFunction = idFunction,_nome = nome,_email = email,_user = user;

  int get geId => _idUsuario;
  int get getFunction => _idFunction;
  String get getNome => _nome;
  String get getEmail => _email;
  String get getUser => _user;
}