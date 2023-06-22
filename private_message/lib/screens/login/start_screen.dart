import 'package:flutter/material.dart';
import 'package:private_message/screens/login/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset('images/startimage.png'),
                const Text(
                  'Take privacy with you. Be yourself in every message',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35.0),
                ),
                SizedBox(
                  height: mq.height * .05,
                ),
                const Text('Terms & Privacy Policy'),
                SizedBox(
                  height: mq.height * .02,
                ),
                Hero(
                  tag: 'move',
                  child: MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()));
                    },
                    color: Colors.blueGrey.shade500,
                    shape: const StadiumBorder(),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
