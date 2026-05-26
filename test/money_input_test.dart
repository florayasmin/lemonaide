import 'package:flutter_test/flutter_test.dart';
import 'package:lemonaide/core/utils/money_input.dart';

void main() {
  test('parseDollarsToCents', () {
    expect(parseDollarsToCents('5'), 500);
    expect(parseDollarsToCents('\$12.50'), 1250);
    expect(parseDollarsToCents('0'), isNull);
    expect(parseDollarsToCents(''), isNull);
  });
}
