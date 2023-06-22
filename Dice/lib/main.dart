import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dice App"),
      ),
      body: Dice(),
    ),
  ));
}

class Dice extends StatefulWidget {
  const Dice({Key? key}) : super(key: key);

  @override
  State<Dice> createState() => _DiceState();
}

class _DiceState extends State<Dice> {
  int left = 1;
  int right = 1;
  int sum = 0;
  @override
  trigger() {
    setState(() {
      right = Random().nextInt(6) + 1;
      left = Random().nextInt(6) + 1;
      sum = left + right;
    });
  }

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    trigger();
                  },
                  child: Image.asset('images/dice$left.png'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    trigger();
                  },
                  child: Image.asset('images/dice$right.png'),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
              "$sum",
            style: TextStyle(
              fontSize: 50.0,
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
