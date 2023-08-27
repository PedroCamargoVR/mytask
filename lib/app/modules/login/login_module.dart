import 'package:flutter_modular/flutter_modular.dart';
import 'package:mytask/app/modules/login/login_page.dart';

class LoginModule extends Module{
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (context,args) => LoginPage()),
  ];
}