import 'package:flutter_modular/flutter_modular.dart';
import 'package:mytask/app/modules/home/home_module.dart';
import 'package:mytask/app/modules/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> binds = [];

  @override
  List<ModularRoute> routes = [
    ModuleRoute("/login", module: LoginModule()),
    ModuleRoute("/home", module: HomeModule()),
  ];
}