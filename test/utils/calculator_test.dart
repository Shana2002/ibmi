import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';

import 'package:mocktail/mocktail.dart';

class DioMock extends Mock implements Dio {}

void main() {
  setUpAll(() {
    registerFallbackValue(RequestOptions(path: ''));
  });

  test('Given height and weight When calculateBMI function invoked Then correct BMI return', () {
    // Arrange
    const int height = 70, weight = 160;
    // Act
    double bmi = CalculateBMI(height, weight);
    // Assert
    expect(bmi, 22.955102040816328);
  });

  test('Given a URL When calculateBMIAsync is called Then correct BMI is returned', () async {
    // Arrange
    final _dioMock = DioMock();
    when(() => _dioMock.get(any())).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: 'https://www.jsonkeeper.com/b/AKFA'),
        data: {
          "Sergio Ramos": [72, 165],
        },
        statusCode: 200,
      ),
    );

    // Act
    var _result = await calculateBMIAsync(_dioMock);

    // Assert
    expect(_result, 22.375578703703706);
  });
}
