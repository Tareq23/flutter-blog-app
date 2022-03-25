import 'dart:convert';

class LearningCenterModel {
  final int id;
  final String name;
  final String year;
  final String division_name_eng;
  final String district_name_eng;

  LearningCenterModel(
      this.id,
      this.name,
      this.year,
      this.division_name_eng,
      this.district_name_eng,
      );

  LearningCenterModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        year = json['year'],
        division_name_eng = json['division_name_eng'],
        district_name_eng = json['district_name_eng'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'name': name,
        'year': year,
        'division_name_eng': division_name_eng,
        'district_name_eng': district_name_eng,
      };
}
