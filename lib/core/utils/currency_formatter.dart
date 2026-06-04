import 'package:intl/intl.dart';

/// Formats monetary values for display.
class CurrencyFormatter {
  CurrencyFormatter._();

  static String format(double? amount, {String currency = 'USD'}) {
    if (amount == null) return '—';
    final format = NumberFormat.simpleCurrency(name: currency);
    return format.format(amount);
  }

  /// Signed format for gain/loss, e.g. "+\$140.00" / "-\$20.00".
  static String formatSigned(double amount, {String currency = 'USD'}) {
    final sign = amount >= 0 ? '+' : '-';
    return '$sign${format(amount.abs(), currency: currency)}';
  }
}
