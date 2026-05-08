import '../constants/app_strings.dart';

enum MoodType { calm, content, peaceful, happy }

extension MoodTypeX on MoodType {
  String get label {
    switch (this) {
      case MoodType.calm:
        return AppStrings.moodCalm;
      case MoodType.content:
        return AppStrings.moodContent;
      case MoodType.peaceful:
        return AppStrings.moodPeaceful;
      case MoodType.happy:
        return AppStrings.moodHappy;
    }
  }
}

class MoodModel {
  final MoodType type;
  final double angleDegrees;
  final DateTime timestamp;

  const MoodModel({
    required this.type,
    required this.angleDegrees,
    required this.timestamp,
  });
}
