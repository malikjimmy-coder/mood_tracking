import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_dimensions.dart';
import '../../../controllers/mood_controller.dart';
import 'mood_face_widget.dart';

class MoodWheelWidget extends ConsumerStatefulWidget {
  final double size;
  const MoodWheelWidget({super.key, this.size = AppDimensions.moodWheelSize});

  @override
  ConsumerState<MoodWheelWidget> createState() => _MoodWheelWidgetState();
}

class _MoodWheelWidgetState extends ConsumerState<MoodWheelWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleDrag(Offset localPosition) {
    final cx = widget.size / 2;
    final cy = widget.size / 2;
    final dx = localPosition.dx - cx;
    final dy = localPosition.dy - cy;
    if (dx.abs() < 1 && dy.abs() < 1) return;
    final canvasRad = math.atan2(dy, dx);
    final clockRad = canvasRad + math.pi / 2;
    final degrees = (clockRad * 180 / math.pi + 360) % 360;
    ref.read(moodControllerProvider.notifier).updateAngle(degrees);
    _animController
      ..stop()
      ..forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(moodControllerProvider);
    final size = widget.size;

    return SizedBox(
      width: size,
      height: size,
      child: GestureDetector(
        onPanStart: (d) => _handleDrag(d.localPosition),
        onPanUpdate: (d) => _handleDrag(d.localPosition),
        onTapDown: (d) => _handleDrag(d.localPosition),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            CustomPaint(
              size: Size.square(size),
              painter: _MoodRingPainter(),
            ),
            MoodFaceWidget(mood: state.currentMood),
            _MoodHandle(angleDegrees: state.currentAngle, wheelSize: size),
          ],
        ),
      ),
    );
  }
}

class _MoodRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const stroke = AppDimensions.moodWheelStrokeWidth;
    final radius = (size.width - stroke) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    final rect = Rect.fromCircle(center: center, radius: radius);

    // Color peaks land on the four diagonals:
    //   stop 0.0  — top-right (Calm)
    //   stop 0.25 — bottom-right (Content)
    //   stop 0.5  — bottom-left (Peaceful)
    //   stop 0.75 — top-left (Happy)
    //   stop 1.0  — wraps back to Calm
    const colors = <Color>[
      AppColors.moodWheelCalm,
      AppColors.moodWheelContent,
      AppColors.moodWheelPeaceful,
      AppColors.moodWheelHappy,
      AppColors.moodWheelCalm,
    ];

    const gradient = SweepGradient(
      // Shift the sweep by +π/4 so 0.0 lands at the top-right (1:30 o'clock).
      startAngle: -math.pi / 4,
      endAngle: 7 * math.pi / 4,
      colors: colors,
      stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
    );

    final ringPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    // Near-full arc with a tiny hidden gap to keep ends rounded smoothly.
    canvas.drawArc(rect, -math.pi / 2, 2 * math.pi - 0.001, false, ringPaint);

    // Subtle tick marks
    final tickPaint = Paint()
      ..color = const Color(0xffffffff)
      ..strokeWidth = 0.5
      ..strokeCap = StrokeCap.round;
    const tickCount = 12;
    for (int i = 0; i < tickCount; i++) {
      final angle = (i / tickCount) * 2 * math.pi - math.pi / 2;
      final inner = Offset(
        center.dx + (radius - stroke / 2 + 4) * math.cos(angle),
        center.dy + (radius - stroke / 2 + 4) * math.sin(angle),
      );
      final outer = Offset(
        center.dx + (radius + stroke / 2 - 4) * math.cos(angle),
        center.dy + (radius + stroke / 2 - 4) * math.sin(angle),
      );
      canvas.drawLine(inner, outer, tickPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _MoodRingPainter oldDelegate) => false;
}

class _MoodHandle extends StatelessWidget {
  final double angleDegrees;
  final double wheelSize;

  const _MoodHandle({required this.angleDegrees, required this.wheelSize});

  @override
  Widget build(BuildContext context) {
    const stroke = AppDimensions.moodWheelStrokeWidth;
    final radius = (wheelSize - stroke) / 2;
    final rad = angleDegrees * math.pi / 180;
    // Clock-style: 0° at top, increases clockwise.
    final dx = math.sin(rad) * radius;
    final dy = -math.cos(rad) * radius;

    return IgnorePointer(
      child: Transform.translate(
        offset: Offset(dx, dy),
        child: Container(
          width: AppDimensions.moodHandleSize,
          height: AppDimensions.moodHandleSize,
          decoration: BoxDecoration(
            color: AppColors.moodHandle,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.moodHandleBorder,
              width: AppDimensions.moodHandleBorderWidth,
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: AppColors.moodHandleGlow,
                blurRadius: 16,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
