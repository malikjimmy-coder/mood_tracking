import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../models/insight_model.dart';

class WeightCardWidget extends StatelessWidget {
  final InsightModel insight;

  const WeightCardWidget({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final delta = insight.weightDeltaKg;
    final sign = delta >= 0 ? '+' : '';
    final weightText =
        insight.weightKg == insight.weightKg.toInt().toDouble()
            ? insight.weightKg.toInt().toString()
            : insight.weightKg.toStringAsFixed(1);

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
                Text(weightText, style: AppTextStyles.weightLarge),
                const SizedBox(width: AppDimensions.gapXs),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text('kg', style: AppTextStyles.weightUnit),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.gapXs),
          Row(
            children: <Widget>[
              Container(
                width: 22,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.weightArrow.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  AppIcons.weightArrowUp,


                ),
              ),
              const SizedBox(width: AppDimensions.gapSm),
              Text(
                '$sign${delta.toStringAsFixed(1)}kg',
                style: AppTextStyles.weightDelta,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.gapXl),
          const Text(AppStrings.weight, style: AppTextStyles.headingSmall),
        ],
      ),
    );
  }
}
