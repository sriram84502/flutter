import 'dart:convert';
import 'package:final_chat/screens/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'login_screen.dart';
import 'package:final_chat/apis/firebase_apis.dart';
import 'package:final_chat/models/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:final_chat/widgets/chat_users.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  List<ChatUser> searchList = [];
  bool _searchactive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAPI.getSelfInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(_searchactive){
            setState(() {
              _searchactive = false;
            });
            return Future.value(false);
          }
          else{
            return Future.value(true);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              leading: const Icon(Icons.home_outlined),
              title: _searchactive?TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name, Email,....',
                ),
                autofocus: true,
                style: TextStyle(
                  fontSize: 16.0,
                ),
                onChanged: (val) {
                  searchList.clear();
                  for (var i in list){
                    if(i.name.toLowerCase().contains(val.toLowerCase()) || i.email.toLowerCase().contains(val.toLowerCase())){
                        searchList.add(i);
                    }
                    setState(() {
                      searchList;
                    });
                  }
                },
              ):Text('WeChat'),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _searchactive = !_searchactive;
                      print(_searchactive);
                    });
                  },
                  icon: Icon(_searchactive
                      ? CupertinoIcons.clear_circled_solid
                      : Icons.search),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => UserProfile(
                                  user: FirebaseAPI.me,
                                )));
                  },
                  icon: Icon(Icons.more_vert),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                FirebaseAPI.auth.signOut().then(
                      (value) => {
                        GoogleSignIn().signOut().then(
                              (value) => {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => LoginScreen())),
                              },
                            ),
                      },
                    );
              },
              child: Icon(Icons.add_comment_rounded),
            ),
            body: StreamBuilder(
              stream: FirebaseAPI.getAllUsers(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.done:
                  case ConnectionState.active:
                    if (snapshot.hasData) {
                      final data = snapshot.data!.docs;
                      list = data.map((e) => ChatUser.fromJson(e.data())).toList();
                    }
                }
                if (list.isNotEmpty) {
                  return ListView.builder(
                      itemCount: _searchactive?searchList.length:list.length,
                      itemBuilder: (context, index) {
                        return ChatUsers(user: _searchactive?searchList[index]:list[index]);
                      });
                } else {
                  return Center(
                      child: Text(
                    'No Connections Found',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ));
                }
              },
            )),
      ),
    );
  }
}
