// ignore_for_file: await_only_futures

import 'package:final_chat/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_chat/models/massages.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAPI {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;
  static late ChatUser me;

  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> updateUser() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': me.name, 'about': me.about});
  }

  static Future<void> getSelfInfo() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.exists) {
        me = ChatUser.fromJson(value.data()!);
      } else {
        newUser();
        me = ChatUser.fromJson(value.data()!);
      }
    });
  }

  static Future<void> newUser() async {
    final date = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        image: auth.currentUser!.photoURL.toString(),
        about: 'Hey i am using WeChat',
        name: auth.currentUser!.displayName.toString(),
        createdAt: date,
        lastActive: date,
        isOnline: false,
        id: auth.currentUser!.uid.toString(),
        email: auth.currentUser!.email.toString(),
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(chatUser.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return FirebaseAPI.firestore
        .collection('users')
        .where('id', isNotEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static String getConversationsID(String ID) =>
      auth.currentUser!.uid.hashCode <= ID.hashCode
          ? '${auth.currentUser!.uid}_$ID'
          : '${ID}_${auth.currentUser!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser customuser) {
    return FirebaseAPI.firestore
        .collection('chats/${getConversationsID(customuser.id)}/messages')
        .snapshots();
  }

  static Future<void> sendMessage(ChatUser customuser, String msg) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    Messages data = Messages(
      toid: customuser.id,
      msg: msg,
      read: '',
      type: Type.text,
      sent: time,
      fromid: auth.currentUser!.uid,
    );
    final ref = FirebaseAPI.firestore
        .collection('chats/${getConversationsID(customuser.id)}/messages');
    await ref.doc(time).set(data.toJson());
  }

  static Future<void> updateReadTime(Messages message) async {
    FirebaseAPI.firestore
        .collection('chats/${getConversationsID(message.fromid)}/messages')
        .doc(message.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }
}
