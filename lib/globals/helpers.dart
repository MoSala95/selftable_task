import 'package:intl/intl.dart';
class Helpers{
  static String formatDate(DateTime date) {
    return DateFormat("yyyy-MM-dd").format(date);
  }
}