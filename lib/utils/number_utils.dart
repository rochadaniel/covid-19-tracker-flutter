import 'package:intl/intl.dart';

class NumberUtils {
  static String formatDecimalPlaces(double value) {
    if (value != null) {
      final formatter = new NumberFormat("#,###");
      return formatter.format(value);
    } else {
      return "-";
    }
  }
}