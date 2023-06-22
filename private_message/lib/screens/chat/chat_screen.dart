import 'dart:io' show File, Platform;
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/models/chatusers.dart';
import 'package:private_message/models/messages.dart';
import 'package:private_message/screens/chat/user_profile_screen.dart';
import 'package:private_message/widgets/message_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.users}) : super(key: key);
  final GetChatUsers users;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController send = TextEditingController();
  TextEditingController message = TextEditingController();
  bool emoji = false;
  String? _image;
  List<Messages> list = [];
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserProfile(
                    users: widget.users,
                  ),
                ));
          },
          child: Row(
            children: [
              Hero(
                tag: 'profile',
                child: CircleAvatar(
                  radius: mq.height * .02,
                  backgroundImage: NetworkImage(widget.users.image),
                ),
              ),
              SizedBox(
                width: mq.width * .03,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.users.name,
                    style: TextStyle(fontSize: mq.height * .02),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.videocam_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.phone),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: FirebaseAPIs.getAllMessages(widget.users),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                      // return Center(
                      //   child: CircularProgressIndicator(),
                      // );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        list = data
                                ?.map((e) => Messages.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (list.isNotEmpty) {
                          return ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              return MessageWidget(message: list[index]);
                            },
                          );
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No messages have yet....',
                              style: TextStyle(fontSize: mq.height * .017),
                            ),
                            SizedBox(
                              height: mq.height * .02,
                            ),
                            Text('Say Hii 👋',
                                style: TextStyle(fontSize: mq.height * .019)),
                          ],
                        );
                    }
                  }),
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            setState(() {
                              emoji = !emoji;
                            });
                          },
                          icon: Icon(Icons.emoji_emotions_outlined),
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                message.text = value;
                              });
                            },
                            onTap: () {
                              setState(() {
                                if (emoji) emoji = !emoji;
                              });
                            },
                            controller: message,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter message',
                            ),
                          ),
                        ),
                        if (message.text.isEmpty)
                          ...<Widget>[
                            IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 70);
                                if (photo != null) {
                                  print('object');
                                }
                                await FirebaseAPIs.sendPhoto(
                                    widget.users, File(photo!.path));
                                setState(() {
                                  _image = photo!.path;
                                });
                              },
                              icon: Icon(Icons.camera_alt_outlined),
                            ),
                            IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                final XFile? photo = await picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 70);
                                if (photo != null) {
                                  print('object');
                                }
                                await FirebaseAPIs.sendPhoto(
                                    widget.users, File(photo!.path));
                                setState(() {
                                  _image = photo!.path;
                                });
                              },
                              icon: Icon(Icons.photo_outlined),
                            ),
                          ].toList(),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                    shape: CircleBorder(),
                    onPressed: () {
                      if(message.text.isNotEmpty){
                        FirebaseAPIs.sendMessage(
                            widget.users, message.text, Type.text);
                        message.text = '';
                      }
                    },
                    minWidth: 0,
                    color: Colors.blue,
                    child: Icon(message.text.isEmpty ? Icons.mic_none_outlined : Icons.send)),
              ],
            ),
            if (emoji)
              SizedBox(
                height: mq.height * .35,
                child: EmojiPicker(
                  textEditingController: message,
                  config: Config(
                    columns: 9,
                    bgColor: Colors.black12,
                    emojiSizeMax: 32 * (Platform.isAndroid ? 1 : 1.0),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
