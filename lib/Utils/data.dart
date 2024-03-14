import 'package:intl/intl.dart';

String formatCurrency(double? amount, {String currencyCode = "AED"}) {
  final formatter = NumberFormat.currency(
    locale: 'en_US', // You can change the locale based on your requirements
    symbol: " $currencyCode ",
    // decimalDigits: 0,
  );
  return formatter.format(amount ?? 0);
}

List<Map> icons = [
  {
    "id": 5885,
    "name": "alta",
    "color": "#080808",
  },
  {
    "id": 6686,
    "name": "arb",
    "color": "#356295",
  },
  {
    "id": 5339,
    "name": "aroam",
    "color": "#323232",
  },
  {
    "id": 5751,
    "name": "atr",
    "color": "#001446",
  },
  {
    "id": 3822,
    "name": "edacom",
    "color": "#2F3266",
  },
  {
    "id": 4,
    "name": "hoam",
    "color": "#1D2159",
  },
  {
    "id": 2845,
    "name": "irtikaz",
    "color": "#231F20",
  },
  {
    "id": 2,
    "name": "iskaan",
    "color": "#751B50",
  },
  {
    "id": 2190,
    "name": "itihad",
    "color": "#000000",
  },
  {
    "id": 2540,
    "name": "jbc",
    "color": "#1F2C5E",
  },
  {
    "id": 6720,
    "name": "kep",
    "color": "#000000",
  },
  {
    "id": 2332,
    "name": "mansions",
    "color": "#003B68",
  },
  {
    "id": 7171,
    "name": "oz",
    "color": "#001135",
  },
  {
    "id": 4639,
    "name": "palazzo",
    "color": "#8B6F4B",
  },
  {
    "id": 2821,
    "name": "pid",
    "color": "#003057",
  },
  {
    "id": 4681,
    "name": "privilege",
    "color": "#29102B",
  },
  {
    "id": 6873,
    "name": "saba",
    "color": "#007AC2",
  },
  {
    "id": 7,
    "name": "saga",
    "color": "#043E71",
  },
  {
    "id": 4621,
    "name": "sigma",
    "color": "#070305",
  },
  {
    "id": 6159,
    "name": "sobha",
    "color": "#000000",
  },
  {
    "id": 6711,
    "name": "st",
    "color": "#6B5C55",
  },
  {
    "id": 1099,
    "name": "strata",
    "color": "#1D1D1B",
  },
  {
    "id": 850,
    "name": "stratum",
    "color": "#000000",
  },
];
