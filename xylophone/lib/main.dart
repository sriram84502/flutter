import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(const Player());
}

class Player extends StatelessWidget {
   Expanded colora(Color color,int num){
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(color)
        ),
        onPressed: (){
          final player = AudioPlayer();
          player.play(AssetSource('note$num.wav'));
        }, child: Container(),
      ),
    );
  }
  const Player({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              colora(Colors.blue, 1),
              colora(Colors.red, 2),
              colora(Colors.green, 3),
              colora(Colors.orange, 4),
              colora(Colors.yellow, 5),
              colora(Colors.teal, 6),
              colora(Colors.purple, 7)
            ],
          ),
        ),
      ),
    );
  }
}
