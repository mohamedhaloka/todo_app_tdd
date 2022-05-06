import 'package:intl/intl.dart';

class TimeFormat {
  TimeFormat._();
  static TimeFormat get instance => TimeFormat._();

  String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }

}

const String dayNameWithTime = 'EEEE, hh:mm aa';