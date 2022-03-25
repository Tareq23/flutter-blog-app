

class CategoryModel{

  int? id;
  String? name;


  CategoryModel(this.id,this.name);

  CategoryModel.pareseJsonData(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
  }

}