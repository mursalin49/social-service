import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:service/main.dart';
import 'package:service/pages/start.dart'; // Make sure your main.dart is imported correctly

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: StartPage(),
    ));

    // Verify that the StartPage has been built correctly
    expect(find.text('Easy, reliable way to take care of your home'),
        findsOneWidget);

    // If you want to test specific buttons or actions, continue from here
    // For example, checking the "Get Started" button
    await tester.tap(find.byType(MaterialButton));
    await tester.pump(); // Trigger a frame

    // Verify the action (e.g., navigating to another page)
    // Depending on your logic, you can add checks here.
  });
}
