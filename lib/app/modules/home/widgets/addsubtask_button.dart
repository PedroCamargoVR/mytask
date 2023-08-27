import 'package:flutter/material.dart';
import 'package:mytask/app/modules/home/components/modal_addtask.dart';

class AddSubTaskButton extends StatelessWidget {
  final Function()? func;

  const AddSubTaskButton({Key? key, required this.func}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        onPressed: func,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Adicionar nova Subtarefa",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
