import 'package:intl/intl.dart';

String formatCurrency(double? amount, {String currencyCode = "AED"}) {
  final formatter = NumberFormat.currency(
    locale: 'en_US', // You can change the locale based on your requirements
    symbol: " $currencyCode ",
    // decimalDigits: 0,
  );
  return formatter.format(amount ?? 0);
}
