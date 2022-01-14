import 'package:intl/intl.dart';

class CustomDateTimeFormat {
  static int unixTimeToHour(int unixTime) {
    int dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000).hour;
    return dateTime;
  }
  static int unixTimeToDay(int unixTime) {
    int dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000).day;
    return dateTime;
  }

  static int unixTimeToMonth(int unixTime) {
    int dateTime = DateTime.fromMillisecondsSinceEpoch(unixTime * 1000).month;
    return dateTime;
  }
  static String unixTimeToWeek(int unixTime) {
    String dateTime = DateFormat('EE')
        .format(DateTime.fromMillisecondsSinceEpoch(unixTime * 1000));
    return dateTime;
  }

  static String unixTimeToHourUTC(int unixTime) {
    String dateTime = DateFormat('h a')
        .format(DateTime.fromMillisecondsSinceEpoch(unixTime * 1000));
    return dateTime;
  }
}
