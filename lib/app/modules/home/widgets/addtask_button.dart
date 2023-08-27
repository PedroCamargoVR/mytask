import 'package:flutter/material.dart';
import 'package:mytask/app/modules/home/components/modal_addtask.dart';

class AddTaskButton extends StatelessWidget {
  //final Function()? func;

  const AddTaskButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const ModalAddTask(),
          );
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
            ),
            Text(
              "Adicionar nova tarefa",
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
