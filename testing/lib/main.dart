import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("JK APP"),
            backgroundColor: Colors.blueGrey[900],
          ),
          body: Center(
            child: Image(
                image: NetworkImage(
                    'https://blogs.vmware.com/security/files/2020/05/haking_is_the_new_espionage-410x222.jpg')),
          ),
    )),
  );
}
