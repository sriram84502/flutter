import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  const SetupScreen({Key? key}) : super(key: key);

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    Text('Setup your profile',style: TextStyle(fontSize: 30),),
                    SizedBox(height: 10,),
                    Text('Profiles are visible to people you message,contacts and grups',textAlign: TextAlign.center,style: TextStyle(fontSize: 20.0,color: Colors.white54),),
                    CircleAvatar(
                      // backgroundImage: ,
                    )
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }
}
