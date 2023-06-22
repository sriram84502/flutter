import 'package:final_chat/models/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:final_chat/apis/firebase_apis.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'login_screen.dart';
import 'package:image_picker/image_picker.dart';

class UserProfile extends StatefulWidget {
  final ChatUser user;
  const UserProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    void _showBottomScreen() {
      showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
          ),
          builder: (_) {
            return ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Profile Photo',style: TextStyle(fontSize: 20.0),),
                      IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black87,
                        child: IconButton(
                            onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? photo = await picker.pickImage(source: ImageSource.camera);
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.add_a_photo_outlined,size: 25.0,),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.black87,
                        child: IconButton(
                          onPressed: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                            Navigator.pop(context);
                            if(image != null){
                              print(image.path);
                            }
                          },
                          icon: Icon(Icons.photo_library_outlined,size: 25.0,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          });
    }

    Size mq = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  Stack(
                    children: [
                      Positioned(
                        child: Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.user.image),
                            radius: mq.width * .25,
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: mq.height * .02,
                          left: mq.width * .6,
                          child: RawMaterialButton(
                            onPressed: () {
                              _showBottomScreen();
                            },
                            elevation: 4.0,
                            shape: CircleBorder(),
                            fillColor: Colors.white,
                            constraints: BoxConstraints.tightFor(
                              width: 48.0,
                              height: 48.0,
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: mq.height * .04,
                  ),
                  Text(widget.user.email,
                      style: TextStyle(fontSize: 20.0, color: Colors.black54)),
                  SizedBox(
                    height: mq.height * .05,
                  ),
                  TextFormField(
                    initialValue: widget.user.name,
                    onSaved: (val) => FirebaseAPI.me.name = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Ex: Alex',
                      label: Text('Name'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .02,
                  ),
                  TextFormField(
                    initialValue: widget.user.about,
                    onSaved: (val) => FirebaseAPI.me.about = val ?? '',
                    validator: (val) =>
                        val != null && val.isNotEmpty ? null : 'Required Field',
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.info_outline_rounded),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'Ex: Alex',
                      label: Text('About'),
                    ),
                  ),
                  SizedBox(
                    height: mq.height * .03,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: Size(mq.width * .4, mq.height * .05)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FirebaseAPI.updateUser();
                      }
                    },
                    icon: Icon(Icons.edit),
                    label: Text('UPDATE'),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            FirebaseAPI.auth.signOut().then(
                  (value) => {
                    GoogleSignIn().signOut().then(
                          (value) => {
                            Navigator.pop(context),
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => LoginScreen())),
                          },
                        ),
                  },
                );
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
      ),
    );
  }
}
