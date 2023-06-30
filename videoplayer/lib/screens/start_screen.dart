import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoplayer/APIs/firebase_apis.dart';
import 'package:videoplayer/screens/home_screen.dart';
import 'package:videoplayer/screens/login_screen.dart';
import 'package:videoplayer/screens/register_persno_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  bool isLoggedIn = false;
  bool isLoading = true;

  void checkLoggedInUser() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        print(APIs.auth.currentUser!.phoneNumber);
        if (FirebaseAuth.instance.currentUser != null) {
          isLoggedIn = true;
        } else {
          isLoggedIn = false;
        }
        isLoading = false;
      });

      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Register(user: APIs.me)),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkLoggedInUser();
    APIs.self();
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                transitionOnUserGestures: true,
                child: Image.asset(
                  'assets/icon/img.png',
                  height: mq.height * .35,
                ),
              ),
              Text(
                'VidShare',
                style: GoogleFonts.montserrat(
                  fontSize: 40,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 20,
                  bottom: 20,
                ),
                child: Text(
                  'Capture, Share, and Explore the World with Videos',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              if (isLoading) CircularProgressIndicator(), // Show a loading indicator
            ],
          ),
        ),
      ),
    );
  }
}

