

class DistrictModel {

  int? id;
  String? districtNameEng;
  String? districtNameBng;

  DistrictModel(this.id,this.districtNameEng,this.districtNameBng);

  DistrictModel.parseJsonData(Map<String,dynamic>data)
  {
    id = data['id']??0;
    districtNameBng = data['district_name_bng'];
    districtNameEng = data['district_name_eng'];
  }

}