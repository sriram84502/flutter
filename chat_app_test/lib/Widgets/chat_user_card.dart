import 'package:chat_app_test/models/chat_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  const ChatUserCard({Key? key, required this.user}) : super(key: key);
  final ChatUser user;
  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: InkWell(
        child: ListTile(
          leading: CircleAvatar(backgroundImage: NetworkImage(widget.user.image),),
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about,maxLines: 1),
          trailing: const Text('4:30',style: TextStyle(color: Colors.black38)),
        ),
      ),
    );
  }
}
