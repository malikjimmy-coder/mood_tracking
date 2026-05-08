enum WorkoutType { arms, legs, upperBody }

class WorkoutModel {
  final String id;
  final String title;
  final WorkoutType type;
  final DateTime date;
  final int minDurationMinutes;
  final int maxDurationMinutes;

  const WorkoutModel({
    required this.id,
    required this.title,
    required this.type,
    required this.date,
    required this.minDurationMinutes,
    required this.maxDurationMinutes,
  });

  String get durationLabel => '${minDurationMinutes}m - ${maxDurationMinutes}m';
}
