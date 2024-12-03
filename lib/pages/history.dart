import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ibmi/widget/info_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  double? _deviceHeight, _deviceWidth;
  Future<SharedPreferences>? _presFuture;

  @override
  void initState() {
    super.initState();
    _presFuture = SharedPreferences.getInstance();
  }

  void refreshData() {
    setState(() {
      _presFuture = SharedPreferences.getInstance();
    });
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    SharedPreferences.getInstance();
    return CupertinoPageScaffold(
        child: Center(
      child: _dataCard(),
    ));
  }

  Widget _dataCard() {
    return FutureBuilder(
        future: _presFuture,
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            final _prefs = _snapshot.data as SharedPreferences;
            final _date = _prefs.getString('bmi_date');
            final _data = _prefs.getStringList('bmi_data');

            return Center(
              child: InfoCard(
                  height: _deviceHeight! * 0.25,
                  width: _deviceWidth! * 0.75,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _statusText(_data![1]),
                      _dateText(_date!),
                      _bmiText(_data[0])
                    ],
                  )),
            );
          } else {
            return const Center(
              child: CupertinoActivityIndicator(
                color: Colors.blue,
              ),
            );
          }
        });
  }

  Widget _statusText(String _status) {
    return Text(
      _status,
      style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
    );
  }

  Widget _dateText(String _date) {
    DateTime _parseDate = DateTime.parse(_date);
    return Text(
      '${_parseDate.day} / ${_parseDate.month} / ${_parseDate.year}',
      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
    );
  }

  Widget _bmiText(String _bmi) {
    return Text(
      double.parse(_bmi).toStringAsFixed(2),
      style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600),
    );
  }
}
