import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:videoplayer/APIs/firebase_apis.dart';
import 'package:convert/convert.dart';
import 'package:videoplayer/models.dart';

class Register extends StatefulWidget {
  const Register({Key? key, required this.user}) : super(key: key);
  final Userdata user;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  Userdata? user;

  @override
  void initState() {
    super.initState();
    user = APIs.me;
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){

              },
              child: CircleAvatar(
                radius: mq.width*.03,
                backgroundImage: NetworkImage(widget.user.photo,),
              ),
            ),

          ],
        ),
      ),
    );
  }
}



