import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibmi/pages/bmi_page.dart';

void main() {
  testWidgets(
      "given user on BMI page when user click + button then weight increment by one",
      (tester) async {
    // arrange
    await tester.pumpWidget(
      CupertinoApp(
        home: BmiPage(),
      ),
    );
    var _weightIncremantButton = find.byKey(Key('weight_plus'));
    // Act
    await tester.tap(_weightIncremantButton);
    await tester.pump();
    // Assert
    var _text = find.text('161');
    expect(_text, findsOneWidget);
  });

  testWidgets(
      "given user on BMI page when user click - button then weight decreamant by one",
      (tester) async {
    // arrange
    await tester.pumpWidget(
      CupertinoApp(
        home: BmiPage(),
      ),
    );
    var _weightIncremantButton = find.byKey(Key('weight_minus'));
    // Act
    await tester.tap(_weightIncremantButton);
    await tester.pump();
    // Assert
    var _text = find.text('159');
    expect(_text, findsOneWidget);
  });
}
