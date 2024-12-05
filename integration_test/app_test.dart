import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ibmi/main.dart' as app;

void main() {
  group('end-to-end app test', () {
    var _weightIncrementButton = find.byKey(Key("weight_plus"));
    var _weightDecreamentButton = find.byKey(Key("weight_minus"));

    var _ageIncrementButton = find.byKey(Key("age_plus"));
    var _ageDecreamentButton = find.byKey(Key("age_minus"));
    var _calculateBMIbutton = find.byType(CupertinoButton);

    testWidgets(
        'given app is ran when height , age data input and calcuate BMI button pressed then correct BMI retuend',
        (tester) async {
      // Arrange
      app.main();
      // Act
      await tester.pumpAndSettle();
      await tester.tap(_weightIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(_ageIncrementButton);
      await tester.pumpAndSettle();
      await tester.tap(_calculateBMIbutton);
      await tester.pumpAndSettle();
      final _resultText = find.text('Normal');
      // Assert
      expect(_resultText, findsOneWidget);
    });
  });
}
