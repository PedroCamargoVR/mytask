import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ModalSessaoExpirada extends StatelessWidget {
  String content;
  ModalSessaoExpirada({Key? key,required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.warning,color: Colors.blueAccent,size: 100,),
            Text(content,style: const TextStyle(fontSize: 26),textAlign: TextAlign.center,),
          ],
        ),
      ),
      actions: [
        SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Modular.to.navigate("/login/"), child: const Text("Ok"),)),
      ],
    );
  }
}
