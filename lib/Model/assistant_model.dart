

class AssistantModel{
  int? id;
  String? name;
  String? phone;

  AssistantModel.parseJsonData(Map<String,dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
  }
}