import 'package:flutter/material.dart';
import 'package:mytask/app/helpers/PriorityForString.dart';
import 'package:mytask/app/modules/home/widgets/line_separator.dart';
import 'package:mytask/app/modules/home/widgets/modal_error.dart';
import 'package:mytask/app/providers/subtask_provider.dart';
import 'package:mytask/data/database.dart';
import 'package:mytask/data/models/subtask_model.dart';
import 'package:mytask/data/models/task_model.dart';
import 'package:mytask/data/repository/Impl/subtask_repositoryimpl.dart';
import 'package:mytask/data/repository/Impl/task_repositoryimpl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:mytask/app/providers/task_provider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ModalEditTask extends StatefulWidget {
  String radioValue = "";
  bool enableTitleField = false;
  bool enableDescriptionField = false;
  int idTask;
  Database db;
  final TextEditingController controllerTitle = TextEditingController(text: "");
  final TextEditingController controllerDescription =
      TextEditingController(text: "");

  ModalEditTask({Key? key, required this.idTask, required this.db})
      : super(key: key);

  @override
  State<ModalEditTask> createState() => _ModalEditTaskState();
}

class _ModalEditTaskState extends State<ModalEditTask> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (BuildContext context, TaskProvider taskProvider, Widget? child){
        return Consumer<SubTaskProvider>(
          builder: (BuildContext context, SubTaskProvider subTaskProvider, Widget? child){
            TaskModel? task = taskProvider.getTaskById(widget.idTask);
            if(task == null){
              return ModalError(content: "Erro a obter tarefa.");
            }else{
              List<SubTaskModel> subTasks = subTaskProvider.getSubTasksByIdTask(widget.idTask);
              //PREENCHENDO VALORES DOS CAMPOS TITULO, DESCRIÇÃO E PRIORIDADE
              (widget.radioValue.isEmpty)
                  ? widget.radioValue = task.getPriorityString()
                  : widget.radioValue;
              (widget.controllerTitle.text.isEmpty)
                  ? widget.controllerTitle.text = task.getTitle()
                  : widget.controllerTitle.text;
              (widget.controllerDescription.text.isEmpty)
                  ? widget.controllerDescription.text = task.getDescription()
                  : widget.controllerDescription.text;

              List<Widget> subTasksItem = [];
              if(subTasks.isEmpty){
                subTasksItem.add(const Text("Essa tarefa não possui subtarefas"));
              }else{
                for(SubTaskModel element in subTasks){
                  subTasksItem.add(Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(element.getDescription()),
                      (element.getCompleted())
                          ?  IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.done,
                          color: Colors.green,
                        ),
                      )
                          : IconButton(
                          onPressed: () {
                            Map<String, dynamic> subTask = {
                              "id": element.getId(),
                              "id_task": element.getIdTask(),
                              "description": element.getDescription(),
                              "completed": 1
                            };
                            SubTaskRepositoryImpl(widget.db).updateSubTask(subTask);
                            subTaskProvider.updateSubTasks(widget.db);
                          },
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.green,
                          ))
                    ],
                  ));
                }
              }
              return Container(
                height: (subTasks.isEmpty)
                    ? MediaQuery.of(context).size.height * 0.65
                    : MediaQuery.of(context).size.height *
                    (0.65 + (subTasks.length * 0.065)),
                width: MediaQuery.of(context).size.width * 0.7,
                child: AlertDialog(
                  title: const Text("Editar Tarefa"),
                  content: SingleChildScrollView(
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: widget.controllerTitle,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 16),
                                    enabled: widget.enableTitleField,
                                    maxLength: 20,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.enableTitleField) {
                                        widget.enableTitleField = false;
                                      } else {
                                        widget.enableTitleField = true;
                                      }
                                    });
                                  },
                                  icon: Icon((widget.enableTitleField)
                                      ? Icons.done
                                      : Icons.edit),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: widget.controllerDescription,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(8),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.white, width: 1),
                                      ),
                                    ),
                                    style: const TextStyle(fontSize: 14),
                                    enabled: widget.enableDescriptionField,
                                    maxLines: 6,
                                    maxLength: 250,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (widget.enableDescriptionField) {
                                        widget.enableDescriptionField = false;
                                      } else {
                                        widget.enableDescriptionField = true;
                                      }
                                    });
                                  },
                                  icon: Icon((widget.enableDescriptionField)
                                      ? Icons.done
                                      : Icons.edit),
                                )
                              ],
                            ),
                          ),
                          const Text("Prioridade"),
                          const LineSeparator(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Radio(
                                    value: "baixa",
                                    groupValue: widget.radioValue,
                                    onChanged: (_) {
                                      setState(() {
                                        widget.radioValue = _.toString();
                                      });
                                    }),
                                const Text("Baixa"),
                                Radio(
                                    value: "media",
                                    groupValue: widget.radioValue,
                                    onChanged: (_) {
                                      setState(() {
                                        widget.radioValue = _.toString();
                                      });
                                    }),
                                const Text(
                                  "Média",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                Radio(
                                    value: "alta",
                                    groupValue: widget.radioValue,
                                    onChanged: (_) {
                                      setState(() {
                                        widget.radioValue = _.toString();
                                      });
                                    }),
                                const Text(
                                  "Alta",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                          const Text("Subtarefas"),
                          const LineSeparator(),
                          Column(
                            children: subTasksItem,
                          )
                        ],
                      ),
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            subTaskProvider.updateSubTasks(widget.db);
                            taskProvider.updateTaskList(widget.db);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              side: const BorderSide(
                                  width: 1, color: Colors.blueAccent)),
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            OpenDatabase.getDatabase().then((value) {
                              TaskRepositoryImpl repository =
                              TaskRepositoryImpl(value);
                              int priority = PriorityForString.priorityForString(
                                  widget.radioValue);
                              Map<String, dynamic> data = {
                                "id": task.getId(),
                                "title": widget.controllerTitle.text,
                                "description": widget.controllerDescription.text,
                                "priority": priority
                              };
                              repository.updateTask(data).then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                  Text("Tarefa atualizada com sucesso"),
                                  backgroundColor: Colors.green,
                                ));
                                subTaskProvider.updateSubTasks(widget.db);
                                taskProvider.updateTaskList(widget.db);
                                Navigator.pop(context);
                              }, onError: (e) {
                                showDialog(
                                    context: context,
                                    builder: (context) => ModalError(
                                        content: "Erro ao atualizar tarefa"));
                              });
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                          ),
                          child: const Text(
                            "Salvar Alteração",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: const Text(
                          "Terminar Tarefa",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
