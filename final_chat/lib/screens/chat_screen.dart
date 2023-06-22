import 'dart:convert';
import 'package:final_chat/models/massages.dart';
import 'package:final_chat/widgets/messages_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_chat/models/chat_user.dart';
import 'package:final_chat/apis/firebase_apis.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);
  final ChatUser user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textController = TextEditingController();
  List<Messages> list = [];
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leadingWidth: mq.width * .07,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.image),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: TextStyle(fontSize: mq.height * .02),
                  ),
                  Text(
                    'last seen recently',
                    style: TextStyle(fontSize: mq.height * .015),
                  )
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: FirebaseAPI.getAllMessages(widget.user),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case ConnectionState.done:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final data = snapshot.data!.docs;
                        list = data
                            .map((e) => Messages.fromJson(e.data()))
                            .toList();
                      }
                  }
                  if (list.isNotEmpty) {
                    return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return MessageDisplay(messages: list[index]);
                        });
                  } else {
                    return Center(
                        child: Text(
                      'Say hello👋',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w500),
                    ));
                  }
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
                      Expanded(
                        child: TextField(
                          controller: textController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Message',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.attach_file)),
                      IconButton(
                          onPressed: () {}, icon: Icon(Icons.camera_alt)),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      FirebaseAPI.sendMessage(widget.user, textController.text);
                    }
                  },
                  shape: CircleBorder(),
                  minWidth: 0,
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
