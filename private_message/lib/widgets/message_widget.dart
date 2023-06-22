import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/widgets/dateviewer.dart';
import '../models/messages.dart';

late Size mq;

class MessageWidget extends StatefulWidget {
  const MessageWidget({Key? key, required this.message}) : super(key: key);
  final Messages message;
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return FirebaseAPIs.me!.id == widget.message.toid ? sender() : user();
  }

  Widget user() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (widget.message.read.isNotEmpty)
              Icon(
                Icons.done_all_outlined,
                color: Colors.blue,
                size: 20,
              ),
            Text(
              DateViewer.getDateFormat(context, widget.message.sent),
            )
          ],
        ),
        Flexible(
          child: Container(
              padding: EdgeInsets.all(mq.height * .02),
              margin: EdgeInsets.symmetric(
                  vertical: mq.height * .01, horizontal: mq.height * .01),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  )),
              child: widget.message.type == Type.text
                  ? Text(widget.message.msg)
                  :
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(imageUrl: widget.message.msg,
                    ),

                  )
          ),
        ),
      ],
    );
  }

  Widget sender() {
    if (widget.message.read.isNotEmpty) {
      FirebaseAPIs.updateReadTime(widget.message);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.height * .02),
            margin: EdgeInsets.symmetric(
                vertical: mq.height * .01, horizontal: mq.height * .01),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                )),
            child: Text(widget.message.msg),
          ),
        ),
        Row(
          children: [
            Text(
              DateViewer.getDateFormat(context, widget.message.sent),
            )
          ],
        )
      ],
    );
  }
}
