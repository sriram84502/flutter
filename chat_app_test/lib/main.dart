import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  _initFirebase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplashScreen = true;
  void hideSplashScreen() {
    setState(() {
      showSplashScreen = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          iconTheme: IconThemeData(
            size: 30.0,
            color: Colors.black,
          )
        ),
      ),
      home: showSplashScreen
          ? StartScreen(hideSplashScreenCallback: hideSplashScreen)
          : LoginScreen(),
    );
  }
}

_initFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
