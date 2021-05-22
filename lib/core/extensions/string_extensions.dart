import 'package:intl/intl.dart';

extension StringExtension on String {
  DateTime getDate([bool isDateTime = true]) {
    try {
      var date = DateTime.parse(this);
      if (isDateTime) return date;
      return DateTime(date.year, date.month, date.day);
    } catch (e) {}
    return null;
  }

  String getFormattedDateString() {
    try {
      var parsed = DateTime.parse(this);
      var formatter = new DateFormat('MMMM d, yyyy');
      String formatted = formatter.format(parsed);
      return formatted;
    } catch (e) {}
    return "";
  }
}
