import 'package:flutter/foundation.dart';
import 'package:mytask/data/database.dart';
import 'package:mytask/data/models/task_model.dart';
import 'package:mytask/data/repository/Impl/task_repositoryimpl.dart';
import 'package:sqflite/sqflite.dart';

class TaskProvider with ChangeNotifier{

  TaskProvider(){
    createTaskList();
  }

  //LOADING
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //TASKS
  final List<TaskModel> _tasks = [];

  List<TaskModel> getTasks() => _tasks;

  void addTask(TaskModel task){
    _tasks.add(task);
    notifyListeners();
  }

  void removeTask(TaskModel task){
    _tasks.remove(task);
    notifyListeners();
  }

  List<TaskModel> getAllTasks(){
    return _tasks;
  }

  TaskModel? getTaskById(int idTask){
    for(TaskModel task in _tasks){
      if(task.getId() == idTask){
        return task;
      }
    }
    return null;
  }

  void createTaskList() async{
    final Database db = await OpenDatabase.getDatabase();
    try{
      TaskRepositoryImpl repository = TaskRepositoryImpl(db);
      repository.getAllTasks().then((value) {
        //ATUALIZA O ARRAY DA CLASSE
        _tasks.clear();
        _tasks.addAll(value);
      });
    }finally{
      setLoading(false);
    }
  }

  Future<void> updateTaskList(Database db) async{
    setLoading(true);
    try{
      TaskRepositoryImpl repository = TaskRepositoryImpl(db);
      repository.getAllTasks().then((value) {
        _tasks.clear();
        _tasks.addAll(value);
      });
    }finally{
      setLoading(false);
    }
  }
}