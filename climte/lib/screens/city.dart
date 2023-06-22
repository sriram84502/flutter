import 'package:flutter/material.dart';

class Getcity extends StatefulWidget {
  @override
  State<Getcity> createState() => _State();
}

class _State extends State<Getcity> {
  @override

  String cityName = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img_1.png'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                    hintText: 'Enter city name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context,cityName);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
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
