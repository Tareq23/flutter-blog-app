import 'dart:convert';

class DropDownProUpdModel {
  final int id;

  final String division_name_eng;
  final String district_name_eng;

  DropDownProUpdModel(
      this.id,

      this.division_name_eng,
      this.district_name_eng,
      );

  DropDownProUpdModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],

        division_name_eng = json['division_name_eng'],
        district_name_eng = json['district_name_eng'];


  Map<String, dynamic> toJson() =>
      {
        'id' : id,

        'division_name_eng': division_name_eng,
        'district_name_eng': district_name_eng,
      };
}
