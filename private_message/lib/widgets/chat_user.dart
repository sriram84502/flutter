import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/models/chatusers.dart';
import 'package:private_message/models/messages.dart';
import 'package:private_message/screens/chat/chat_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:private_message/widgets/dateviewer.dart';
import 'package:private_message/widgets/user_profile_view.dart';

class ChatUsers extends StatefulWidget {
  final GetChatUsers users;
  const ChatUsers({Key? key, required this.users}) : super(key: key);

  @override
  State<ChatUsers> createState() => _ChatUsersState();
}

class _ChatUsersState extends State<ChatUsers> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAPIs.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    Messages? message;
    Size mq = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
              users: widget.users,
            ),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 500),
          ),
        );
      },
      child: Card(
        child: StreamBuilder(
            stream: FirebaseAPIs.getLastMessage(widget.users),
            builder: (context, snapshots) {
              final data = snapshots.data?.docs;
              final list =
                  data?.map((e) => Messages.fromJson(e.data())).toList() ?? [];
              if (list.isNotEmpty) message = list[0];
              return ListTile(
                leading: Container(
                  width: 45,
                  height: 150,
                  child: InkWell(
                    onTap: (){
                      showDialog(context: context, builder: (_) => Profileview(user: widget.users));
                    },
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.users.image)),
                  ),
                ),
                title: Text(widget.users.name),
                subtitle:
                    message?.type == Type.text?
                    Text(message != null ? message!.msg : widget.users.about):
                    Row(
                      children: [
                        Icon(Icons.photo),
                        Text('photo')
                      ],
                    ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message != null
                          ? DateViewer.getLastMessageTime(
                              context, message!.sent)
                          : '',
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    if (message != null)
                      if (message!.read.isEmpty  && message!.toid==FirebaseAPIs.auth.currentUser!.uid)
                        CircleAvatar(
                          radius: 10.0,
                          backgroundColor: Colors.green,
                          child: Text(
                            '1',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
