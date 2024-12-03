import 'dart:math';

import 'package:dio/dio.dart';

double CalculateBMI(int height, int weight) {
  return 703 * (weight / pow(height, 2));
}

Future<double> calculateBMIAsync(Dio _dio) async {
  var _result = await _dio.get('https://www.jsonkeeper.com/b/AKFA');
  var _data = _result.data;
  var _bmi = CalculateBMI(_data["Sergio Ramos"][0], _data["Sergio Ramos"][1]);
  return _bmi;
}
