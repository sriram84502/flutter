import 'package:flutter/material.dart';
import 'storybrain.dart';

StoryBrain storybrain = StoryBrain();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 50.0, horizontal: 15.0),
            child: SafeArea(child: Destini()),
          ),
        ),
      ),
    );
  }
}

class Destini extends StatefulWidget {
  const Destini({Key? key}) : super(key: key);

  @override
  State<Destini> createState() => _DestiniState();
}

class _DestiniState extends State<Destini> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              storybrain.getstory(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              setState(() {
                storybrain.nextstory(1);
              });
            },
            child: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  storybrain.choice1(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () {
              setState(() {
                storybrain.nextstory(2);
              });
            },
            child: Visibility(
              visible: storybrain.visibles(),
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    storybrain.choice2(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
