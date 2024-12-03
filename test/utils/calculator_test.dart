import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/utils/calculator.dart';

void main() {
  test(
      'Give hight and weight Whne calculateBMI function invoked Then correct BMI return',
      () {
    // Arrange
    const int height = 70, weight = 160;
    // Act
    double bmi = CalculateBMI(height, weight);
    // Assert
    expect(bmi, 22.955102040816328);
  });
}
