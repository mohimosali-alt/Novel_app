import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class ProgressRing extends StatelessWidget {
  final int percent;
  final double size;
  final Color color;
  final Color textColor;
  final Color trackColor;

  const ProgressRing({
    super.key,
    required this.percent,
    required this.textColor,
    required this.trackColor,
    this.size = 56,
    this.color = AppAccent.rose,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingPainter(percent: percent, color: color, trackColor: trackColor),
        child: Center(
          child: Text(
            '$percent%',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final int percent;
  final Color color;
  final Color trackColor;

  _RingPainter({required this.percent, required this.color, required this.trackColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = (size.width - 6) / 2;
    final track = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);
    final sweep = 2 * math.pi * (percent / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, sweep, false, fg);
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => oldDelegate.percent != percent;
}
