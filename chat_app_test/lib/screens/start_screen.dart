import 'package:flutter/material.dart';
import 'login_screen.dart';
class StartScreen extends StatefulWidget {
  final VoidCallback hideSplashScreenCallback;
  const StartScreen({Key? key, required this.hideSplashScreenCallback}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      widget.hideSplashScreenCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: mq.height * .10,
              width: mq.width * .5,
              left: mq.width * .25,
              child: Image.asset('images/login.png', scale: .5),
            ),
            Positioned(
              top: mq.height * .75,
              width: mq.width * .5,
              left: mq.width * .35,
              child: const Text(
                'Made with ❤',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
