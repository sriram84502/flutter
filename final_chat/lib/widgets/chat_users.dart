import 'package:final_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_chat/models/chat_user.dart';

class ChatUsers extends StatefulWidget {
  const ChatUsers({Key? key, required this.user}) : super(key: key);
  final ChatUser user;
  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(user: widget.user,)));
        },
        child: ListTile(
          title: Text(widget.user.name),
          subtitle: Text(widget.user.about),
          leading: CircleAvatar(backgroundImage: NetworkImage(widget.user.image)),
          trailing: Text('12:00'),
        ),
      ),
    );
  }
}
