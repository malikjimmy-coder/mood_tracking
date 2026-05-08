import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/date_utils.dart';

class CalendarController extends StateNotifier<DateTime> {
  CalendarController()
      : super(DateTime(DateTime.now().year, DateTime.now().month, 1));

  void setDisplayedMonth(DateTime month) {
    state = DateTime(month.year, month.month, 1);
  }

  void previousMonth() {
    state = DateTime(state.year, state.month - 1, 1);
  }

  void nextMonth() {
    state = DateTime(state.year, state.month + 1, 1);
  }

  void initFromDate(DateTime date) {
    final first = DateTime(date.year, date.month, 1);
    if (!AppDateUtils.isSameDay(first, state)) {
      state = first;
    }
  }
}

final calendarControllerProvider =
    StateNotifierProvider<CalendarController, DateTime>((ref) {
  return CalendarController();
});
