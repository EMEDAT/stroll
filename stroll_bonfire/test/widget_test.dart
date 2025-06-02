// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stroll_bonfire/main.dart';

void main() {
  testWidgets('Stroll Bonfire app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StrollBonfireApp());

    // Verify that our app shows the correct header.
    expect(find.text('Stroll Bonfire'), findsOneWidget);
    expect(find.text('Angelko, 28'), findsOneWidget);
    expect(find.text('What is your favorite time of the day?'), findsOneWidget);

    // Verify that options are present
    expect(find.text('The peace in the\nearly mornings'), findsOneWidget);
    expect(find.text('The magical\ngolden hours'), findsOneWidget);
  });
}