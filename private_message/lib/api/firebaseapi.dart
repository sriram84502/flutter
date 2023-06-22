import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:private_message/models/chatusers.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:private_message/models/messages.dart';

class FirebaseAPIs {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;
  static GetChatUsers? me;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Future<bool> checkUserExistsOrNot() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Future<void> updateUserinfoname() async {
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'name': me!.name, 'last': me!.last});
  }

  static Future<void> getCurrentUser() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      final userSnapshot =
          await firestore.collection('users').doc(currentUser.uid).get();
      if (userSnapshot.exists) {
        me = GetChatUsers.fromJson(userSnapshot.data()!);
      } else {
        await createNewUser();
        // After creating a new user, retrieve the user data again
        await getCurrentUser();
      }
    } else {
      // User is not authenticated, handle the error or redirect to login screen
      // You can throw an exception, display an error message, or navigate to the login screen
      throw Exception('User not authenticated');
    }
  }

  static Future<void> createNewUser() async {
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    final user = GetChatUsers(
        image:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Anonymous_emblem.svg/240px-Anonymous_emblem.svg.png',
        lastSeen: 'last seen recently',
        name: auth.currentUser!.displayName.toString(),
        about: 'Hey I am using private chat here',
        createdAt: date,
        phoneNumber: auth.currentUser!.phoneNumber.toString(),
        id: auth.currentUser!.uid,
        last: '',
        isOnline: true,
        pushToken: '');
    return await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .set(user.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  static Future<void> updateProfilePic(File file) async {
    final ext = file.path.split('.').last;
    final ref =
        storage.ref().child('profile_pictures/${auth.currentUser!.uid}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    me!.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update({'image': me!.image});
  }

  static String getConversationsID(String ID) =>
      auth.currentUser!.uid.hashCode <= ID.hashCode
          ? '${auth.currentUser!.uid}_$ID'
          : '${ID}_${auth.currentUser!.uid}';

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      GetChatUsers customuser) {
    return firestore
        .collection('chats/${getConversationsID(customuser.id)}/messages')
        .snapshots();
  }

  static Future<void> sendMessage(GetChatUsers customuser, String msg, Type type) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    Messages data = Messages(
      toid: customuser.id,
      msg: msg,
      read: '',
      type: type,
      sent: time,
      fromid: auth.currentUser!.uid,
    );
    final ref = firestore
        .collection('chats/${getConversationsID(customuser.id)}/messages');
    await ref.doc(time).set(data.toJson());
  }

  static Future<void> updateReadTime(Messages message) async {
    firestore
        .collection('chats/${getConversationsID(message.fromid)}/messages')
        .doc(message.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      GetChatUsers customuser) {
    return firestore
        .collection('chats/${getConversationsID(customuser.id)}/messages').limit(1).orderBy('sent',descending: true)
        .snapshots();
  }

  static Future<void> sendPhoto(GetChatUsers chatuser,File file) async {
    final ext = file.path.split('.').last;
    final ref =
    storage.ref().child('chat_images/${getConversationsID(chatuser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatuser, imageUrl, Type.image);
  }
}
