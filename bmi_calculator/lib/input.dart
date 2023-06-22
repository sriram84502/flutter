import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'layout_content.dart';
import 'icon_content.dart';
import 'constants.dart';
import 'results.dart';
import 'calculator.dart';

Color color = const Color(0xFF1D1E33);
Color inact = const Color(0xFF111328);
int height = 120;
int weight = 60;
int age = 20;
enum Gender{male,female,n,}
class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}
class _InputPageState extends State<InputPage> {
  late Gender selectGender = Gender.n;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI CALCULATOR"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(onTap: (){
                    setState(() {
                      selectGender = Gender.male;
                    });
                  },child: Reusecode(selectGender == Gender.male ? color : inact,const RepeatCol(FontAwesomeIcons.mars,'male'))),
                ),
                Expanded(
                  child: GestureDetector(onTap:(){
                    setState(() {
                      selectGender = Gender.female;
                    });
                  },child: Reusecode(selectGender == Gender.female ? color : inact,const RepeatCol(FontAwesomeIcons.venus,'female'))),
                )
              ],
            ),
          ),
          Expanded(
            child: Reusecode(color,Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('HEIGHT',
                style: teststyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(height.toString(),
                      style: const TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Text('cm',style: teststyle,),
                  ],
                ),
                Slider(
                    value: height.toDouble(),
                    min: 120.0,
                    max: 240.0,
                    activeColor: const Color(0xFFEB1555),
                    inactiveColor: const Color(0xEE8D8E98),
                    onChanged: (double newvalue) {
                      setState(() {
                        height = newvalue.round();
                      });
                    }
                ),
              ],
            )),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Reusecode(color,Column(
                    children: [
                      const Text('WEIGHT',
                        style: teststyle,
                      ),
                      Text(weight.toString(),
                        style: const TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.w900,
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Roundbutton(
                            FontAwesomeIcons.minus,
                            (){
                              setState(() {
                                weight--;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Roundbutton(FontAwesomeIcons.plus,
                                (){
                              setState(() {
                                weight++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )),
                ),
                Expanded(
                  child: Reusecode(color,Column(
                    children: [
                      const Text('AGE',
                        style: teststyle,
                      ),
                      Text(age.toString(),
                          style: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Roundbutton(
                            FontAwesomeIcons.minus,
                                (){
                              setState(() {
                                age--;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Roundbutton(FontAwesomeIcons.plus,
                                (){
                              setState(() {
                                age++;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  )),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Calculator calculate = Calculator(weight, height);
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => Results(calculate.calbmi(),calculate.getRes(),calculate.getInter()))
              );
            },
            child: Container(
              color: const Color(0xFFEB1555),
              margin: const EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 60.0,
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    'CALCULATE',
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Roundbutton extends StatelessWidget {
  const Roundbutton( this.icon, this.onPressed, {super.key});
  final IconData icon;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      constraints: const BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      elevation: 2.0,
      onPressed: onPressed,
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      child: Icon(icon),
    );
  }
}
