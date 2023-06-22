import 'package:chat_app_test/apis/firebase.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late String email = '';
  late String password = '';
  @override

  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
            left: mq.width * .40,
            child: const Text(
              'Login',
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
                  print(email);
                  print(password);
                  final newuser = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
