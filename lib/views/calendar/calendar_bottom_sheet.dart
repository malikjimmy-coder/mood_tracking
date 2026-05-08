import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/calendar_controller.dart';
import '../../controllers/home_controller.dart';
import '../../utils/date_utils.dart';

class CalendarBottomSheet extends ConsumerStatefulWidget {
  const CalendarBottomSheet({super.key});

  @override
  ConsumerState<CalendarBottomSheet> createState() =>
      _CalendarBottomSheetState();
}

class _CalendarBottomSheetState extends ConsumerState<CalendarBottomSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final selected = ref.read(homeControllerProvider).selectedDate;
      ref.read(calendarControllerProvider.notifier).initFromDate(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    final displayedMonth = ref.watch(calendarControllerProvider);
    final selected = ref.watch(homeControllerProvider).selectedDate;
    final today = AppDateUtils.startOfDay(DateTime.now());

    final firstOfMonth =
        DateTime(displayedMonth.year, displayedMonth.month, 1);
    final daysInMonth =
        DateTime(displayedMonth.year, displayedMonth.month + 1, 0).day;
    final leadingEmpty = firstOfMonth.weekday - 1; // Monday = 0

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bottomSheetBackground,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusBottomSheet),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingScreen,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(height: AppDimensions.gapMd),
            Container(
              width: AppDimensions.dragHandleWidth,
              height: AppDimensions.dragHandleHeight,
              decoration: BoxDecoration(
                color: AppColors.dragHandle,
                borderRadius:
                    BorderRadius.circular(AppDimensions.dragHandleHeight),
              ),
            ),
            const SizedBox(height: AppDimensions.gapLg),
            Row(
              children: <Widget>[
                IconButton(
                  onPressed: () => ref
                      .read(calendarControllerProvider.notifier)
                      .previousMonth(),
                  icon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: Text(
                    AppDateUtils.formatMonthYear(displayedMonth),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.calendarMonth,
                  ),
                ),
                IconButton(
                  onPressed: () => ref
                      .read(calendarControllerProvider.notifier)
                      .nextMonth(),
                  icon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.gapSm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: AppStrings.calendarDayHeaders
                  .map(
                    (d) => Expanded(
                      child: Center(
                        child: Text(
                          d,
                          style: AppTextStyles.calendarDayHeader,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: AppDimensions.gapMd),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 8,
              ),
              itemCount: leadingEmpty + daysInMonth,
              itemBuilder: (context, index) {
                if (index < leadingEmpty) {
                  return const SizedBox.shrink();
                }
                final day = index - leadingEmpty + 1;
                final date =
                    DateTime(displayedMonth.year, displayedMonth.month, day);
                final isSelected = AppDateUtils.isSameDay(date, selected);
                final isToday = AppDateUtils.isSameDay(date, today);

                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref
                        .read(homeControllerProvider.notifier)
                        .selectDate(date);
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      width: AppDimensions.calendarCellSize,
                      height: AppDimensions.calendarCellSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: !isSelected && isToday
                            ? AppColors.overlayWhite
                            : Colors.transparent,
                        border: isSelected
                            ? Border.all(
                                color: AppColors.selectedDayBorder,
                                width: 1.6,
                              )
                            : null,
                      ),
                      child: Text(
                        '$day',
                        style: AppTextStyles.calendarDate,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: AppDimensions.gapXl),
          ],
        ),
      ),
    );
  }
}
