import 'package:flutter/material.dart';
import 'package:private_message/screens/home_screen.dart';
import 'package:private_message/screens/login/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:private_message/screens/login/setup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),
        textTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: null),
          bodyText2: TextStyle(fontFamily: null),
          // Add more text styles as needed
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the authentication state
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null) {
            // User is already logged in, navigate to HomeScreen
            return HomeScreen();
          } else {
            // User is not logged in, navigate to LoginScreen
            return StartScreen();
          }
        }
      },
    );
  }
}
