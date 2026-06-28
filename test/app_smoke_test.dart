import 'package:brakshaa/core/brakshaa_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Brakshaa starts at login and opens legal screens', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: BrakshaaApp()));
    await tester.pumpAndSettle();

    expect(find.text('Brakshaa'), findsWidgets);
    expect(find.text('Cultivating the Future'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.text('Terms of Service'), findsOneWidget);

    await tester.tap(find.text('Privacy Policy'));
    await tester.pumpAndSettle();
    expect(find.text('Your Privacy Matters'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Terms of Service'));
    await tester.pumpAndSettle();
    expect(find.text('Terms You Agree To'), findsOneWidget);
  });
}
