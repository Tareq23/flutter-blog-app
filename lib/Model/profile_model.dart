// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
     this.id,
     this.name,
     this.email,
     this.phone,
     this.type,
     this.slug,
     this.contactId,
     this.address,
     this.about,
     this.website,
     this.registrationNumber,
     this.mapLink,
     this.districtId,
     this.subdistrictId,
     this.divisionId,
     this.updatedBy,
     this.createdBy,
     this.image,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  int? type;
  String? slug;
  int? contactId;
  String? address;
  String? about;
  String? website;
  String? registrationNumber;
  String? mapLink;
  String? districtId;
  String? subdistrictId;
  String? divisionId;
  String? updatedBy;
  String? createdBy;

  String? image;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    type: json["type"],
    slug: json["slug"],
    contactId: json["contact_id"],
    address: json["address"],
    about: json["about"],
    website: json["website"],
    registrationNumber: json["registration_number"],
    mapLink: json["map_link"],
    districtId: json["district_id"],
    subdistrictId: json["subdistrict_id"],
    divisionId: json["division_id"],
    updatedBy: json["updated_by"],
    createdBy: json["created_by"],

    image: json["image"],
  );


  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "type": type,
    "slug": slug,
    "contact_id": contactId,
    "address": address,
    "about": about,
    "website": website,
    "registration_number": registrationNumber,
    "map_link": mapLink,
    "district_id": districtId,
    "subdistrict_id": subdistrictId,
    "division_id": divisionId,
    "updated_by": updatedBy,
    "created_by": createdBy,
    "image": image,
  };
}
