import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:climte/services/weather.dart';
import 'package:climte/services/loading.dart';
import 'city.dart';
import 'package:climte/services/api.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationweather});
  final locationweather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  LoadingPage loading = LoadingPage();
  int temp = 0;
  int condition = 0;
  String city = '';
  String symbol = '';
  String mess = '';
  @override
  void initState(){
    super.initState();
    updateUI();
  }

  void updateUI(){
    city = jsonDecode(widget.locationweather)['name'];
    double temp1 = jsonDecode(widget.locationweather)['main']['temp']-273.15;
    temp = temp1.toInt();
    condition = jsonDecode(widget.locationweather)['weather'][0]['id'];
    WeatherModel weather = WeatherModel();
    symbol = weather.getWeatherIcon(condition);
    mess = weather.getMessage(temp);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoadingPage();
                      }));
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Getcity();
                      }));
                      if(typedName != Null){
                        GetInfo getinfo = GetInfo();
                        var data = getinfo.getCity(typedName);
                        city = jsonDecode(data)['name'];
                        double temp1 = jsonDecode(data)['main']['temp']-273.15;
                        temp = temp1.toInt();
                        condition = jsonDecode(data)['weather'][0]['id'];
                        WeatherModel weather = WeatherModel();
                        symbol = weather.getWeatherIcon(condition);
                        mess = weather.getMessage(temp);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children: [
                    Text('$temp°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text('$symbol',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Text(' $mess in $city!',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w900,
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
