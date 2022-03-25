import 'dart:convert';

class PublicBlogListModel {

  PublicBlogListModel(
      this.headline,
      this.author,
      this.id,
      this.image,
      this.phone,
      this.content,
      this.jobCategory,


      );


  String headline;
  String author;
  int id;
  String content;
  String image;
  String phone;
  String jobCategory;

  PublicBlogListModel.fromJson(Map<String, dynamic> json)
      : author = json['author'],
        image = json['image'],
        jobCategory = json['jobCategory'],
        id = json['id'],
        phone = json['phone'],
        content = json['content'],
        headline = json['headline'];

  Map<String, dynamic> toJson() =>
      {

        "headline": headline,
        "image": image,
        "id": id,
        "phone": phone,
        "content": content,
        "jobCategory": jobCategory,

        "author": author,

      };
}
