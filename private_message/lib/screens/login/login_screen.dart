import 'package:flutter/material.dart';
import 'package:private_message/screens/home_screen.dart';
import 'package:private_message/screens/login/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


String phoneid = '';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController countrycode = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool redirect = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycode.text = '+91';
    if(FirebaseAuth.instance.currentUser!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            child:  SingleChildScrollView(
                child: Column(
              children: [
                Image.asset('images/login.png',height: mq.height*.2,),
                const Text(
                  'Phone Number',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.grey),
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
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                        child: Text('|',style: TextStyle(fontSize: 20.0),),
                      ),
                       Expanded(child: TextField(
                        controller: phone,
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          phone.text = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          border: InputBorder.none,
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'move',
        onPressed: () async {
          setState(() {
            redirect = true;
          });

          try {
            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: countrycode.text + phone.text,
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {
                setState(() {
                  redirect = false;
                });
                // Handle verification failure
              },
              codeSent: (String verificationId, int? resendToken) {
                setState(() {
                  redirect = false;
                });
                // Navigate to OTP screen with verification ID
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OtpScreen(verificationId: verificationId),
                  ),
                );
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );
          } catch (e) {
            setState(() {
              redirect = false;
            });
            // Handle exception
            print('Error: $e');
          }
        },
        child: redirect?const CircularProgressIndicator():const Icon(Icons.arrow_forward_outlined),
      ),
    );
  }
}
