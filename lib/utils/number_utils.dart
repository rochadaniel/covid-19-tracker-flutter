import 'package:intl/intl.dart';

class NumberUtils {
  static String formatDecimalPlaces(int value) {
    final formatter = new NumberFormat("#,###");
    return formatter.format(value);
  }
}