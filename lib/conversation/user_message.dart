import 'package:blog_app/conversation/message_ui.dart';
import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  int? id;
  String? name;
  String? messageText;
  String? imageUrl;
  String? time;
  String? timeAgo;
  ConversationList({Key? key,@required this.id, @required this.name,@required this.messageText,
    @required this.imageUrl,@required this.time,@required this.timeAgo}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
      },
      onLongPress: (){


      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    // backgroundImage: NetworkImage(widget.imageUrl.toString()),

                    // ignore: unnecessary_null_comparison
                    // backgroundImage: AssetImage("assets/default_person.jpg"),
                    backgroundImage: (widget.imageUrl == null || widget.imageUrl == '')
                        ? const AssetImage("assets/default_person.jpg")
                        : NetworkImage(widget.imageUrl.toString()) as ImageProvider,
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.messageText.toString(),style: const TextStyle(fontSize: 16,color: Color(
                              0xFF181818),),),
                          const SizedBox(height: 6,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.name.toString(), style: const TextStyle(fontSize: 13,color: Color(
                                  0xFF505050)),),
                              Text(widget.timeAgo.toString(), style: const TextStyle(fontSize: 11,color: Color(
                                  0xFF505050)),),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
