import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/screens/settings/myprofile_screen.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  String? _image;
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(children: [
          Hero(
            tag: 'settings',
            child: _image != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(mq.height*.1),
                  child: Image.file(
                    File(_image!),
              fit: BoxFit.cover,
              height: mq.height*.2,
                    width: mq.height*.2,
                  ),
                )
                : CircleAvatar(
                    radius: mq.height * .09,
                    backgroundImage: NetworkImage(
                        FirebaseAPIs.me?.image ?? FirebaseAPIs.me!.image),
                  ),
          ),
          SizedBox(
            height: mq.height * .03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
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
                          )),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? photo =
                            await picker.pickImage(source: ImageSource.camera);
                        if (photo != null) {
                          print('object');
                        }
                        setState(() {
                          _image = photo!.path;
                        });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: mq.height * .02),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(fontSize: mq.height * .017),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        setState(() {
                          _image = image!.path;
                        });
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: mq.height * .02),
                        child: Icon(Icons.photo_outlined),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    Text(
                      'Photo',
                      style: TextStyle(fontSize: mq.height * .017),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: mq.height * .02),
                        child: Icon(CupertinoIcons.textformat_alt),
                      ),
                    ),
                    SizedBox(
                      height: mq.height * .01,
                    ),
                    Text(
                      'Text',
                      style: TextStyle(fontSize: mq.height * .017),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: mq.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
            ],
          ),
          SizedBox(
            height: mq.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
            ],
          ),
          SizedBox(
            height: mq.height * .03,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
              CircleAvatar(
                radius: mq.height * .05,
                backgroundImage: AssetImage('images/login.png'),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAPIs.updateProfilePic(File(_image!));
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MyProfile()));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}
