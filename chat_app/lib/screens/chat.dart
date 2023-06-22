import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

late User loginuser;

class Chat extends StatefulWidget {
  static const String id = 'chat';

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  String messageText = '';
  final messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  Future<void> messageStream() async {
    await for(var snapshot in _firestore.collection('messages').snapshots()){
      for(var message in snapshot.docs){
        print(message.data);
      }
    }
  }

  void getUser() {
    final user = _auth.currentUser;
    if (user != Null) {
      loginuser = user!;
      print(loginuser.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('⚡ Flash Chat ⚡'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder(
            stream: _firestore.collection('message').snapshots(),
              builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
                List<MessageBubble> messageWidget = [];
                messageWidget.sort((a, b) => a.time.compareTo(b.time));
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
                final messages = snapshot.data!.docs;
                for (var message in messages){
                  final messageText = message.get('text');
                  final messageSender = message.get('sender');
                  final time = message.get('time');
                  final messagewidget = MessageBubble(messageText,messageSender,time);
                  messageWidget.add(messagewidget);
              }
              return Expanded(
                child: ListView(
                  children: messageWidget,
                ),
              );
              }
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      messageText = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Message',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    ),
                  ),
                ),
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      messageController.clear();
                      print(messageText);
                      print(loginuser.email);
                      CollectionReference users = _firestore.collection('message');
                      users.add({
                        "sender":loginuser.email,
                        "text":messageText,
                        "time":DateTime.timestamp(),
                      });
                    },
                    icon: Icon(
                      Icons.send,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(this.message,this.sender,this.time);
  final String message;
  final String sender;
  final Timestamp time;
  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    if(sender == loginuser.email){
      isMe = true;
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text('$sender',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
          Material(
            elevation: 10.0,
            borderRadius: isMe?BorderRadius.only(topLeft: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)):BorderRadius.only(topRight: Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
            color: isMe?Colors.blueAccent:Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),
              child: Text('$message',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: isMe?Colors.white:Colors.black54,
                  ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

