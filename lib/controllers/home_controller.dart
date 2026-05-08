import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../models/insight_model.dart';
import '../models/workout_model.dart';
import '../utils/date_utils.dart';

@immutable
class HomeState {
  final DateTime selectedDate;
  final List<DateTime> currentWeekDays;
  final int weekNumber;
  final int totalWeeks;
  final bool isDaytime;

  const HomeState({
    required this.selectedDate,
    required this.currentWeekDays,
    required this.weekNumber,
    required this.totalWeeks,
    required this.isDaytime,
  });

  HomeState copyWith({
    DateTime? selectedDate,
    List<DateTime>? currentWeekDays,
    int? weekNumber,
    int? totalWeeks,
    bool? isDaytime,
  }) {
    return HomeState(
      selectedDate: selectedDate ?? this.selectedDate,
      currentWeekDays: currentWeekDays ?? this.currentWeekDays,
      weekNumber: weekNumber ?? this.weekNumber,
      totalWeeks: totalWeeks ?? this.totalWeeks,
      isDaytime: isDaytime ?? this.isDaytime,
    );
  }
}

class HomeController extends StateNotifier<HomeState> {
  HomeController() : super(_initial()) {
    _startTimer();
  }

  Timer? _timer;

  static HomeState _initial() {
    final now = AppDateUtils.startOfDay(DateTime.now());
    return HomeState(
      selectedDate: now,
      currentWeekDays: AppDateUtils.weekDays(now),
      weekNumber: AppDateUtils.weekNumberInMonth(now),
      totalWeeks: AppDateUtils.totalWeeksInMonth(now),
      isDaytime: _computeIsDaytime(),
    );
  }

  static bool _computeIsDaytime() {
    final hour = DateTime.now().hour;
    return hour >= 6 && hour < 18;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 60), (_) {
      final daytime = _computeIsDaytime();
      if (daytime != state.isDaytime) {
        state = state.copyWith(isDaytime: daytime);
      }
    });
  }

  void selectDate(DateTime date) {
    final d = AppDateUtils.startOfDay(date);
    state = state.copyWith(
      selectedDate: d,
      currentWeekDays: AppDateUtils.weekDays(d),
      weekNumber: AppDateUtils.weekNumberInMonth(d),
      totalWeeks: AppDateUtils.totalWeeksInMonth(d),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final homeControllerProvider =
    StateNotifierProvider<HomeController, HomeState>((ref) {
  return HomeController();
});

/// Simple deterministic activity dots per weekday index (Mon..Sun).
/// Returns a color when an activity exists for that weekday, else null.
final activityDotProvider = Provider.family<Color?, int>((ref, weekdayIndex) {
  switch (weekdayIndex) {
    case 1: // Tue
      return AppColors.dotWorkout;
    case 2: // Wed
      return AppColors.dotPlan;
    case 3: // Thu
      return AppColors.dotMood;
    case 5: // Sat
      return AppColors.dotNutrition;
    default:
      return null;
  }
});

final selectedWorkoutProvider = Provider<WorkoutModel>((ref) {
  final selected = ref.watch(homeControllerProvider).selectedDate;
  return WorkoutModel(
    id: 'workout-upper',
    title: 'Upper Body',
    type: WorkoutType.upperBody,
    date: selected,
    minDurationMinutes: 25,
    maxDurationMinutes: 30,
  );
});

final insightsProvider = Provider<InsightModel>((ref) {
  return const InsightModel(
    caloriesConsumed: 550,
    caloriesGoal: 2500,
    weightKg: 75,
    weightDeltaKg: 1.6,
    hydrationMl: 0,
    hydrationGoalMl: 2000,
  );
});

final weatherTempProvider = Provider<int>((ref) => 9);
