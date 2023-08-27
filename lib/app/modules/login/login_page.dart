import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mytask/app/modules/home/widgets/modal_error.dart';
import 'package:mytask/data/database.dart';
import 'package:mytask/data/models/user_model_session.dart';
import 'package:mytask/data/repository/Impl/user_repositoryimpl.dart';
import 'package:mytask/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  final TextEditingController _controllerUsuario = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();
  bool _estadoCampoSenha = true;

  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.blue],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Center(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 40.0),
                    child: Image.asset(
                      "assets/logo_branco.png",
                      width: 200,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        controller: widget._controllerUsuario,
                        style: const TextStyle(fontSize: 16),
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                          hintText: "Usuário",
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(205, 219, 240, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        controller: widget._controllerSenha,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                widget._estadoCampoSenha =
                                    !widget._estadoCampoSenha;
                              });
                            },
                            icon: Icon(
                              (widget._estadoCampoSenha)
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 40,
                              color: Colors.white,
                            ),
                          ),
                          hintText: "Senha",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromRGBO(205, 219, 240, 1),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        obscureText: widget._estadoCampoSenha,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blueAccent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                            ))),
                        onPressed: () async {
                          String usuario = widget._controllerUsuario.text;
                          String senha = widget._controllerSenha.text;

                          Database db = await OpenDatabase.getDatabase();
                          UserRepositoryImpl userRepository =
                              UserRepositoryImpl(db);
                          LoginService loginService =
                              LoginService(userRepository);
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          try {
                            UserModelSession userSession =
                                await loginService.login(usuario, senha);
                            await prefs.setString(
                                "usuario", userSession.getUser);
                            await prefs.setString("nome", userSession.getNome);
                            await prefs.setString(
                                "email", userSession.getEmail);
                            await prefs.setInt(
                                "funcao", userSession.getFunction);

                            Modular.to.navigate("/home/");
                          } catch (e) {
                            prefs.clear();
                            // ignore: use_build_context_synchronously
                            return showDialog(
                                context: context,
                                builder: (context) => ModalError(
                                    content: "Usuário ou senha inválidos"));
                          }
                        },
                        child: const Text(
                          "ENTRAR",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
