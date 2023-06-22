import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/models/chatusers.dart';
import 'package:private_message/screens/login/start_screen.dart';
import 'package:private_message/screens/settings/setting_screen.dart';
import 'package:private_message/widgets/chat_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<GetChatUsers> list = [];
  List<GetChatUsers> searchusers = [];
  bool enableSearch = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAPIs.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
              icon: const Icon(Icons.menu),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: enableSearch
              ? TextField(
                  autofocus: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: 'Name ,Number,..',
                    border: InputBorder.none,
                  ),
                  onChanged: (val) {
                    searchusers.clear();
                    for(var i in list){
                      if(i.name.toLowerCase().contains(val.toLowerCase()) || i.phoneNumber.toLowerCase().contains(val.toLowerCase())){
                        searchusers.add(i);
                      }
                      setState(() {
                        searchusers;
                      });
                    }
                  },
                )
              : Text('Private'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                enableSearch = !enableSearch;
              });
            },
            icon: Icon(enableSearch ? Icons.cancel : Icons.search),
          ),
          if (!enableSearch)
            IconButton(
              onPressed: () {
                // Your desired action for the second IconButton
              },
              icon: Icon(Icons.more_vert),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseAPIs.auth.signOut();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => StartScreen()));
        },
        child: const Icon(Icons.edit),
      ),
      body: StreamBuilder(
          stream: FirebaseAPIs.getAllUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.active:
              case ConnectionState.done:
                list.clear();
                final data = snapshot.data?.docs;
                list = data
                        ?.map((e) => GetChatUsers.fromJson(e.data()))
                        .toList() ??
                    [];
                if (list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: enableSearch?searchusers.length:list.length,
                    itemBuilder: (context, index) {
                      return ChatUsers(
                        users: enableSearch?searchusers[index]:list[index],
                      );
                    },
                  );
                }
                return Center(
                  child: Text('No Connections found'),
                );
            }
          }),
    );
  }
}
