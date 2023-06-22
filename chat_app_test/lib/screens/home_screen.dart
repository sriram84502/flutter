import 'package:chat_app_test/models/chat_users.dart';
import 'package:chat_app_test/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_test/Widgets/chat_user_card.dart';
import 'package:chat_app_test/apis/firebase.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUser> list = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Chat App'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => UserProfileScreen(user: list[0],)));
            },
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add_comment_rounded),
      ),
      body: StreamBuilder(
        stream: FirebaseAPI.firestore.collection('users').where('id',isNotEqualTo: FirebaseAPI.auth.currentUser!.uid).snapshots(),
        builder: (context, snapshots) {
          switch (snapshots.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshots.hasData) {
                var data = snapshots.data?.docs;
                list = data!.map((e) => ChatUser.fromJson(e.data())).toList();
              }
              print(list.length);
              if(!list.isEmpty){
                return ListView.builder(
                  itemCount: list.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ChatUserCard(user: list[index],);
                  },
                );
              }
              else{
                return Center(child: Text('No connection found'),);
              }
          }
        },
      ),
    );
  }
}
