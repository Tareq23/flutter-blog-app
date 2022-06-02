

class PostModel{


   int? id;
   int? job_id;
   String? headline;
   String? author;
   String? content;
   double? experience;
   String? name;
   String? phone;
   String? expired_at;
   String? image;
   String? slug;
   DateTime? created_at;
   int? status;
   String? videlUrl;

  PostModel({
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
    this.created_at,
    this.videlUrl
  });

   PostModel.fromJson(Map<String, dynamic> json)
       : id = json['id'],
         content = json['content'],
         name = json['name'],
         phone = json['phone'],
         author = json['author'],
         experience = json['experience'],
         expired_at = json['expired_at'],
         image = json['image'],
         slug = json['slug'],
         headline = json['headline'],
         videlUrl = json['video'],
         created_at = DateTime.tryParse(json['created_at'],
         );

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
         'video' : videlUrl
       };
}