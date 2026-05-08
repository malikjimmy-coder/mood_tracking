import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mood_model.dart';

@immutable
class MoodState {
  final double currentAngle;
  final MoodType currentMood;

  const MoodState({required this.currentAngle, required this.currentMood});

  MoodState copyWith({double? currentAngle, MoodType? currentMood}) =>
      MoodState(
        currentAngle: currentAngle ?? this.currentAngle,
        currentMood: currentMood ?? this.currentMood,
      );
}

class MoodController extends StateNotifier<MoodState> {
  MoodController()
      : super(const MoodState(currentAngle: 60, currentMood: MoodType.calm));

  static MoodType moodFromAngle(double degrees) {
    final a = ((degrees % 360) + 360) % 360;
    if (a >= 30 && a < 90) return MoodType.calm;
    if (a >= 90 && a < 150) return MoodType.content;
    if (a >= 210 && a < 270) return MoodType.peaceful;
    if (a >= 300 && a < 360) return MoodType.happy;
    if (a < 30) return MoodType.happy; // wraps around
    if (a >= 150 && a < 210) return MoodType.content; // pink edge
    return MoodType.peaceful;
  }

  void updateAngle(double degrees) {
    final normalized = ((degrees % 360) + 360) % 360;
    final mood = moodFromAngle(normalized);
    state = state.copyWith(currentAngle: normalized, currentMood: mood);
  }
}

final moodControllerProvider =
    StateNotifierProvider<MoodController, MoodState>((ref) {
  return MoodController();
});
