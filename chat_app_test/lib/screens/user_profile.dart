import 'package:chat_app_test/models/chat_users.dart';
import 'package:chat_app_test/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_test/Widgets/chat_user_card.dart';
import 'package:chat_app_test/apis/firebase.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfileScreen extends StatefulWidget {
  final ChatUser user;
  const UserProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await FirebaseAPI.auth.signOut().then((value) async => {
                await GoogleSignIn().signOut().then((value) => {
                  Navigator.pop(context),
                  Navigator.pop(context),
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen())),
                    })
              });
        },
        label: const Text('Logout'),
        icon: const Icon(Icons.logout),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: mq.width * .05),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: mq.height * .05,
                width: mq.width,
              ),
              Stack(children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.user.image),
                  radius: mq.width * .25,
                ),
                Positioned(
                  height: mq.height * .40,
                  left: mq.width * .33,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 1),
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                    label: const Text(
                      '',
                      style: TextStyle(fontSize: 0.1),
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: mq.height * .03,
                width: mq.width,
              ),
              Text(
                widget.user.email,
                style: const TextStyle(fontSize: 20.0, color: Colors.black54),
              ),
              SizedBox(
                height: mq.height * .05,
                width: mq.width,
              ),
              TextFormField(
                initialValue: widget.user.name,
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person_2_rounded),
                    label: const Text('Name'),
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(mq.width * .05),
                    )),
              ),
              SizedBox(
                height: mq.height * .02,
                width: mq.width,
              ),
              TextFormField(
                initialValue: widget.user.about,
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.info_outline_rounded),
                    label: const Text('Abour'),
                    hintText: 'About',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(mq.width * .05),
                    )),
              ),
              SizedBox(
                height: mq.height * .03,
                width: mq.width,
              ),
              ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.mode_edit_outline_outlined),
                  label: const Text(
                    'UPDATE',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      minimumSize: Size(mq.width * .03, mq.height * .05))),
            ],
          ),
        ),
      ),
    );
  }
}
