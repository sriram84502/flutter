import 'package:flutter/material.dart';

class Reusecode extends StatelessWidget {
  final Color color;
  final Widget cardChild;
  const Reusecode(this.color, this.cardChild, {super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(10.0)),
      child: cardChild,
    );
  }
}