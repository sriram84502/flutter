import 'package:chat_app_test/apis/firebase.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    animation = CurvedAnimation(parent: controller, curve: Curves.elasticOut);
    controller.forward();
    controller.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  _googleSignin(){
    _signInWithGoogle().then((value) async => {
      if(await FirebaseAPI.checkUser()){
        Navigator.pop(context),
        Navigator.pop(context),
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
      }
      else{
        FirebaseAPI.createUser().then((value) => {
          Navigator.pop(context),
          Navigator.pop(context),
          Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
        })
      },
      // print(value.user)
    });
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
        title: const Text('Welcome to ChatApp'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .10,
            width: mq.width * .5,
            left: mq.width * .25,
            child: Image.asset('images/login.png', scale: .5,height: animation.value*200),
          ),
          Positioned(
            top: mq.height * .67,
            width: mq.width * .40,
            left: mq.width * .05,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SigninScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 97, 162),
                elevation: 2,
                shape: const StadiumBorder(),
              ),
              child: const Text('Signin',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: mq.height * .67,
            width: mq.width * .40,
            left: mq.width * .55,
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 97, 162),
                elevation: 2,
                shape: const StadiumBorder(),
              ),
              child: const Text('Signup',
                style:TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Positioned(
            top: mq.height * .75,
            width: mq.width * .5,
            left: mq.width * .25,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 34, 158, 243),
                elevation: 2,
                shape: const StadiumBorder(),
              ),
              onPressed: () {
                _googleSignin();
              },
              icon: Image.asset(
                'images/google.png',
                height: 40.0,
              ),
              label: RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: 'Signin with '),
                    TextSpan(
                        text: 'Google',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
