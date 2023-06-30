import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class NavIcons extends StatefulWidget {
  const NavIcons({Key? key, this.icon, this.text, this.buttoncolor}) : super(key: key);
  final icon;
  final text;
  final buttoncolor;
  @override
  State<NavIcons> createState() => _NavIconsState();
}

class _NavIconsState extends State<NavIcons> {
  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: MaterialButton(
        onPressed: () {
          // Add your onPressed logic here
        },
        elevation: widget.buttoncolor == Colors.blue?4:1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),

        ),

        color: widget.buttoncolor,
        padding: EdgeInsets.all(mq.width*.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon,size: mq.height*.04,color: widget.buttoncolor == Colors.blue?Colors.white70:Colors.black45,),
            SizedBox(
              height: mq.height*.02,
            ),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                color: widget.buttoncolor == Colors.blue?Colors.white70:Colors.black45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
