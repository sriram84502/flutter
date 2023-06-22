import 'package:flutter/material.dart';
import 'chat.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  static const String id = 'register';

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _auth = FirebaseAuth.instance;
  String email = '';
  String password = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'images/img.png',
                        height: 200.0,
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    enabled: true,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 30.0,
                  ),
                  TextField(
                    onChanged: (value) {
                      // print(value);
                      password = value;
                    },
                    obscureText: true,
                    enabled: true,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 30.0,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try{
                        final newuser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                        if(newuser != Null){
                          Navigator.pushNamed(context, Chat.id);
                        }
                        setState(() {
                          showSpinner = false;
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
                    child: Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Login.id);
                    },
                    child: Text('Already have an account'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
