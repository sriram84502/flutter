import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/models/chatusers.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.users}) : super(key: key);
  final GetChatUsers users;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                  tag: 'profile',
                  child: CircleAvatar(
                    radius: mq.height*.06,
                    backgroundImage: NetworkImage(widget.users.image),
                  ),
                ),
                SizedBox(
                  height: mq.height*.01,
                ),
                Text(widget.users.name,style: TextStyle(fontSize: mq.height*.04),),
                SizedBox(
                  height: mq.height*.015,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueGrey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )
                          ),
                            onPressed: (){},
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: mq.height*.02),
                              child: Icon(Icons.videocam_outlined),
                            ),
                        ),
                        SizedBox(
                          height: mq.height*.01,
                        ),
                        Text('Video',style: TextStyle(fontSize: mq.height*.017),),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                          onPressed: (){},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: mq.height*.02),
                            child: Icon(CupertinoIcons.phone),
                          ),
                        ),
                        SizedBox(
                          height: mq.height*.01,
                        ),
                        Text('Call',style: TextStyle(fontSize: mq.height*.017),),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                          onPressed: (){},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: mq.height*.02),
                            child: Icon(CupertinoIcons.bell),
                          ),
                        ),
                        SizedBox(
                          height: mq.height*.01,
                        ),
                        Text('Mute',style: TextStyle(fontSize: mq.height*.017),),
                      ],
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              )
                          ),
                          onPressed: (){},
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: mq.height*.02),
                            child: Icon(Icons.search),
                          ),
                        ),
                        SizedBox(
                          height: mq.height*.01,
                        ),
                        Text('Search',style: TextStyle(fontSize: mq.height*.017),),
                      ],
                    ),

                  ],
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.alarm_off_outlined,color: Colors.white,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('Disappearing messages'),
                    subtitle: Text('Off',style: TextStyle(color: Colors.white70),),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.color_lens_outlined,color: Colors.white,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('Chat color & wallpapers'),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.volume_up_outlined,color: Colors.white,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('Sounds & notifications'),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.add,color: Colors.white,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('Add as a contact'),
                  ),
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.shield_outlined,color: Colors.white,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('view safter number'),
                  ),
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 23.0,bottom: 5.0),
                      child: Text('No groups in common'),
                    ),
                  ],
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.add,color: Colors.white,),
                      backgroundColor: Colors.black12,
                    ),
                    title: Text('Add to a group'),
                  ),
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: mq.height*.015,
                ),
                InkWell(
                  onTap: (){
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.block,color: Colors.red,),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text('Block',style: TextStyle(color: Colors.red),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
