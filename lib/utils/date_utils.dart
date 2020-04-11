import 'package:intl/intl.dart';

class DateUtils {
  static DateTime formatStringToDate(String strDate){
    //TODO FIX PARSE - need to be on repository layer
    final split = strDate.split("/");
    return DateFormat('M/d/yyyy').parse("${split[0]}/${split[1]}/2020");
  }
}