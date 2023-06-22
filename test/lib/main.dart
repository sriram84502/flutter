import 'package:flutter/material.dart';

void main() {
  runApp(Mainapp());
}

class Mainapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        // appBar: AppBar(
        //     title: Text("JK APP"),
        //     backgroundColor: Colors.blueGrey[900],
        // ),
        // body: Image(
        //     image: NetworkImage("https://blogs.vmware.com/security/files/2020/05/haking_is_the_new_espionage-410x222.jpg"),
        // ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(
              //   height: 100.0,
              //   width: 100.0,
              //   color: Colors.white,
              //   child: Text("Hello world"),
              // ),
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('images/jk.jpg'),
              ),
              Text(
                  "JK Antaru ra babu",
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Pacifico-Regular',
                ),
              ),
              Text('Andhagadu',
                style: TextStyle(
                  color: Colors.teal.shade100,
                  fontFamily: 'SourceSansPro-Regular',
                  fontSize: 20.0,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
                width: 200.0,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
                child: ListTile(
                  leading: Icon(Icons.phone,
                    color: Colors.teal.shade900,
                  ),
                  title: Text(
                    '+91 63054-63057',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 40.0),
                child: ListTile(
                  leading: Icon(Icons.email,
                    color: Colors.teal.shade900,
                  ),
                  title: Text(
                    '20A81A0560@sves.org.in',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

