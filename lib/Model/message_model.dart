

import 'dart:convert';

import 'package:flutter/cupertino.dart';

class MessageModel{
  int? id;
  int? parentId;
  int? userId;
  String? name;
  String? messageText;
  String? imgUrl;
  DateTime? created_at;
  String? createdAtAgo;
  MessageModel(this.id,this.parentId,this.name,this.messageText,this.imgUrl,this.created_at,this.createdAtAgo);

  MessageModel.parseJsonData(Map<String,dynamic>json){
    id = json['id'];
    messageText = json['body'];
    name = json['user_name'];
    parentId = json['parent_id'];
    userId = json['user_id'];
    imgUrl = json['image'];
    created_at = DateTime.tryParse(json['created_at']);
    createdAtAgo = json['created_at_ago'];
    //var msgList = jsonDecode(json['replay']) as List;
    //print(msgList);
  }
}