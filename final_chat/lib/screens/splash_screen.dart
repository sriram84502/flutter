import 'package:final_chat/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLoginScreen();
  }

  void navigateToLoginScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      if(FirebaseAuth.instance.currentUser != null){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              height: mq.height * .4,
              width: mq.width * .8,
              left: mq.width * .09,
              child: Image.asset(
                'images/logo.png',
                scale: 0.4,
              ),
            ),
            Positioned(
              bottom: mq.height * .15,
              width: mq.width * .8,
              left: mq.width * .30,
              child: Text(
                'Made with ❤',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
