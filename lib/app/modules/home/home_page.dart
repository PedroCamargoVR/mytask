import 'package:flutter/material.dart';
import 'package:mytask/app/modules/home/widgets/addtask_button.dart';
import 'package:mytask/app/modules/home/components/card_task.dart';
import 'package:mytask/app/modules/home/components/header_home.dart';
import 'package:mytask/app/modules/home/widgets/modal_error.dart';
import 'package:mytask/app/providers/task_provider.dart';
import 'package:mytask/data/models/task_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 40,
              ),
            ),
          )
        ],
        title: const Center(
            child: Text(
          "Reginaldo",
        )),
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          const HeaderHome(),
          Expanded(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16.0),
                    child: Center(child: AddTaskButton()),
                  ),
                ),
                Consumer<TaskProvider>(
                  builder: (BuildContext context, TaskProvider tasks, Widget? child) {
                    if (tasks.isLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: SizedBox(
                            width: 75,
                            height: 75,
                            child: CircularProgressIndicator(
                              strokeWidth: 10,
                            ),
                          ),
                        ),
                      );
                    } else {
                      List<CardTask> cardsTasks = [];
                      for (TaskModel task in tasks.getTasks()) {
                        cardsTasks.add(CardTask(
                          id: task.getId(),
                          title: task.getTitle(),
                          prioridade: task.getPriority(),
                        ));
                      }
                      if (cardsTasks.isEmpty) {
                        return const SliverToBoxAdapter(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text("Nenhuma tarefa encontrada."),
                          ),
                        );
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: cardsTasks.length,
                            (context, index) {
                              return Center(child: cardsTasks[index]);
                            },
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
