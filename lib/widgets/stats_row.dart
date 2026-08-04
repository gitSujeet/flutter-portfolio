import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../main.dart';

class StatsRow extends StatefulWidget {
  final bool isMobile;
  const StatsRow({super.key, required this.isMobile});

  @override
  State<StatsRow> createState() => _StatsRowState();
}

class _StatsRowState extends State<StatsRow> {
  bool _visible = false;

  // Updated: 4+ years from resume
  static const _stats = [
    ('4+',  'Years Experience'),
    ('1M+', 'App Users'),
    ('10+', 'Projects Delivered'),
    ('2×',  'TCS Award Winner'),
  ];

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('stats-row'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.3 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: 700.ms,
        opacity: _visible ? 1.0 : 0.0,
        child: AnimatedSlide(
          duration: 700.ms,
          offset: _visible ? Offset.zero : const Offset(0, 0.15),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: widget.isMobile ? 24 : 32,
              horizontal: widget.isMobile ? 20 : 40,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              color: Colors.white.withValues(alpha: 0.02),
            ),
            child: widget.isMobile
                ? Wrap(
                    spacing: 24,
                    runSpacing: 20,
                    children: _stats
                        .map((s) => _StatItem(
                              value: s.$1,
                              label: s.$2,
                              isMobile: widget.isMobile,
                              animate: _visible,
                            ))
                        .toList(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _stats
                        .map((s) => _StatItem(
                              value: s.$1,
                              label: s.$2,
                              isMobile: widget.isMobile,
                              animate: _visible,
                            ))
                        .toList(),
                  ),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  final bool isMobile;
  final bool animate;

  const _StatItem({
    required this.value,
    required this.label,
    required this.isMobile,
    required this.animate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'Courier New',
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
            height: 1,
          ),
        ).animate(target: animate ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: isMobile ? 11 : 12,
            letterSpacing: 1.5,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}
