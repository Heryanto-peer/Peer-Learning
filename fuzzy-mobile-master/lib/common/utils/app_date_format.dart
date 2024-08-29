import 'package:intl/intl.dart';

class AppDateFormat {
  static String formatDate({required DateTime? dateTime}) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd MMM yyyy', 'ID').format(dateTime);
  }

  /// format date to 'EEE, dd MMM yyyy'
  static String formatDateTime({required DateTime dateTime}) {
    return DateFormat('EEEE, dd MMM yyyy', 'ID').format(dateTime);
  }

  static DateTime formatDateToDate({required DateTime dateTime}) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String formatTime({required DateTime? dateTime}) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('HH:mm', 'ID').format(dateTime);
  }

  static DateTime stringDateToDateTime({required String? date}) {
    return DateFormat('dd MMM yyyy', 'ID').parse(date!);
  }

  static DateTime stringTimeToDateTime({required String? time}) {
    return DateFormat('dd MMM yyyy HH:mm:ss', 'ID').parse('${formatDate(dateTime: DateTime.now())} $time');
  }
}
