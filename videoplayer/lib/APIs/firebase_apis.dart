import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:videoplayer/models.dart';

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static late Userdata me;

  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> createUser() async {
    final user = Userdata(
        name: '',
        phone: auth.currentUser!.phoneNumber.toString(),
        username: '',
        id: auth.currentUser!.uid,
        photo: 'https://img.icons8.com/?size=512&id=23265&format=png');
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }

  static Future<void> self() async {
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        me = Userdata.fromJson(value.data()!);
      } else {
        await createUser().then((value) => self());
      }
    });
  }
}
