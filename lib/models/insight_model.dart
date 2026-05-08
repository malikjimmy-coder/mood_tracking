class InsightModel {
  final int caloriesConsumed;
  final int caloriesGoal;
  final double weightKg;
  final double weightDeltaKg;
  final int hydrationMl;
  final int hydrationGoalMl;

  const InsightModel({
    required this.caloriesConsumed,
    required this.caloriesGoal,
    required this.weightKg,
    required this.weightDeltaKg,
    required this.hydrationMl,
    required this.hydrationGoalMl,
  });

  int get caloriesRemaining => caloriesGoal - caloriesConsumed;
  double get caloriesProgress =>
      caloriesGoal == 0 ? 0 : caloriesConsumed / caloriesGoal;
  double get hydrationProgress =>
      hydrationGoalMl == 0 ? 0 : hydrationMl / hydrationGoalMl;
}
