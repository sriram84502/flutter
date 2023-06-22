import 'package:http/http.dart';

String _api = '04b30858b422c5ecaf86fe267cab7445';

class GetInfo{
  getData(double lon,double lat) async {
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$_api'));
    return response.body;
  }

  getCity(String city) async {
    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$_api'));
    return response.body;
  }
}