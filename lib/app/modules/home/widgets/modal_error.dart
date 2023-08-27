import 'package:flutter/material.dart';

class ModalError extends StatelessWidget {
  String content;
  ModalError({Key? key,required this.content}) : super(key: key);

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
        SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Voltar"),)),
      ],
    );
  }
}
