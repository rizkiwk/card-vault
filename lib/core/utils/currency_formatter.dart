import 'package:intl/intl.dart';

/// Formats monetary values for display.
class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(
    double? amount, {
    String currency = 'USD',
    int? decimalDigits,
  }) {
    if (amount == null) return '—';
    final format = NumberFormat.simpleCurrency(
      name: currency,
      decimalDigits: decimalDigits,
    );
    return format.format(amount);
  }

  /// Compact, no-decimals form used in dense lists/tiles (e.g. "$320").
  static String formatCompact(double? amount, {String currency = 'USD'}) =>
      format(amount, currency: currency, decimalDigits: 0);

  /// Signed format for gain/loss, e.g. "+\$140.00" / "-\$20.00".
  static String formatSigned(double amount, {String currency = 'USD'}) {
    final sign = amount >= 0 ? '+' : '-';
    return '$sign${format(amount.abs(), currency: currency)}';
  }
}
