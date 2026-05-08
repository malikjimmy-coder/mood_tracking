import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../constants/app_strings.dart';
import '../../../constants/app_text_styles.dart';
import '../../../models/insight_model.dart';

class HydrationCardWidget extends StatelessWidget {
  final InsightModel insight;

  const HydrationCardWidget({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final progress = insight.hydrationProgress.clamp(0.0, 1.0).toDouble();
    final percent = (progress * 100).round();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusCard),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingCard),
            child: SizedBox(
              height: AppDimensions.hydrationCardInnerHeight,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final h = constraints.maxHeight;
                  final barX = w * 0.55;
                  const barTopY = AppDimensions.gapMd;
                  final barBottomY = h - AppDimensions.gapXxl;
                  final trackEndX = w - AppDimensions.hydrationTrackEndPadding;
                  final fillY = barBottomY -
                      (barBottomY - barTopY) * progress.clamp(0.0, 1.0);

                  return Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Positioned.fill(
                        child: CustomPaint(
                          painter: _HydrationGraphicsPainter(
                            barX: barX,
                            barTopY: barTopY,
                            barBottomY: barBottomY,
                            fillY: fillY,
                            trackEndX: trackEndX,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Text(
                          '$percent%',
                          style: AppTextStyles.hydrationLarge,
                        ),
                      ),
                      const Positioned(
                        left: 0,
                        bottom: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              AppStrings.hydration,
                              style: AppTextStyles.headingSmall,
                            ),
                            SizedBox(height: AppDimensions.gapXs),
                            Text(
                              AppStrings.logNow,
                              style: AppTextStyles.cardSubtitle,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: barX - AppDimensions.hydrationLabelGap,
                        top: barTopY - AppDimensions.gapSm,
                        child: const Text(
                          '2 L',
                          style: AppTextStyles.hydrationAxis,
                        ),
                      ),
                      Positioned(
                        left: barX - AppDimensions.hydrationLabelGap,
                        top: barBottomY,
                        child: const Text(
                          '0 L',
                          style: AppTextStyles.hydrationAxis,
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: barBottomY,
                        child: Text(
                          '${insight.hydrationMl}ml',
                          style: AppTextStyles.hydrationMl,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Container(
            color: AppColors.hydrationBanner,
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.gapMd,
              horizontal: AppDimensions.paddingCard,
            ),
            alignment: Alignment.center,
            child: const Text(
              AppStrings.waterLogBanner,
              style: AppTextStyles.bannerText,
            ),
          ),
        ],
      ),
    );
  }
}

class _HydrationGraphicsPainter extends CustomPainter {
  final double barX;
  final double barTopY;
  final double barBottomY;
  final double fillY;
  final double trackEndX;

  _HydrationGraphicsPainter({
    required this.barX,
    required this.barTopY,
    required this.barBottomY,
    required this.fillY,
    required this.trackEndX,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final dotPaint = Paint()
      ..color = AppColors.hydrationText.withValues(alpha: 0.45)
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    double y = barTopY + AppDimensions.hydrationDotSpacing;
    while (y < barBottomY - AppDimensions.hydrationDotSpacing) {
      canvas.drawLine(
        Offset(barX, y),
        Offset(barX, y + AppDimensions.hydrationDotLength),
        dotPaint,
      );
      y += AppDimensions.hydrationDotSpacing +
          AppDimensions.hydrationDotLength;
    }

    final pillPaint = Paint()..color = AppColors.hydrationText;
    const pillRadius =
        Radius.circular(AppDimensions.hydrationPillHeight / 2);

    void drawPill(double cy) {
      final rect = Rect.fromCenter(
        center: Offset(barX, cy),
        width: AppDimensions.hydrationPillWidth,
        height: AppDimensions.hydrationPillHeight,
      );
      canvas.drawRRect(RRect.fromRectAndRadius(rect, pillRadius), pillPaint);
    }

    drawPill(barTopY);
    drawPill((barTopY + barBottomY) / 2);
    drawPill(fillY);

    final trackPaint = Paint()
      ..color = AppColors.hydrationText.withValues(alpha: 0.45)
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(barX + AppDimensions.hydrationPillWidth / 2 + 2, fillY),
      Offset(trackEndX, fillY),
      trackPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HydrationGraphicsPainter old) =>
      old.fillY != fillY ||
      old.barX != barX ||
      old.barTopY != barTopY ||
      old.barBottomY != barBottomY ||
      old.trackEndX != trackEndX;
}
