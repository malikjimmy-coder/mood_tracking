import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../../controllers/plan_controller.dart';
import 'widgets/week_section_widget.dart';

class PlanScreen extends ConsumerWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sections = ref.watch(planControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: AppDimensions.gapMd),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingScreen,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    AppStrings.trainingCalendar,
                    style: AppTextStyles.headingLarge,
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.gapSm,
                      ),
                    ),
                    child: const Text(
                      AppStrings.save,
                      style: AppTextStyles.saveBtn,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDimensions.gapMd),
            Container(
              height: AppDimensions.headerDividerHeight,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    AppColors.headerDividerStart,
                    AppColors.headerDividerEnd,
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: sections.length,
                itemBuilder: (context, i) {
                  return WeekSectionWidget(
                    weekIndex: i,
                    section: sections[i],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
