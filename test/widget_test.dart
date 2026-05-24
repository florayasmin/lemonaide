import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemonaide/app.dart';

void main() {
  testWidgets('Lemonaide app loads home dashboard', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      const ProviderScope(
        child: LemonaideApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Total earned'), findsOneWidget);
    expect(find.text('Current savings'), findsOneWidget);
    expect(find.text('TODO'), findsOneWidget);
    expect(find.text('Add earnings'), findsOneWidget);
    expect(find.text('Log chore'), findsOneWidget);
    expect(find.text('Lemonaide'), findsWidgets);
  });
}
