import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_text_styles.dart';

class UserAvatarWidget extends StatelessWidget {
  final String letter;
  final Color backgroundColor;
  final double size;
  final Color borderColor;
  final double borderWidth;

  const UserAvatarWidget({
    super.key,
    required this.letter,
    this.backgroundColor = AppColors.avatarBg,
    this.size = AppDimensions.avatarSize,
    this.borderColor = AppColors.background,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: borderWidth > 0
            ? Border.all(color: borderColor, width: borderWidth)
            : null,
      ),
      child: Text(letter, style: AppTextStyles.avatarLetter),
    );
  }
}
