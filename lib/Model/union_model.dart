


class UnionModel {

  int? id;
  String? unionNameEng;
  String? unionNameBng;

  UnionModel(this.id,this.unionNameEng,this.unionNameBng);

  UnionModel.parseJsonData(Map<String,dynamic>data)
  {
    id = data['id'];
    unionNameEng = data['union_name_eng'];
    unionNameBng = data['union_name_bng'];
  }

}