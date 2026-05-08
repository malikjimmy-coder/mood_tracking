import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../controllers/nav_controller.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(navControllerProvider);

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          top: BorderSide(color: Color(0x222C2C2E), width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppDimensions.bottomNavHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _NavItem(
                icon: AppIcons.nutritionNav,
                label: AppStrings.navNutrition,
                index: 0,
                activeIndex: activeIndex,
                onTap: () => ref.read(navControllerProvider.notifier).setIndex(0),
              ),
              _NavItem(
                icon: AppIcons.planNav,
                label: AppStrings.navPlan,
                index: 1,
                activeIndex: activeIndex,
                onTap: () => ref.read(navControllerProvider.notifier).setIndex(1),
              ),
              _NavItem(
                icon: AppIcons.moodNav,
                label: AppStrings.navMood,
                index: 2,
                activeIndex: activeIndex,
                onTap: () => ref.read(navControllerProvider.notifier).setIndex(2),
              ),
              _NavItem(
                icon: AppIcons.profileNav,
                label: AppStrings.navProfile,
                index: 3,
                activeIndex: activeIndex,
                onTap: () => ref.read(navControllerProvider.notifier).setIndex(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final int index;
  final int activeIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == activeIndex;
    final color = isActive ? AppColors.navActive : AppColors.navInactive;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              icon,
              width: AppDimensions.iconSizeLg,
              height: AppDimensions.iconSizeLg,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: AppDimensions.gapXs),
            Text(label, style: AppTextStyles.navLabel.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}
