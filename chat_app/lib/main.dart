import 'package:chat_app/screens/register.dart';
import 'package:flutter/material.dart';
import 'screens/welcome.dart';
import 'screens/chat.dart';
import 'screens/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        )
      ),
      home: Welcome(),

      initialRoute: Welcome.id,

      routes: {
        Welcome.id : (context) => Welcome(),
        Login.id : (context) => Login(),
        Register.id : (context) => Register(),
        Chat.id : (context) => Chat(),
      },
    );
  }
}
