// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:myapp/register_screen.dart'; // Import the RegisterScreen widget

void main() {
  group('RegisterScreen', () {
    testWidgets('Register screen test', (tester) async {
      // Wrap your RegisterScreen widget with a MaterialApp widget
      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterScreen(),
        ),
      );

      // Make sure your test is correctly finding the widget it's expecting
      expect(find.byType(RegisterScreen), findsOneWidget);
    });
  });
}