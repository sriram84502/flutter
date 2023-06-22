import 'package:flutter/material.dart';
import 'data.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Price extends StatefulWidget {

  @override
  State<Price> createState() => _PriceState();
}

class _PriceState extends State<Price> {
  @override

  String setcur = 'USD';
  int amount = 0;

  void initState(){
    super.initState();
    getCur(setcur);
  }

  void getCur(String setcur) async {
    String _api = '45082341-3C95-4B38-97EB-F70A0E011194';
    var URL = Uri.parse('https://rest.coinapi.io/v1/exchangerate/BTC/$setcur?apikey=$_api');
    var response = await http.get(URL);
    var amount1 = jsonDecode(response.body)['rate'];
    amount = int.parse(amount1.toString());
    print(amount);
    print(response.body);
    print(jsonDecode(response.body));
    setState(() {
      amount = int.parse(amount1.toString());
    });
  }
  DropdownButton<String> androiddd(){
    List<DropdownMenuItem<String>> currencies = [];
    for(int i=0;i<currenciesList.length;i++){
      String cur = currenciesList[i];
      var data = DropdownMenuItem(
        child: Text(cur), value: cur,
      );
      currencies.add(data);
    };
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      value: setcur,
      items: currencies,
      onChanged: (value) {
        setState(() {
          setcur = value!;
          getCur(setcur);
          Price();
        });
      },
    );
  }

  CupertinoPicker iosdd(){
    List<Text> data = [];
    for(String cur in currenciesList){
      data.add(Text(cur,style:TextStyle(color:Colors.white)));
    }
    return CupertinoPicker(itemExtent: 32.0, onSelectedItemChanged: (index){
      getCur(currenciesList[index]);
    },
        backgroundColor: Colors.lightBlue,

        children: data);
  }

  Widget build(BuildContext context) {
    getCur(setcur);
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  '1 BTC = $amount $setcur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS?iosdd():androiddd(),
          ),
        ],
      ),
    );
  }
}
