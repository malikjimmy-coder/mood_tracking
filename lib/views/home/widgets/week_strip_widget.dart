import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/home_controller.dart';
import '../../../utils/date_utils.dart';

class WeekStripWidget extends ConsumerWidget {
  const WeekStripWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final selected = state.selectedDate;
    final week = state.currentWeekDays;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingScreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List<Widget>.generate(week.length, (i) {
          final day = week[i];
          final isSelected = AppDateUtils.isSameDay(day, selected);
          final dotColor = ref.watch(activityDotProvider(i));
          return _DayCell(
            label: AppStrings.days[i],
            number: day.day,
            isSelected: isSelected,
            dotColor: dotColor,
            onTap: () =>
                ref.read(homeControllerProvider.notifier).selectDate(day),
          );
        }),
      ),
    );
  }
}

class _DayCell extends StatelessWidget {
  final String label;
  final int number;
  final bool isSelected;
  final Color? dotColor;
  final VoidCallback onTap;

  const _DayCell({
    required this.label,
    required this.number,
    required this.isSelected,
    required this.dotColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Text(label, style: AppTextStyles.dayLetter),
          const SizedBox(height: AppDimensions.gapSm),
          Container(
            width: AppDimensions.weekStripDaySize,
            height: AppDimensions.weekStripDaySize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.transparent
                  : AppColors.dayCellDark,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(
                      color: AppColors.selectedDayBorder,
                      width: 1.5,
                    )
                  : null,
            ),
            child: Text(
              '$number',
              style: isSelected
                  ? AppTextStyles.dayNumberSelected
                  : AppTextStyles.dayNumber,
            ),
          ),
          const SizedBox(height: AppDimensions.gapSm),
          SizedBox(
            height: AppDimensions.activityDotSize,
            child: dotColor == null && !isSelected
                ? null
                : Container(
                    width: AppDimensions.activityDotSize,
                    height: AppDimensions.activityDotSize,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.selectedDayDot
                          : dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
