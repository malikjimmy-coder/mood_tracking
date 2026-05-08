import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_icons.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/home_controller.dart';
import '../../utils/date_utils.dart';
import '../calendar/calendar_bottom_sheet.dart';
import 'widgets/calories_card_widget.dart';
import 'widgets/hydration_card_widget.dart';
import 'widgets/weight_card_widget.dart';
import 'widgets/week_strip_widget.dart';
import 'widgets/workout_card_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void _openCalendar(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const CalendarBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);
    final workout = ref.watch(selectedWorkoutProvider);
    final insight = ref.watch(insightsProvider);
    final temp = ref.watch(weatherTempProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: AppDimensions.gapSm),
            _TopBar(
              isDaytime: state.isDaytime,
              weekNumber: state.weekNumber,
              totalWeeks: state.totalWeeks,
              onTapWeek: () => _openCalendar(context),
            ),
            const SizedBox(height: AppDimensions.gapLg),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: Text(
                AppDateUtils.formatTodayHeader(state.selectedDate),
                style: AppTextStyles.dateHeader,
              ),
            ),
            const SizedBox(height: AppDimensions.gapLg),
            const WeekStripWidget(),
            const SizedBox(height: AppDimensions.gapLg),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    AppStrings.workouts,
                    style: AppTextStyles.headingLarge,
                  ),
                  Row(
                    children: <Widget>[
                      SvgPicture.asset(
                        state.isDaytime ? AppIcons.sun : AppIcons.moon,
                        width: AppDimensions.iconSizeLg,
                        height: AppDimensions.iconSizeLg,
                        colorFilter: const ColorFilter.mode(
                          AppColors.textPrimary,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.gapSm),
                      Text('$temp°', style: AppTextStyles.weatherTemp),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.gapMd),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: WorkoutCardWidget(workout: workout),
            ),
            const SizedBox(height: AppDimensions.gapXxl),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: Text(
                AppStrings.myInsights,
                style: AppTextStyles.headingLarge,
              ),
            ),
            const SizedBox(height: AppDimensions.gapMd),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(child: CaloriesCardWidget(insight: insight)),
                    const SizedBox(width: AppDimensions.gapMd),
                    Expanded(child: WeightCardWidget(insight: insight)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.gapMd),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: HydrationCardWidget(insight: insight),
            ),
            const SizedBox(height: AppDimensions.gapXl),
          ],
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final bool isDaytime;
  final int weekNumber;
  final int totalWeeks;
  final VoidCallback onTapWeek;

  const _TopBar({
    required this.isDaytime,
    required this.weekNumber,
    required this.totalWeeks,
    required this.onTapWeek,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingScreen,
      ),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            AppIcons.bell,
            width: AppDimensions.iconSizeMd,
            height: AppDimensions.iconSizeSm,
            colorFilter: const ColorFilter.mode(
              AppColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTapWeek,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    isDaytime ? AppIcons.sun : AppIcons.moonCircle,
                    width: AppDimensions.iconSizeMd,
                    height: AppDimensions.iconSizeMd,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.gapSm),
                  Text(
                    '${AppStrings.week} $weekNumber/$totalWeeks',
                    style: AppTextStyles.weekLabel,
                  ),
                  const SizedBox(width: AppDimensions.gapXs),
                  SvgPicture.asset(
                    AppIcons.dropdownArrow,
                    width: 12,
                    height: 12,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textPrimary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.iconSizeLg),
        ],
      ),
    );
  }
}
