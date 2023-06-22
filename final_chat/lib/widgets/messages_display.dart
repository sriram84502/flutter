import 'package:final_chat/apis/firebase_apis.dart';
import 'package:final_chat/helpers/my_date.dart';
import 'package:flutter/material.dart';
import 'package:final_chat/models/massages.dart';
import 'package:intl/intl.dart';

late Size mq;

class MessageDisplay extends StatefulWidget {
  final Messages messages;
  const MessageDisplay({Key? key, required this.messages}) : super(key: key);

  @override
  State<MessageDisplay> createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return widget.messages.fromid == FirebaseAPI.me.email
        ? senderMessage()
        : receiverMessage();
  }

  Widget senderMessage() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.messages.msg,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mq.width * .05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(''),
                  Text(
                    '12:00 pm',
                    style: TextStyle(color: Colors.white38),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget receiverMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Text(
                widget.messages.msg,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: mq.width * .05,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(''),
                  Row(
                    children: [
                      Text(
                        GetTime.getFormatedDate(
                            context: context, time: widget.messages.sent),
                        style: TextStyle(color: Colors.white38),
                      ),
                      widget.messages.read.isNotEmpty
                          ? Icon(
                              Icons.done_all,
                              color: Colors.blue,
                            )
                          : Icon(Icons.done_all),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
