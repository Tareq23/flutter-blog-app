import 'package:flutter/material.dart';

class ConversationList extends StatefulWidget {
  String? name;
  String? messageText;
  String? imageUrl;
  String? time;
  ConversationList({Key? key, @required this.name,@required this.messageText,@required this.imageUrl,@required this.time}) : super(key: key);
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
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
                    backgroundImage: AssetImage(widget.imageUrl.toString()),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.name.toString(), style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.messageText.toString(),style: TextStyle(fontSize: 13,color: Colors.grey.shade600,),),
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
