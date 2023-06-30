import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:videoplayer/APIs/firebase_apis.dart';
import 'package:videoplayer/screens/home_screen.dart';
import 'package:videoplayer/screens/login_screen.dart';
import 'package:videoplayer/screens/register_persno_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key, this.verificationid, this.phone, this.countrycode}) : super(key: key);
  final verificationid;
  final phone;
  final countrycode;
  Future<void> resendOtp(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieval of OTP completed (only for Android)
        // You can use credential to sign in
      },
      verificationFailed: (FirebaseAuthException exception) {
        // Handle verification failure
      },
      codeSent: (String verificationId, int? resendToken) {
        // OTP code resent successfully
        // You can update the UI to inform the user
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout (only for Android)
        // Save verificationId for later use
      },
      timeout: Duration(seconds: 60), // Adjust timeout duration as needed
    );
  }



  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var code = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.self();
  }
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(height: mq.height*.2,),
                Image.asset('assets/icon/img.png',height: mq.height*.2,),
                Text('OTP Verification',style: GoogleFonts.montserrat(fontSize: 30, fontWeight: FontWeight.bold),),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'An OTP has been sent to your specified mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: mq.height*.04),
                Pinput(
                  onChanged: (value) {
                    setState(() {
                      code = value;
                    });
                  },
                  length: 6,
                ),
                SizedBox(height: mq.height*.025),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: TextButton(
                      onPressed: () {
                        widget.resendOtp(widget.countrycode+widget.phone);
                      },
                      child: Text('Did not get otp resend?')),
                ),
                SizedBox(
                  height: mq.height*.03,
                ),
                MaterialButton(
                    onPressed: () async {
                      try{
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginScreen.verify, smsCode: code);
                        await FirebaseAuth.instance.signInWithCredential(credential);
                        if(await APIs.userExists()){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                        }
                        else{
                          APIs.createUser();
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Register(user: APIs.me,)));
                        }
                      }
                      catch (e) {
                        print(e);
                      }
                    },
                  shape: const StadiumBorder(),
                  color: Colors.deepOrange,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 100),
                    child: Text('Get Started',style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white),),
                  ),
                ),
              ],
            ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            Navigator.pop(context);
          },
        icon: const Icon(Icons.keyboard_backspace_rounded),
          label: const Text('Back'),
      ),
    );
  }
}
