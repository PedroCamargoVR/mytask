import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mytask/app/app_module.dart';
import 'package:mytask/app/app_widget.dart';
import 'package:mytask/app/providers/subtask_provider.dart';
import 'package:mytask/app/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SubTaskProvider(),
        ),
      ],
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    )
  );
}
