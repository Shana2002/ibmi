import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/utils/calculator.dart';
import 'package:ibmi/widget/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  double? _deviceHeight, _deviceWidth;
  int _age = 25, _weight = 160, _height = 70, _gender = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
        child: Center(
      child: Container(
          height: _deviceHeight! * 0.8,
          width: _deviceWidth,
          margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.12),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [_ageSelectorContainer(), _weightSelector()],
              ),
              _heightSelector(),
              _genderSelector(),
              _calculateBMIButton()
            ],
          )),
    ));
  }

  Widget _ageSelectorContainer() {
    return InfoCard(
        height: _deviceHeight! * 0.2,
        width: _deviceWidth! * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Age yr',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              _age.toString(),
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          if (_age > 1) {
                            _age--;
                          }
                        });
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                ),
                SizedBox(
                  width: 50,
                  child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          _age++;
                        });
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _weightSelector() {
    return InfoCard(
        height: _deviceHeight! * 0.2,
        width: _deviceWidth! * 0.45,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Weight Kgs',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              _weight.toString(),
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.w700),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  key: const Key("weight_minus"),
                  width: 50,
                  child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          if (_weight > 1) {
                            _weight--;
                          }
                        });
                      },
                      child: const Text(
                        '-',
                        style: TextStyle(fontSize: 25, color: Colors.red),
                      )),
                ),
                SizedBox(
                  key: const Key("weight_plus"),
                  width: 50,
                  child: CupertinoDialogAction(
                      onPressed: () {
                        setState(() {
                          _weight++;
                        });
                      },
                      child: const Text(
                        '+',
                        style: TextStyle(fontSize: 25, color: Colors.blue),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget _heightSelector() {
    return InfoCard(
        height: _deviceHeight! * 0.20,
        width: _deviceWidth! * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Height in',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Text(
              _height.toString(),
              style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              width: _deviceWidth! * 0.8,
              child: CupertinoSlider(
                  min: 0,
                  max: 96,
                  divisions: 96,
                  value: _height.toDouble(),
                  onChanged: (_value) {
                    setState(() {
                      _height = _value.toInt();
                    });
                  }),
            )
          ],
        ));
  }

  Widget _genderSelector() {
    return InfoCard(
        height: _deviceHeight! * 0.11,
        width: _deviceWidth! * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Gender',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            CupertinoSlidingSegmentedControl(
              children: const {
                0: Text("Male"),
                1: Text("Female"),
              },
              onValueChanged: (value) {
                setState(() {
                  _gender = value as int;
                });
              },
              groupValue: _gender,
            )
          ],
        ));
  }

  Widget _calculateBMIButton() {
    return Container(
      height: _deviceHeight! * 0.07,
      child: CupertinoButton.filled(
          child: const Text("Calculate BMI"),
          onPressed: () {
            if (_height > 0 && _weight > 0 && _age > 0) {
              double _bmi = CalculateBMI(_height, _weight);
              _showResultDialog(_bmi);
            }
          }),
    );
  }

  void _showResultDialog(double _bmi) {
    String? _status;
    if (_bmi < 18.5) {
      _status = "Underweight";
    } else if (_bmi >= 18.5 && _bmi < 25) {
      _status = "Normal";
    } else if (_bmi >= 25 && _bmi < 30) {
      _status = "OverWieght";
    } else if (_bmi >= 30) {
      _status = "Obese";
    }

    showCupertinoDialog(
        context: context,
        builder: (BuildContext _context) {
          return CupertinoAlertDialog(
            title: Text(_status!.toString()),
            content: Text(_bmi.toStringAsFixed(2)),
            actions: [
              CupertinoDialogAction(
                child: const Text("Ok"),
                onPressed: () {
                  _saveResult(_bmi.toString(), _status!);
                  Navigator.pop(_context);
                },
              )
            ],
          );
        });
  }

  void _saveResult(String _bmi, String _status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("bmi_date", DateTime.now().toString());
    await prefs.setStringList("bmi_data", <String>[_bmi, _status]);
    print("Result saved");
  }
}
