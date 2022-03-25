import 'dart:convert';

BlogModel importantFormModelFromJson(String str) => BlogModel.fromJson(json.decode(str));

String importantFormModelToJson(BlogModel data) => json.encode(data.toJson());

class BlogModel {

  final int? id;
  final String? headline;
  final String? author;
  final String? content;
  final double? experience;
  final String? name;
  final String? phone;
  final String? expired_at;
  final String? image;
  final String? slug;



  BlogModel({
    this.id,
    this.headline,
    this.author,
    this.content,
    this.experience,
    this.name,
    this.phone,
    this.expired_at,
    this.image,
    this.slug,
  });

  BlogModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        content = json['content'],
        name = json['name'],
        phone = json['phone'],
        author = json['author'],
        experience = json['experience'],
        expired_at = json['expired_at'],
        image = json['image'],
        slug = json['slug'],
        headline = json['headline'];



  Map<String, dynamic> toJson() =>
      {
        'id' : id,
        'headline' : headline,
        'author' : author,
        'experience' : experience,
        'content' : content,
        'name' : name,
        'phone' : phone,
        'expired_at' : expired_at,
        'slug' : slug,
        'image' : image,

      };
}
