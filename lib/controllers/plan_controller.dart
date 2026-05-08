import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_model.dart';

@immutable
class PlanWeekSection {
  final int weekNumber;
  final int totalWeeks;
  final DateTime weekStart;
  final DateTime weekEnd;
  final int totalMinutes;
  final List<WorkoutModel?> workoutsByDay; // length 7, Mon..Sun

  const PlanWeekSection({
    required this.weekNumber,
    required this.totalWeeks,
    required this.weekStart,
    required this.weekEnd,
    required this.totalMinutes,
    required this.workoutsByDay,
  });

  PlanWeekSection copyWith({List<WorkoutModel?>? workoutsByDay}) {
    return PlanWeekSection(
      weekNumber: weekNumber,
      totalWeeks: totalWeeks,
      weekStart: weekStart,
      weekEnd: weekEnd,
      totalMinutes: totalMinutes,
      workoutsByDay: workoutsByDay ?? this.workoutsByDay,
    );
  }
}

@immutable
class WorkoutDragPayload {
  final int weekIndex;
  final int dayIndex;
  final WorkoutModel workout;

  const WorkoutDragPayload({
    required this.weekIndex,
    required this.dayIndex,
    required this.workout,
  });
}

class PlanController extends StateNotifier<List<PlanWeekSection>> {
  PlanController() : super(_seed());

  static List<PlanWeekSection> _seed() {
    final week2Start = DateTime(2024, 12, 8);
    final week2End = DateTime(2024, 12, 14);
    final week3Start = DateTime(2024, 12, 14);
    final week3End = DateTime(2024, 12, 22);

    final week2 = PlanWeekSection(
      weekNumber: 2,
      totalWeeks: 8,
      weekStart: week2Start,
      weekEnd: week2End,
      totalMinutes: 60,
      workoutsByDay: <WorkoutModel?>[
        WorkoutModel(
          id: 'arms-blaster',
          title: 'Arm Blaster',
          type: WorkoutType.arms,
          date: week2Start,
          minDurationMinutes: 25,
          maxDurationMinutes: 30,
        ),
        null,
        null,
        WorkoutModel(
          id: 'leg-day-blitz',
          title: 'Leg Day Blitz',
          type: WorkoutType.legs,
          date: week2Start.add(const Duration(days: 3)),
          minDurationMinutes: 25,
          maxDurationMinutes: 30,
        ),
        null,
        null,
        null,
      ],
    );

    final week3 = PlanWeekSection(
      weekNumber: 2,
      totalWeeks: 8,
      weekStart: week3Start,
      weekEnd: week3End,
      totalMinutes: 60,
      workoutsByDay: const <WorkoutModel?>[
        null,
        null,
        null,
        null,
        null,
        null,
        null,
      ],
    );

    return <PlanWeekSection>[week2, week3];
  }

  /// Moves a workout from one (week, day) cell to another. If the destination
  /// already holds a workout, the two are swapped. Same-cell drops are a no-op.
  void moveWorkout({
    required int fromWeekIndex,
    required int fromDayIndex,
    required int toWeekIndex,
    required int toDayIndex,
  }) {
    if (fromWeekIndex == toWeekIndex && fromDayIndex == toDayIndex) return;

    final next = List<PlanWeekSection>.from(state);
    final fromDays = List<WorkoutModel?>.from(next[fromWeekIndex].workoutsByDay);
    final toDays = fromWeekIndex == toWeekIndex
        ? fromDays
        : List<WorkoutModel?>.from(next[toWeekIndex].workoutsByDay);

    final dragged = fromDays[fromDayIndex];
    if (dragged == null) return;

    final destExisting = toDays[toDayIndex];

    // Re-date the moved workouts so the displayed day matches the new slot.
    final destDate = next[toWeekIndex]
        .weekStart
        .add(Duration(days: toDayIndex));
    final srcDate = next[fromWeekIndex]
        .weekStart
        .add(Duration(days: fromDayIndex));

    toDays[toDayIndex] = WorkoutModel(
      id: dragged.id,
      title: dragged.title,
      type: dragged.type,
      date: destDate,
      minDurationMinutes: dragged.minDurationMinutes,
      maxDurationMinutes: dragged.maxDurationMinutes,
    );

    fromDays[fromDayIndex] = destExisting == null
        ? null
        : WorkoutModel(
            id: destExisting.id,
            title: destExisting.title,
            type: destExisting.type,
            date: srcDate,
            minDurationMinutes: destExisting.minDurationMinutes,
            maxDurationMinutes: destExisting.maxDurationMinutes,
          );

    next[fromWeekIndex] =
        next[fromWeekIndex].copyWith(workoutsByDay: fromDays);
    if (fromWeekIndex != toWeekIndex) {
      next[toWeekIndex] = next[toWeekIndex].copyWith(workoutsByDay: toDays);
    }

    state = next;
  }
}

final planControllerProvider =
    StateNotifierProvider<PlanController, List<PlanWeekSection>>((ref) {
  return PlanController();
});
