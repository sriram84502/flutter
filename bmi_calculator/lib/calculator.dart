import 'dart:math';

class Calculator{
  Calculator(this.weight,this.height);
  final int height;
  final int weight;

  double _bmi=0;
  String calbmi(){
    _bmi = weight/pow(height/100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getRes(){
    if(_bmi>25){
      return 'OVERWEIGHT';
    }else if(_bmi > 18.5){
      return 'NORMAL';
    }else{
      return 'UNDERWEIGHT';
    }
  }

  String getInter(){
    if(_bmi>25){
      return 'You have higher than normal weight. Try to exercise more.';
    }else if(_bmi > 18.5){
      return 'You have normal body weight. GoodJob!!!';
    }else{
      return 'You have a lower than normal body weight. You need to eat more.';
    }
  }
}