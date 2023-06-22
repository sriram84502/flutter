import 'package:flutter/material.dart';
import 'main.dart';
class Results extends StatelessWidget {
  const Results(this.bmiinter, this.bmires, this.bmitest, {super.key});
  final String bmires;
  final String bmitest;
  final String bmiinter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
    title: const Text('BMI CALCULATOR'),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Expanded(
          flex: 1,
          child: Text('Your Results',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
                color: const Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(15.0)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(bmires,
                  style: const TextStyle(
                    color: Color(0xFF24D876),
                    fontSize: 30.0,
                  ),
                ),
                Text(bmiinter,
                  style: const TextStyle(
                    fontSize: 100.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(bmitest,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                ),

              ],
            ),
          )
          ),
        GestureDetector(
          onTap: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const MyApp())
            );
          },
          child: Expanded(
            child: Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 60.0,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'RE-CALCULATE',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
