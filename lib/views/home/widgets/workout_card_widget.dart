import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_text_styles.dart';
import '../../../models/workout_model.dart';
import '../../../utils/date_utils.dart';

class WorkoutCardWidget extends StatelessWidget {
  final WorkoutModel workout;

  const WorkoutCardWidget({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: AppDimensions.workoutCardLeftAccentWidth,
              color: AppColors.workoutCardLeftBorder,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingCard,
                  vertical: AppDimensions.gapLg,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${AppDateUtils.formatWorkoutDate(workout.date)} - '
                            '${workout.durationLabel}',
                            style: AppTextStyles.workoutCardMeta,
                          ),
                          const SizedBox(height: AppDimensions.gapXs),
                          Text(
                            workout.title,
                            style: AppTextStyles.workoutCardTitle,
                          ),
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      AppIcons.arrow,
                      width: AppDimensions.iconSizeLg,
                      height: AppDimensions.iconSizeLg,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
