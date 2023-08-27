class FunctionModel {
  int _id;
  String _description;

  FunctionModel({required id, required description}) : _id = id, _description = description;
  FunctionModel.forMap(Map<String, dynamic> map) : _id = map['id'],_description = map['description'];

  int getId() => _id;
  String getDescription() => _description;

  Map<String, dynamic> toMap(){
    return {
      "id": _id,
      "description": _description
    };
  }
}