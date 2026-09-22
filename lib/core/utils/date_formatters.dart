import 'package:intl/intl.dart';

class DateFormatters {
  static final DateFormat standardDate = DateFormat('dd MMM yyyy');
  static final DateFormat fullDate = DateFormat('EEEE, MMMM d, yyyy');
  static final DateFormat time12Hour = DateFormat('hh:mm a');
  static final DateFormat isoDate = DateFormat('yyyy-MM-dd');

  static String formatDisplayDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return standardDate.format(dateTime);
  }

  static String formatFullDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return fullDate.format(dateTime);
  }

  static String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    return time12Hour.format(dateTime);
  }

  static DateTime? parseIsoDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return null;
    try {
      return DateTime.parse(dateStr);
    } catch (_) {
      return null;
    }
  }
}
