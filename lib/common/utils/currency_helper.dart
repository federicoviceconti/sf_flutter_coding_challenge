import 'package:intl/intl.dart';

class CurrencyHelper {
  static String formatUsd(double value) {
    return NumberFormat.simpleCurrency(
      locale: 'en_US',
      decimalDigits: 2,
    ).format(value);
  }

  static getPercentage({
    required double initial,
    required double current,
  }) {
    return (current / initial) - 1 * 100;
  }
}
