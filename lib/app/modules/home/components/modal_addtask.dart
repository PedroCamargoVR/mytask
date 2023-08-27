import 'package:flutter/material.dart';
import 'package:mytask/app/modules/home/widgets/addsubtask_button.dart';
import 'package:mytask/app/modules/home/widgets/input_addtask.dart';
import 'package:mytask/app/modules/home/widgets/line_separator.dart';
import 'package:mytask/app/modules/home/components/radiobutton_priority.dart';
import 'package:mytask/app/modules/home/widgets/modal_error.dart';
import 'package:mytask/app/providers/task_provider.dart';
import 'package:mytask/data/database.dart';
import 'package:mytask/data/repository/Impl/subtask_repositoryimpl.dart';
import 'package:mytask/data/repository/Impl/task_repositoryimpl.dart';
import 'package:provider/provider.dart';

class ModalAddTask extends StatefulWidget {
  const ModalAddTask({Key? key}) : super(key: key);

  @override
  State<ModalAddTask> createState() => _ModalAddTaskState();
}

class _ModalAddTaskState extends State<ModalAddTask> {
  double addToHeight = 0;
  List<InputAddTask> listSubTasks = [
    InputAddTask(
      hintText: "Título da Subtarefa",
      maxLines: 1,
    ),
  ];
  Map<String, dynamic> formulario = {
    "campoTitulo": InputAddTask(
      hintText: "Título da tarefa",
      maxLines: 1,
      maxLength: 20,
    ),
    "campoDescricao": InputAddTask(
      hintText: "Descrição da tarefa",
      maxLines: 6,
      maxLength: 250,
    ),
    "radioButtonPrioridade": RadioButtonPriority(),
  };

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cadastro de Tarefa"),
      content: SingleChildScrollView(
        child: Form(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.75 + addToHeight,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                formulario['campoTitulo']!,
                formulario['campoDescricao']!,
                const LineSeparator(),
                const Text("Prioridade"),
                formulario['radioButtonPrioridade'],
                const LineSeparator(),
                const Text("Subtarefas"),
                Column(
                  children: listSubTasks,
                ),
                AddSubTaskButton(func: () {
                  setState(() {
                    if (listSubTasks.length >= 10) {
                      showDialog(
                        context: context,
                        builder: (context) => ModalError(content: "Só podem ser inseridas 10 subtarefas"),
                      );
                    } else {
                      listSubTasks.add(InputAddTask(
                        hintText: "Título da Subtarefa",
                        maxLines: 1,
                      ));
                      addToHeight += 60;
                    }
                  });
                })
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              side: const BorderSide(width: 1, color: Colors.blueAccent)),
          child: const Text(
            "Cancelar",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            OpenDatabase.getDatabase().then((value) {
              TaskRepositoryImpl repository = TaskRepositoryImpl(value);
              SubTaskRepositoryImpl repositorySub =
                  SubTaskRepositoryImpl(value);

              String? tituloTarefa =
                  formulario['campoTitulo'].getController().text;
              String? descricaoTarefa =
                  formulario['campoDescricao'].getController().text;
              int prioridade = 0;
              switch (formulario['radioButtonPrioridade'].getValue()) {
                case 'baixa':
                  prioridade = 0;
                  break;
                case 'media':
                  prioridade = 1;
                  break;
                case 'alta':
                  prioridade = 2;
                  break;
              }

              Map<String, dynamic> taskMap = {
                "id_user": 1,
                "title": tituloTarefa,
                "description": descricaoTarefa,
                "priority": prioridade,
              };

              repository.createTask(taskMap).then((value) {
                for (InputAddTask input in listSubTasks) {
                  if (input.getController().text.isNotEmpty) {
                    repositorySub.createSubTask(<String, dynamic>{
                      'id_task': value.getId(),
                      'description': input.getController().text,
                      'completed': 0,
                    });
                  }
                }
                Provider.of<TaskProvider>(context, listen: false)
                    .addTask(value);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Tarefa cadastrada com sucesso"),
                  backgroundColor: Colors.green,
                ));
                Navigator.pop(context);
              });
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Salvar",
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
