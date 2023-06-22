import 'package:chat_app_test/models/chat_users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseAPI {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<bool> checkUser() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    final user = ChatUser(
        image: auth.currentUser!.photoURL.toString(),
        about: 'Hey I am using ChatApp',
        name: auth.currentUser!.displayName.toString(),
        createdAt: time,
        lastActive: time,
        id: auth.currentUser!.uid,
        isOnline: false,
        pushToken: '',
        email: auth.currentUser!.email.toString());

    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .set(user.toJson()));
  }
}
