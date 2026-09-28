import 'dart:math';
import 'package:flutter/material.dart';
import '../../main.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<_Particle> _particles;

  // Track which count was used so we only regenerate when the bucket changes,
  // not on every MediaQuery update (e.g. scroll, keyboard, resize by 1px).
  int _lastParticleCount = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // Initialize with a sensible default; didChangeDependencies will refine
    // on first layout if needed.
    _particles = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final w = MediaQuery.of(context).size.width;
    final targetCount = w < AppTheme.mobileBreakpoint ? 25 : 50;

    // Only regenerate when the desired count changes (mobile ↔ desktop switch).
    if (targetCount != _lastParticleCount) {
      _lastParticleCount = targetCount;
      final rng = Random();
      _particles = List.generate(
        targetCount,
        (_) => _Particle(
          x: rng.nextDouble(),
          y: rng.nextDouble(),
          speed: 0.02 + rng.nextDouble() * 0.05,
          size: 1.0 + rng.nextDouble() * 2.0,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      excludeSemantics: true,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: _ParticlePainter(_particles, _controller.value),
          size: Size.infinite,
        ),
      ),
    );
  }
}

class _Particle {
  final double x, y, speed, size;
  const _Particle({
    required this.x,
    required this.y,
    required this.speed,
    required this.size,
  });
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (particles.isEmpty) return;

    final positions = particles
        .map(
          (p) => Offset(
            ((p.x + progress * p.speed) % 1.0) * size.width,
            ((p.y + progress * p.speed * 0.5) % 1.0) * size.height,
          ),
        )
        .toList(growable: false);

    const threshold = 120.0;
    final linePaint = Paint()..strokeWidth = 0.6;

    for (int i = 0; i < positions.length; i++) {
      for (int j = i + 1; j < positions.length; j++) {
        final d = (positions[i] - positions[j]).distance;
        if (d < threshold) {
          linePaint.color = AppTheme.primaryColor
              .withValues(alpha: (1 - d / threshold) * 0.10);
          canvas.drawLine(positions[i], positions[j], linePaint);
        }
      }
    }

    final dotPaint = Paint()
      ..color = AppTheme.primaryColor.withValues(alpha: 0.3);
    for (int i = 0; i < positions.length; i++) {
      canvas.drawCircle(positions[i], particles[i].size, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}
