import 'package:flutter/material.dart';
import 'constants.dart';
class RepeatCol extends StatelessWidget {
  const RepeatCol(this.icon,this.gender, {super.key});
  final IconData icon;
  final String gender;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          size: 80.0,
          icon,
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          gender,
          style:teststyle,
        )
      ],
    );
  }
}