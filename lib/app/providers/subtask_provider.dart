import 'package:flutter/foundation.dart';
import 'package:mytask/data/database.dart';
import 'package:mytask/data/models/subtask_model.dart';
import 'package:mytask/data/repository/Impl/subtask_repositoryimpl.dart';
import 'package:sqflite/sqflite.dart';

class SubTaskProvider with ChangeNotifier {

  SubTaskProvider(){
    createSubTaskList();
  }

  final List<SubTaskModel> _list = [];

  void addSubTask(SubTaskModel stm){
      _list.add(stm);
      notifyListeners();
  }

  void removeSubTask(SubTaskModel stm){
    _list.remove(stm);
    notifyListeners();
  }

  void createSubTaskList() async{
    final Database db = await OpenDatabase.getDatabase();
    SubTaskRepositoryImpl repository = SubTaskRepositoryImpl(db);
    repository.getAllSubTasks().then((value) {
      _list.addAll(value);
    });
  }

  void updateSubTasks(Database db) async{
    SubTaskRepositoryImpl repository = SubTaskRepositoryImpl(db);
    repository.getAllSubTasks().then((value) {
      _list.clear();
      _list.addAll(value);
      notifyListeners();
    });
  }

  List<SubTaskModel> getSubTasksByIdTask(int idTask){
    List<SubTaskModel> listSubTask = [];
    for(SubTaskModel subTask in _list){
      if(subTask.getIdTask() == idTask){
        listSubTask.add(subTask);
      }
    }
    return listSubTask;
  }

  double getPercentCompleted(int idTask){
    List<SubTaskModel> subTasks = [];
    for (SubTaskModel subTask in _list) {
      if(subTask.getIdTask() == idTask){
        subTasks.add(subTask);
      }
    }
    if(subTasks.length <= 0){
      return 0;
    }else{
      int completedTasks = 0;
      for(SubTaskModel subTask in subTasks){
        if(subTask.getCompleted()){
          completedTasks += 1;
        }
      }
     return  double.parse((completedTasks / subTasks.length).toStringAsFixed(2));
    }
  }

}