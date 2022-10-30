


class CityCorporationModel {

  int? id;
  String? cityNameEng;
  String? cityNameBng;

  CityCorporationModel(this.id,this.cityNameEng,this.cityNameBng);

  CityCorporationModel.parseJsonData(Map<String,dynamic>data)
  {
    id = data['id']??0;
    cityNameEng = data['city_corporation_name_eng'];
    cityNameBng = data['city_corporation_name_bng'];
  }

}