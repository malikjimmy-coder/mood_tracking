import 'package:intl/intl.dart';

class AppDateUtils {
  const AppDateUtils._();

  static DateTime startOfDay(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static DateTime mondayOfWeek(DateTime date) {
    final d = startOfDay(date);
    return d.subtract(Duration(days: d.weekday - DateTime.monday));
  }

  static List<DateTime> weekDays(DateTime date) {
    final monday = mondayOfWeek(date);
    return List<DateTime>.generate(
      7,
      (i) => monday.add(Duration(days: i)),
    );
  }

  static int weekNumberInMonth(DateTime date) {
    final monday = mondayOfWeek(date);
    final firstOfMonth = DateTime(monday.year, monday.month, 1);
    final firstMonday = mondayOfWeek(firstOfMonth);
    final diff = monday.difference(firstMonday).inDays;
    return (diff ~/ 7) + 1;
  }

  static int totalWeeksInMonth(DateTime date) {
    final firstOfMonth = DateTime(date.year, date.month, 1);
    final lastDay = DateTime(date.year, date.month + 1, 0);
    final firstMonday = mondayOfWeek(firstOfMonth);
    final lastMonday = mondayOfWeek(lastDay);
    return (lastMonday.difference(firstMonday).inDays ~/ 7) + 1;
  }

  static String formatTodayHeader(DateTime date) =>
      'Today, ${DateFormat('dd MMM yyyy').format(date)}';

  static String formatMonthYear(DateTime date) =>
      DateFormat('MMM yyyy').format(date);

  static String formatMonthDayRange(DateTime start, DateTime end) {
    final monthName = DateFormat('MMMM').format(start);
    return '$monthName ${start.day}-${end.day}';
  }

  static String formatWorkoutDate(DateTime date) =>
      DateFormat('MMMM d').format(date);

  static bool isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
