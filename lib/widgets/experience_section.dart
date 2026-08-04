import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../main.dart';
import '../data/models.dart';
import '../data/portfolio_data.dart';

class ExperienceSection extends StatefulWidget {
  final bool isMobile;
  const ExperienceSection({super.key, required this.isMobile});

  @override
  State<ExperienceSection> createState() => _ExperienceSectionState();
}

class _ExperienceSectionState extends State<ExperienceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('experience-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: 700.ms,
        opacity: _visible ? 1 : 0,
        child: AnimatedSlide(
          duration: 700.ms,
          offset: _visible ? Offset.zero : const Offset(0, 0.1),
          child: Container(
            padding: EdgeInsets.all(widget.isMobile ? 24 : 36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border:
                  Border.all(color: Colors.white.withValues(alpha: 0.06)),
              color: Colors.white.withValues(alpha: 0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row
                widget.isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TcsBadge(),
                          const SizedBox(height: 14),
                          _RoleInfo(
                              isMobile: widget.isMobile, exp: experience),
                          const SizedBox(height: 10),
                          _DateBadge(text: experience.duration),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TcsBadge(),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _RoleInfo(
                                isMobile: widget.isMobile, exp: experience),
                          ),
                          _DateBadge(text: experience.duration),
                        ],
                      ),

                const SizedBox(height: 28),
                Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.05)),
                const SizedBox(height: 24),

                const Text(
                  'KEY HIGHLIGHTS',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 3,
                    color: Colors.white30,
                  ),
                ),
                const SizedBox(height: 16),

                ...experience.highlights.asMap().entries.map(
                      (e) => _HighlightRow(
                        text: e.value,
                        index: e.key,
                        isMobile: widget.isMobile,
                        visible: _visible,
                      ),
                    ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: experience.awards
                      .map((a) => _AwardBadge(a))
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightRow extends StatelessWidget {
  final String text;
  final int index;
  final bool isMobile;
  final bool visible;

  const _HighlightRow({
    required this.text,
    required this.index,
    required this.isMobile,
    required this.visible,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.only(top: 7, right: 12),
            decoration: const BoxDecoration(
              color: AppTheme.primaryColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isMobile ? 13 : 14,
                color: Colors.white60,
                height: 1.6,
              ),
            ),
          ),
        ],
      )
          .animate(target: visible ? 1 : 0)
          .fadeIn(
              delay: Duration(milliseconds: 60 * index), duration: 500.ms)
          .slideX(begin: -0.05),
    );
  }
}

class _TcsBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'TCS - Tata Consultancy Services',
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppTheme.primaryColor.withValues(alpha: 0.15),
          border:
              Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
        ),
        child: const Center(
          child: Text(
            'TCS',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.primaryColor,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

class _RoleInfo extends StatelessWidget {
  final bool isMobile;
  final ExperienceModel exp;

  const _RoleInfo({required this.isMobile, required this.exp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exp.role,
          style: TextStyle(
            fontSize: isMobile ? 16 : 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${exp.company}  ·  ${exp.location}',
          style: const TextStyle(fontSize: 13, color: Colors.white38),
        ),
      ],
    );
  }
}

class _DateBadge extends StatelessWidget {
  final String text;
  const _DateBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.secondaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: AppTheme.secondaryColor.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          color: AppTheme.secondaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _AwardBadge extends StatelessWidget {
  final String text;
  const _AwardBadge(this.text);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Award: $text',
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFFFD700).withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(6),
          border:
              Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.2)),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFFFD700),
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
