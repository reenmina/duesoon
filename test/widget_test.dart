import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:duesoon/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app
    await tester.pumpWidget(DueSoonApp());

    // Wait for frame to settle
    await tester.pumpAndSettle();

    // Basic check: app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
