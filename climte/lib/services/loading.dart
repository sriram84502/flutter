import 'package:climte/screens/location.dart';
import 'package:flutter/material.dart';
import 'location.dart';
import 'api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingPage extends StatefulWidget {
  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  @override
  GetInfo getdata = GetInfo();
  void initState(){
    getLocation();
  }

  Future<void> getLocation()  async {
    GetLocation location = GetLocation();
    await location.getLocationdetails();
    double longitude = location.longitude;
    double latitude = location.latitude;
    var data = await getdata.getData(longitude, latitude);

    Navigator.push(context as BuildContext, MaterialPageRoute(builder: (context){
      return LocationScreen(locationweather: data,);
    }));
  }
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
