import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videoplayer/screens/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static String verify = '';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countrycode = TextEditingController();
  var phone = '';
  bool redirect = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycode.text = '+91';
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: mq.height * .2,
              ),
              Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/icon/img.png',
                    height: mq.height * .2,
                  )),
              Text(
                'Phone Number',
                style: GoogleFonts.montserrat(
                    fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'We need to register your phone before getting started!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countrycode,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                        ),
                        maxLength: 4,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      child: Text(
                        '|',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      width: mq.width*.4,
                        child: TextField(
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        phone = value;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Phone number',
                        border: InputBorder.none,
                        counterText: '',
                      ),
                          maxLength: 10,
                    ))
                  ],
                ),
              ),
              SizedBox(height: mq.height * .05),
              MaterialButton(
                onPressed: () async {
                  print('${countrycode.text+phone}');
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countrycode.text+phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      LoginScreen.verify = verificationId;
                      Navigator.push(context, MaterialPageRoute(builder: (_) => OtpScreen(phone: phone,countrycode: countrycode.text,)));
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                color: Colors.deepOrange,
                shape: const StadiumBorder(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 120),
                  child: Text(
                    'Next',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
