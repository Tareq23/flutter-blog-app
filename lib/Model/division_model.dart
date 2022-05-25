

class DivisionModel {

  int? id;
  String? divisionNameEng;
  String? divisionNameBng;

  DivisionModel(this.id,this.divisionNameEng,this.divisionNameBng);

  DivisionModel.parseJsonData(Map<String,dynamic>data)
  {
    id = data['id'];
    divisionNameBng = data['division_name_bng'];
    divisionNameEng = data['division_name_eng'];
  }

}