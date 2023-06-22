import 'package:flutter/material.dart';
import 'package:multitask/models/tools.dart';

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
        },
        child: ListTile(
          title: Text('Currency Convertor'),
          leading: CircleAvatar(backgroundImage: AssetImage('images/currency_convertor.png')),
        ),
      ),
    );
  }
}
