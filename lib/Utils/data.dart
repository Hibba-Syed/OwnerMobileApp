import 'package:intl/intl.dart';

String formatCurrency(double amount, {String currencyCode = "AED"}) {
  final formatter = NumberFormat.currency(
    locale: 'en_US', // You can change the locale based on your requirements
    symbol: " $currencyCode ",
  );
  return formatter.format(amount);
}

List<String> enquiryTypeList = [
  "Select",
  "Complaint",
  "Inquiry",
  "Suggestion",
];
