import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class NavIcon extends StatefulWidget {
  const NavIcon({Key? key, this.icon, this.text}) : super(key: key);
  final icon;
  final text;
  @override
  State<NavIcon> createState() => _NavIconState();
}

class _NavIconState extends State<NavIcon> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0,right: 8.0,bottom: 50.0),
      child: Container(
        width: mq.width*.18,
        height: mq.height * 0.08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,size: mq.height*.04,color: Colors.black45,),
            SizedBox(
              height: mq.height*.001,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
