import 'package:intl/intl.dart';

class AppDateFormat {
  static String formatDate({required DateTime? dateTime}) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd MMM yyyy').format(dateTime);
  }

  /// format date to 'EEE, dd MMM yyyy'
  static String formatDateTime({required DateTime dateTime}) {
    return DateFormat('EEEE, dd MMM yyyy', 'ID').format(dateTime);
  }

  static String formatTime({required DateTime? dateTime}) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('HH:mm').format(dateTime);
  }

  static DateTime stringTimeToDateTime({required String? time}) {
    return DateFormat('dd MMM yyyy HH:mm:ss', 'ID').parse('01 Jan 2000 $time');
  }
}
