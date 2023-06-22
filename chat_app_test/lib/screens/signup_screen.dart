import 'package:chat_app_test/apis/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late String email = '';
  late String password = '';
  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: mq.height * .10,
            width: mq.width * .5,
            left: mq.width * .25,
            child: Image.asset('images/login.png', scale: .5),
          ),
          Positioned(
            top: mq.height * .35,
            width: mq.width * .5,
            left: mq.width * .35,
            child: const Text(
              'Register',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: mq.height * .45,
            width: mq.width * .8,
            left: mq.width * .1,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              enabled: true,
              onChanged: (value) {
                setState(() {
                  print(email);
                  email = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter email',
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          Positioned(
            top: mq.height * .53,
            width: mq.width * .8,
            left: mq.width * .1,
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              enabled: true,
              onChanged: (value) {
                setState(() {
                  print(password);
                  password = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Enter password',
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(18.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
          ),
          Positioned(
            top: mq.height * .62,
            width: mq.width * .8,
            left: mq.width * .1,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  // showSpinner = true;
                });
                try{
                  final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  if(newuser != Null){
                    if(await FirebaseAPI.checkUser()){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                    }
                    else{
                      FirebaseAPI.createUser().then((value) => {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen())),
                      });
                    }
                  }
                  setState(() {
                    // showSpinner = false;
                  });
                }
                catch (e) {
                  print(e);
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Register'),
            ),
          ),
        ],
      ),
    );
  }
}
