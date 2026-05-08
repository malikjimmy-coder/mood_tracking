import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../models/insight_model.dart';

class CaloriesCardWidget extends StatelessWidget {
  final InsightModel insight;

  const CaloriesCardWidget({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final progress = insight.caloriesProgress.clamp(0.0, 1.0).toDouble();
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingCard),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  '${insight.caloriesConsumed}',
                  style: AppTextStyles.calorieLarge,
                ),
                const SizedBox(width: AppDimensions.gapXs),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    AppStrings.calories,
                    style: AppTextStyles.calorieUnit,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.gapXs),
          Text(
            '${insight.caloriesRemaining} ${AppStrings.remaining}',
            style: AppTextStyles.cardSubtitle,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text('0', style: AppTextStyles.cardLabelSmall),
              Text(
                '${insight.caloriesGoal}',
                style: AppTextStyles.cardLabelSmall,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.gapXs),
          _GradientProgressBar(progress: progress),
        ],
      ),
    );
  }
}

class _GradientProgressBar extends StatelessWidget {
  final double progress;
  const _GradientProgressBar({required this.progress});

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0).toDouble();
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimensions.progressBarHeight),
      child: SizedBox(
        height: AppDimensions.progressBarHeight,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                Container(color: AppColors.progressTrack),
                SizedBox(
                  width: constraints.maxWidth * clamped,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          AppColors.caloriesProgressStart,
                          AppColors.caloriesProgressMid,
                          AppColors.caloriesProgressEnd,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
