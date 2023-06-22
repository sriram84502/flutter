import 'package:geolocator/geolocator.dart';

class GetLocation{
  late double longitude;
  late double latitude;

  Future<void> getLocationdetails() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    longitude = position.longitude;
    latitude = position.latitude;
  }
}