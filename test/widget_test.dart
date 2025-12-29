// Widget tests for Data Entry App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:basic_data_entry_app_flutter/main.dart';

void main() {
  testWidgets('Data Entry App renders correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const DataEntryApp());

    // Verify that the app title is displayed
    expect(find.text('Data Entry App'), findsOneWidget);

    // Verify that the submit button is displayed
    expect(find.text('Submit'), findsOneWidget);

    // Verify that the submitted text section is displayed
    expect(find.text('Submitted Text'), findsOneWidget);
  });

  testWidgets('Can enter text and submit', (WidgetTester tester) async {
    await tester.pumpWidget(const DataEntryApp());

    // Find the text field and enter text
    final textField = find.byType(TextField);
    expect(textField, findsOneWidget);

    await tester.enterText(textField, 'Test input');
    await tester.pump();

    // Tap the submit button
    final submitButton = find.text('Submit');
    await tester.tap(submitButton);
    await tester.pumpAndSettle();

    // Verify the submitted text is displayed
    expect(find.text('Test input'), findsOneWidget);
  });
}
