import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:private_message/api/firebaseapi.dart';
import 'package:private_message/screens/home_screen.dart';
import 'package:private_message/screens/login/login_screen.dart';
import 'package:private_message/screens/login/setup_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;

  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool _error = false;
  bool _isSubmitting = false;

  Future<void> _signInWithCredential() async {
    setState(() {
      _isSubmitting = true;
    });

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      // Verification successful, navigate to home screen
      if(await FirebaseAPIs.checkUserExistsOrNot()){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
      else{
        FirebaseAPIs.createNewUser().then((value) {
          return Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => HomeScreen()),
          );
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        _isSubmitting = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('images/login.png', height: mq.height * .2),
                  const Text(
                    'Phone Verification',
                    style:
                    TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'We need to register your phone before getting started!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 6,
                      onChanged: (value) {
                        setState(() {
                          _error = false;
                        });
                      },
                      controller: _otpController,
                    ),
                  ),
                  if (_error)
                    SizedBox(
                      height: 10,
                      child: Text(
                        'Check your OTP and try again',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  SizedBox(
                    width: mq.width * .7,
                    child: Hero(
                      tag: 'move',
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _isSubmitting ? null : _signInWithCredential,
                        child: _isSubmitting
                            ? const CircularProgressIndicator()
                            : const Text('Submit'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: _isSubmitting
                            ? null
                            : () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Edit Phone Number',
                          style: TextStyle(color: Colors.white38),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
