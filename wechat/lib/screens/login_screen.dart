import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  googleSignIn() async {
    try {
      final userCredential = await _signInWithGoogle();
      if (userCredential != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      // Handle the error
      print('Google Sign-In Error: $e');
    }
  }
  
  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to WeChat'),
      ),
      body: Stack(
        children: [
          Positioned(
            height: mq.height*.30,
            width: mq.width*.5,
            left: mq.width*.25,
            child: Image.asset(
              'images/logo.png',
              scale: .5,
            ),
          ),
          Positioned(
            bottom: mq.height*.1,
            width: mq.width*.5,
            left: mq.width*.25,
            child: ElevatedButton.icon(
                onPressed: () {
                  googleSignIn();
                },
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                ),
                icon: Image.asset('images/google.png',height: 35,),
                label: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Sign in with '),
                      TextSpan(text: 'Google',style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
            ),
          ),
        ],
      ),
    );
  }
}
