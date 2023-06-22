import 'package:flutter/material.dart';
import 'package:multi_task/models/tools.dart';
import 'package:multi_task/screens/home_screen.dart';

class ListTools extends StatefulWidget {
  final Tools tools;
  const ListTools({Key? key, required this.tools}) : super(key: key);

  @override
  State<ListTools> createState() => _ListToolsState();
}

class _ListToolsState extends State<ListTools> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => widget.tools.location));
        },
        child: ListTile(
          title: Text(widget.tools.name),
          leading: CircleAvatar(backgroundImage: AssetImage(widget.tools.image)),
        ),
      ),
    );
  }
}
