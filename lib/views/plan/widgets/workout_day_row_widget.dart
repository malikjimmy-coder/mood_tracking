import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/plan_controller.dart';
import '../../../models/workout_model.dart';

class WorkoutDayRowWidget extends ConsumerWidget {
  final int weekIndex;
  final int dayIndex;
  final String dayName;
  final int dayNumber;
  final WorkoutModel? workout;
  final bool isLast;

  const WorkoutDayRowWidget({
    super.key,
    required this.weekIndex,
    required this.dayIndex,
    required this.dayName,
    required this.dayNumber,
    required this.workout,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasWorkout = workout != null;
    final dayColor =
        hasWorkout ? AppColors.textPrimary : AppColors.textDate;

    return DragTarget<WorkoutDragPayload>(
      onWillAcceptWithDetails: (details) {
        final p = details.data;
        return !(p.weekIndex == weekIndex && p.dayIndex == dayIndex);
      },
      onAcceptWithDetails: (details) {
        ref.read(planControllerProvider.notifier).moveWorkout(
              fromWeekIndex: details.data.weekIndex,
              fromDayIndex: details.data.dayIndex,
              toWeekIndex: weekIndex,
              toDayIndex: dayIndex,
            );
      },
      builder: (context, candidate, rejected) {
        final isHovering = candidate.isNotEmpty;
        return Container(
          decoration: BoxDecoration(
            color: isHovering ? AppColors.overlayWhite : null,
            border: isLast
                ? null
                : const Border(
                    bottom:
                        BorderSide(color: Color(0xFF1F1F22), width: 0.6),
                  ),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingScreen,
            vertical: AppDimensions.gapMd,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      dayName,
                      style: AppTextStyles.planDayName.copyWith(
                        color: dayColor,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.gapXs),
                    Text(
                      '$dayNumber',
                      style: AppTextStyles.planDayNumber.copyWith(
                        color: dayColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasWorkout)
                Expanded(
                  child: _DraggableWorkout(
                    workout: workout!,
                    weekIndex: weekIndex,
                    dayIndex: dayIndex,
                  ),
                )
              else
                const Expanded(child: SizedBox(height: 44)),
            ],
          ),
        );
      },
    );
  }
}

class _DraggableWorkout extends StatelessWidget {
  final WorkoutModel workout;
  final int weekIndex;
  final int dayIndex;

  const _DraggableWorkout({
    required this.workout,
    required this.weekIndex,
    required this.dayIndex,
  });

  @override
  Widget build(BuildContext context) {
    final panel = _WorkoutPanel(workout: workout);
    final payload = WorkoutDragPayload(
      weekIndex: weekIndex,
      dayIndex: dayIndex,
      workout: workout,
    );
    return LongPressDraggable<WorkoutDragPayload>(
      data: payload,
      delay: const Duration(milliseconds: 180),
      hapticFeedbackOnStart: true,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: _DragFeedback(workout: workout),
      childWhenDragging: Opacity(opacity: 0.35, child: panel),
      child: panel,
    );
  }
}

class _DragFeedback extends StatelessWidget {
  final WorkoutModel workout;
  const _DragFeedback({required this.workout});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width -
            AppDimensions.paddingScreen * 2 -
            72,
        child: Transform.scale(
          scale: 1.03,
          child: _WorkoutPanel(workout: workout),
        ),
      ),
    );
  }
}

class _WorkoutPanel extends StatelessWidget {
  final WorkoutModel workout;
  const _WorkoutPanel({required this.workout});

  @override
  Widget build(BuildContext context) {
    final isArms = workout.type == WorkoutType.arms;
    final pillBg = isArms
        ? AppColors.pillArmsBackground
        : AppColors.pillLegsBackground;
    final pillFg = isArms ? AppColors.pillArmsText : AppColors.pillLegsText;
    final pillIcon = isArms ? AppIcons.armsWorkout : AppIcons.legWorkout;
    final pillLabel =
        isArms ? AppStrings.armsWorkoutLabel : AppStrings.legWorkoutLabel;

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
              color: AppColors.textPrimary,
            ),
            const SizedBox(width: AppDimensions.gapSm),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SvgPicture.asset(
                AppIcons.dragHandle,
                width: 10,
                height: 18,
              ),
            ),
            const SizedBox(width: AppDimensions.gapMd),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.gapSm,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: pillBg,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusPill,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SvgPicture.asset(
                            pillIcon,
                            width: 12,
                            height: 12,
                            colorFilter: ColorFilter.mode(
                              pillFg,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            pillLabel,
                            style: AppTextStyles.pillText.copyWith(
                              color: pillFg,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      workout.title,
                      style: AppTextStyles.planWorkoutTitle,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: AppDimensions.gapMd),
              child: Center(
                child: Text(
                  workout.durationLabel,
                  style: AppTextStyles.planWorkoutDuration,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
