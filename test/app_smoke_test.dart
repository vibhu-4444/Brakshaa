import 'package:brakshaa/core/brakshaa_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Brakshaa renders the dashboard shell', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BrakshaaApp()));
    await tester.pumpAndSettle();

    expect(find.text('Brakshaa'), findsWidgets);
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);
  });
}
