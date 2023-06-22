import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/screens/settings/name.dart';
import 'package:private_message/screens/settings/profile_edit.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Hero(
                tag: 'settings',
                child: CircleAvatar(
                  radius: mq.height*.05,
                  backgroundImage: NetworkImage(FirebaseAPIs.me?.image ?? FirebaseAPIs.me!.image),
                ),
              ),
              SizedBox(
                height: mq.height*.01,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileEdit()));
                  },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                  child: Text('Edit photo'),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => YourName()));
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.person_2_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(FirebaseAPIs.me?.name ?? FirebaseAPIs.me!.name),
                  subtitle: Text('Your name',style: TextStyle(color: Colors.white54),),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.mode_edit_outline_outlined,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(FirebaseAPIs.me?.about ?? FirebaseAPIs.me!.about),
                  subtitle: Text('Write a few words about yourself',style: TextStyle(color: Colors.white54),),
                ),
              ),
              InkWell(
                onTap: (){
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(CupertinoIcons.star,color: Colors.white,),
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text('Premium'),
                  // subtitle: Text('Your name',style: TextStyle(color: Colors.white54),),
                ),
              ),
              SizedBox(
                height: mq.height*.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0,left: 20.0),
                child: Text('Your profile and changes to it will be visible to people you message,contacts and groups.',style: TextStyle(fontSize: 15.0,color: Colors.white54),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
