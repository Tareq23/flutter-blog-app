

class SubDistrictModel {

  int? id;
  String? upazilaNameEng;
  String? upazilaNameBng;

  SubDistrictModel(this.id,this.upazilaNameEng,this.upazilaNameBng);

  SubDistrictModel.parseJsonData(Map<String,dynamic>data)
  {
    id = data['id'];
    upazilaNameBng = data['upazila_name_bng'];
    upazilaNameEng = data['upazila_name_eng'];
  }

}