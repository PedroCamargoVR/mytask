class SubTaskModel{
  final int _id;
  final int _idTask;
  final String _description;
  final bool _completed;

  SubTaskModel({required id, required idTask, required description, required completed}) : _id = id, _idTask = idTask, _description = description, _completed = completed;
  SubTaskModel.forMap(Map<String, dynamic> subTask) : _id = subTask['id'], _idTask = subTask['id_task'], _description = subTask['description'], _completed = (subTask['completed'] == 0) ? false : true;

  int getId() => _id;

  int getIdTask() => _idTask;

  String getDescription() => _description;

  bool getCompleted() => _completed;

}