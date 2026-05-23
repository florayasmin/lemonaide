import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lemonaide/app.dart';

void main() {
  testWidgets('Lemonaide app loads home dashboard', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: LemonaideApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Your Lemonade Empire'), findsOneWidget);
    expect(find.text('Lemonaide'), findsWidgets);
  });
}
