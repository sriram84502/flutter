import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/screens/settings/myprofile_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyProfile()));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'settings',
                        child: CircleAvatar(
                          radius: mq.height*.04,
                          backgroundImage: NetworkImage(FirebaseAPIs.me?.image ?? FirebaseAPIs.me!.image),
                        ),
                      ),
                      SizedBox(width: 15,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(FirebaseAPIs.me?.name ?? FirebaseAPIs.me!.name,style: TextStyle(fontSize: 20.0),),
                          SizedBox(height: 3,),
                          Text(FirebaseAPIs.me?.phoneNumber ?? FirebaseAPIs.me!.phoneNumber,style: TextStyle(color: Colors.white54),)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CupertinoIcons.person_crop_circle,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Account'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.phonelink_sharp,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Linked devices'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CupertinoIcons.heart,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Donate'),
                ),
              ),
              SizedBox(
                height: mq.height*.01,
              ),
              Divider(
                color: Colors.white12,
                thickness: 1.0,
              ),
              SizedBox(
                height: mq.height*.01,
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.brightness_medium_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Appearance'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CupertinoIcons.chat_bubble,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Chats'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.add_box_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Stories'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.notifications_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Notifications'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.lock_open_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Privacy'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.pie_chart_outline,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Data & Storage'),
                ),
              ),
              SizedBox(
                height: mq.height*.01,
              ),
              Divider(
                color: Colors.white12,
                thickness: 1.0,
              ),
              SizedBox(
                height: mq.height*.01,
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CupertinoIcons.question_circle,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Help'),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.mail_outline,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Invite your friends'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
