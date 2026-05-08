import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/mood_controller.dart';
import '../../models/mood_model.dart';
import 'widgets/mood_wheel_widget.dart';

class MoodScreen extends ConsumerWidget {
  const MoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(moodControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColors.moodScreenGradientTop,
                    AppColors.moodScreenGradientBottom,
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            top: AppDimensions.moodTorchOffsetY,
            left: 0,
            right: 0,
            child: IgnorePointer(child: _MoodTorchLight()),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: AppDimensions.gapMd),
                  const Text(
                    AppStrings.moodTitle,
                    style: AppTextStyles.moodText,
                  ),
                  const SizedBox(height: AppDimensions.gapXl),
                  const Padding(
                    padding: EdgeInsets.only(left: AppDimensions.paddingScreen),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.startYourDay,
                          style: AppTextStyles.startDay,
                        ),
                        SizedBox(height: AppDimensions.gapXs),
                        Text(
                          AppStrings.howAreYouFeeling,
                          style: AppTextStyles.headingLarge600,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.gapXxl),
                  const Center(child: MoodWheelWidget()),
                  const SizedBox(height: AppDimensions.gapXl),
                  Center(child: _AnimatedMoodLabel(mood: state.currentMood)),
                  const Spacer(),
                  _ContinueButton(
                    onPressed: () {
                      ref
                          .read(moodControllerProvider.notifier)
                          .updateAngle(state.currentAngle);
                    },
                  ),
                  const SizedBox(height: AppDimensions.gapMd),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoodTorchLight extends StatelessWidget {
  const _MoodTorchLight();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(
          sigmaX: AppDimensions.moodTorchBlurSigma,
          sigmaY: AppDimensions.moodTorchBlurSigma,
        ),
        child: Container(
          width: AppDimensions.moodTorchSize,
          height: AppDimensions.moodTorchSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.moodTorchLight
                .withValues(alpha: AppDimensions.moodTorchAlpha),
          ),
        ),
      ),
    );
  }
}

class _AnimatedMoodLabel extends StatelessWidget {
  final MoodType mood;
  const _AnimatedMoodLabel({required this.mood});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 220),
      transitionBuilder: (child, anim) =>
          FadeTransition(opacity: anim, child: child),
      child: Text(
        mood.label,
        key: ValueKey<MoodType>(mood),
        style: AppTextStyles.moodLabel,
      ),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ContinueButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.continueBtnHeight,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.continueButtonBg,
          foregroundColor: AppColors.continueButtonText,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusContinueBtn),
          ),
          elevation: 0,
        ),
        child: const Text(
          AppStrings.continueBtn,
          style: AppTextStyles.continueBtn,
        ),
      ),
    );
  }
}
