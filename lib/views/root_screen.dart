import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/app_colors.dart';
import '../controllers/nav_controller.dart';
import 'home/home_screen.dart';
import 'mood/mood_screen.dart';
import 'plan/plan_screen.dart';
import 'profile/profile_screen.dart';
import 'shared/widgets/bottom_nav_bar.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeIndex = ref.watch(navControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: activeIndex,
        children: const <Widget>[
          HomeScreen(),
          PlanScreen(),
          MoodScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
