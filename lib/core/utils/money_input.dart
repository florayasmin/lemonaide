/// Parses kid-friendly money input like "5", "5.50", "$12.00".
int? parseDollarsToCents(String input) {
  final cleaned = input.trim().replaceAll(r'$', '').replaceAll(',', '');
  if (cleaned.isEmpty) {
    return null;
  }

  final value = double.tryParse(cleaned);
  if (value == null || value <= 0) {
    return null;
  }

  return (value * 100).round();
}
