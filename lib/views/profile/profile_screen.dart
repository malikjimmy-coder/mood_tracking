import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_dimensions.dart';
import '../../constants/app_strings.dart';
import '../../constants/app_text_styles.dart';
import '../shared/widgets/user_avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingScreen,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: AppDimensions.gapMd),
              const Center(
                child: Text(
                  AppStrings.navProfile,
                  style: AppTextStyles.headingLarge,
                ),
              ),
              const SizedBox(height: AppDimensions.gapXl),
              const _ProfileHeader(),
              const SizedBox(height: AppDimensions.gapXl),
              const _StatsRow(),
              const SizedBox(height: AppDimensions.profileSectionGap),
              const _SectionLabel(AppStrings.profileSectionAccount),
              const SizedBox(height: AppDimensions.gapSm),
              _TileGroup(
                tiles: <_ProfileTileData>[
                  _ProfileTileData(
                    icon: Icons.person_outline,
                    title: AppStrings.profilePersonalInfo,
                    onTap: () {},
                  ),
                  _ProfileTileData(
                    icon: Icons.notifications_outlined,
                    title: AppStrings.profileNotifications,
                    onTap: () {},
                  ),
                  _ProfileTileData(
                    icon: Icons.lock_outline,
                    title: AppStrings.profilePrivacy,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.profileSectionGap),
              const _SectionLabel(AppStrings.profileSectionPreferences),
              const SizedBox(height: AppDimensions.gapSm),
              _TileGroup(
                tiles: <_ProfileTileData>[
                  _ProfileTileData(
                    icon: Icons.brightness_2_outlined,
                    title: AppStrings.profileAppearance,
                    trailing: AppStrings.profileAppearanceValue,
                    onTap: () {},
                  ),
                  _ProfileTileData(
                    icon: Icons.language_outlined,
                    title: AppStrings.profileLanguage,
                    trailing: AppStrings.profileLanguageValue,
                    onTap: () {},
                  ),
                  _ProfileTileData(
                    icon: Icons.straighten_outlined,
                    title: AppStrings.profileUnits,
                    trailing: AppStrings.profileUnitsValue,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.profileSectionGap),
              const _SectionLabel(AppStrings.profileSectionSupport),
              const SizedBox(height: AppDimensions.gapSm),
              _TileGroup(
                tiles: <_ProfileTileData>[
                  _ProfileTileData(
                    icon: Icons.help_outline,
                    title: AppStrings.profileHelp,
                    onTap: () {},
                  ),
                  _ProfileTileData(
                    icon: Icons.info_outline,
                    title: AppStrings.profileAbout,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: AppDimensions.gapXl),
              const _SignOutButton(),
              const SizedBox(height: AppDimensions.gapMd),
              const Center(
                child: Text(
                  AppStrings.profileVersion,
                  style: AppTextStyles.profileVersion,
                ),
              ),
              const SizedBox(height: AppDimensions.gapXl),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: AppDimensions.profileAvatarSize +
              AppDimensions.profileAvatarBorderWidth * 2,
          height: AppDimensions.profileAvatarSize +
              AppDimensions.profileAvatarBorderWidth * 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: AppColors.profileAvatarGlow,
                blurRadius: 28,
                spreadRadius: 4,
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(AppDimensions.profileAvatarBorderWidth),
            child: UserAvatarWidget(
              letter: 'R',
              size: AppDimensions.profileAvatarSize,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.gapMd),
        const Text(AppStrings.profileName, style: AppTextStyles.profileName),
        const SizedBox(height: AppDimensions.gapXs),
        const Text(AppStrings.profileEmail, style: AppTextStyles.profileEmail),
        const SizedBox(height: AppDimensions.gapMd),
        const _EditProfileButton(),
      ],
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusPill),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.gapLg,
          vertical: AppDimensions.gapSm,
        ),
        decoration: BoxDecoration(
          color: AppColors.profileTileBackground,
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusPill),
          border: Border.all(
            color: AppColors.profileTileDivider,
            width: 1,
          ),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.edit_outlined,
              color: AppColors.textPrimary,
              size: 14,
            ),
            SizedBox(width: AppDimensions.gapSm),
            Text(
              AppStrings.profileEditProfile,
              style: AppTextStyles.profileEditButton,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsRow extends StatelessWidget {
  const _StatsRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.profileStatCardHeight,
      decoration: BoxDecoration(
        color: AppColors.profileTileBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
      ),
      child: const Row(
        children: <Widget>[
          Expanded(
            child: _StatTile(
              value: '24',
              label: AppStrings.profileStatWorkouts,
            ),
          ),
          _StatDivider(),
          Expanded(
            child: _StatTile(
              value: '12',
              label: AppStrings.profileStatStreak,
            ),
          ),
          _StatDivider(),
          Expanded(
            child: _StatTile(
              value: '48',
              label: AppStrings.profileStatMoods,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: AppDimensions.profileStatCardHeight * 0.5,
      color: AppColors.profileTileDivider,
    );
  }
}

class _StatTile extends StatelessWidget {
  final String value;
  final String label;

  const _StatTile({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(value, style: AppTextStyles.profileStatValue),
        const SizedBox(height: AppDimensions.gapXs),
        Text(label, style: AppTextStyles.profileStatLabel),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.gapSm),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.profileSectionLabel,
      ),
    );
  }
}

class _ProfileTileData {
  final IconData icon;
  final String title;
  final String? trailing;
  final VoidCallback onTap;

  const _ProfileTileData({
    required this.icon,
    required this.title,
    this.trailing,
    required this.onTap,
  });
}

class _TileGroup extends StatelessWidget {
  final List<_ProfileTileData> tiles;
  const _TileGroup({required this.tiles});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.profileTileBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          for (int i = 0; i < tiles.length; i++) ...<Widget>[
            _ProfileTile(data: tiles[i]),
            if (i < tiles.length - 1)
              Container(
                height: 1,
                margin: const EdgeInsets.only(
                  left: AppDimensions.paddingCard +
                      AppDimensions.profileTileIconSize +
                      AppDimensions.gapMd,
                ),
                color: AppColors.profileTileDivider,
              ),
          ],
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final _ProfileTileData data;
  const _ProfileTile({required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: data.onTap,
      child: SizedBox(
        height: AppDimensions.profileTileHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingCard,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: AppDimensions.profileTileIconSize,
                height: AppDimensions.profileTileIconSize,
                decoration: BoxDecoration(
                  color: AppColors.profileIconBackground,
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusCard,
                  ),
                ),
                child: Icon(
                  data.icon,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
              const SizedBox(width: AppDimensions.gapMd),
              Expanded(
                child: Text(
                  data.title,
                  style: AppTextStyles.profileTileTitle,
                ),
              ),
              if (data.trailing != null) ...<Widget>[
                Text(
                  data.trailing!,
                  style: AppTextStyles.profileTileTrailing,
                ),
                const SizedBox(width: AppDimensions.gapSm),
              ],
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignOutButton extends StatelessWidget {
  const _SignOutButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppDimensions.profileSignOutHeight,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.profileSignOutBackground,
          foregroundColor: AppColors.profileSignOutText,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusContinueBtn),
          ),
        ),
        icon: const Icon(Icons.logout, size: 18),
        label: const Text(
          AppStrings.profileSignOut,
          style: AppTextStyles.profileSignOut,
        ),
      ),
    );
  }
}
