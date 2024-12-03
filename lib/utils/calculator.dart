import 'dart:math';

double CalculateBMI(int height, int weight) {
  return 703*(weight / pow(height, 2));
}

// Future<double> calculateBMIAsync() async{

// }
