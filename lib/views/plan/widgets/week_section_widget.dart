import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/plan_controller.dart';
import '../../../utils/date_utils.dart';
import 'workout_day_row_widget.dart';

class WeekSectionWidget extends StatelessWidget {
  final int weekIndex;
  final PlanWeekSection section;

  const WeekSectionWidget({
    super.key,
    required this.weekIndex,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingScreen,
            vertical: AppDimensions.gapLg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${AppStrings.week} ${section.weekNumber}/${section.totalWeeks}',
                style: AppTextStyles.planWeekTitle,
              ),
              const SizedBox(height: AppDimensions.gapXs),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    AppDateUtils.formatMonthDayRange(
                      section.weekStart,
                      section.weekEnd,
                    ),
                    style: AppTextStyles.planWeekRange,
                  ),
                  Text(
                    '${AppStrings.total}: ${section.totalMinutes}min',
                    style: AppTextStyles.planWeekRange,
                  ),
                ],
              ),
            ],
          ),
        ),
        ...List<Widget>.generate(7, (i) {
          final date = section.weekStart.add(Duration(days: i));
          return WorkoutDayRowWidget(
            weekIndex: weekIndex,
            dayIndex: i,
            dayName: AppStrings.fullDays[i],
            dayNumber: date.day,
            workout: section.workoutsByDay[i],
            isLast: i == 6,
          );
        }),
        Container(
          height: AppDimensions.weekDividerHeight,
          color: AppColors.weekDividerTeal,
        ),
      ],
    );
  }
}
