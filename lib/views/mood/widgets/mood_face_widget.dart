import 'package:flutter/material.dart';

import '../../../constants/app_dimensions.dart';
import '../../../constants/app_images.dart';
import '../../../models/mood_model.dart';

class MoodFaceWidget extends StatelessWidget {
  final MoodType mood;
  final double size;

  const MoodFaceWidget({
    super.key,
    required this.mood,
    this.size = AppDimensions.moodFaceSize,
  });

  String _assetForMood(MoodType mood) {
    switch (mood) {
      case MoodType.calm:
        return AppImages.moodFaceCalm;
      case MoodType.content:
        return AppImages.moodFaceContent;
      case MoodType.peaceful:
        return AppImages.moodFacePeaceful;
      case MoodType.happy:
        return AppImages.moodFaceHappy;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: SizedBox(
        key: ValueKey<MoodType>(mood),
        width: size,
        height: size,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMoodFace),
          child: Image.asset(
            _assetForMood(mood),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}
