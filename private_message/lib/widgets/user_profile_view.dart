import 'package:flutter/material.dart';
import 'package:private_message/models/chatusers.dart';
import 'package:private_message/screens/chat/user_profile_screen.dart';

class Profileview extends StatefulWidget {
  const Profileview({Key? key, required this.user}) : super(key: key);
  final GetChatUsers user;
  @override
  State<Profileview> createState() => _ProfileviewState();
}

class _ProfileviewState extends State<Profileview> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: Colors.white.withOpacity(.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SizedBox(
        width: mq.width * .6,
        height: mq.height * .3,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.user.name,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfile(users: widget.user)));
                    },
                    icon: Icon(Icons.info_outline_rounded,color: Colors.blue,)),
              ],
            ),
            Image.network(widget.user.image,width: mq.width*.5,),
          ],
        ),
      ),
    );
  }
}
