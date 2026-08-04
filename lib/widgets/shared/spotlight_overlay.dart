import 'package:flutter/material.dart';
import '../../main.dart';

class SpotlightOverlay extends StatelessWidget {
  final Offset position;
  const SpotlightOverlay({super.key, required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(painter: _SpotlightPainter(position)),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  final Offset position;
  _SpotlightPainter(this.position);

  @override
  void paint(Canvas canvas, Size size) {
    if (position == Offset.zero) return;
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          AppTheme.primaryColor.withValues(alpha: 0.04),
          Colors.transparent,
        ],
        stops: const [0.0, 1.0],
      ).createShader(Rect.fromCircle(center: position, radius: 300));
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) => old.position != position;
}
