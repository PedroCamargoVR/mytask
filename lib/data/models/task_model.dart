class TaskModel{
  final int _id;
  final int _idUser;
  final String _title;
  final String _description;
  final int _priority;

  TaskModel({required id,required idUser,required title,required description,required priority}) : _id = id, _idUser = idUser, _title = title, _description = description, _priority = priority;
  TaskModel.forMap(Map<String, dynamic> task) : _id = task['id'], _idUser = task['id_user'], _title = task['title'], _description = task['description'], _priority = task['priority'];

  int getId() => _id;

  int getIdUser() => _idUser;

  String getTitle() => _title;

  String getDescription() => _description;

  int getPriority() => _priority;

  String getPriorityString() {
    switch(_priority){
      case 0:
        return "baixa";
      case 1:
        return "media";
      case 2:
        return "alta";
      default:
        return "";
    }
  }
}