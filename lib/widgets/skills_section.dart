import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../main.dart';
import '../data/portfolio_data.dart';

class SkillsSection extends StatefulWidget {
  final bool isMobile;
  const SkillsSection({super.key, required this.isMobile});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final entries = skillGroups.entries.toList();

    return VisibilityDetector(
      key: const Key('skills-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: Wrap(
        spacing: widget.isMobile ? 24 : 40,
        runSpacing: widget.isMobile ? 28 : 36,
        children: entries.asMap().entries.map((mapEntry) {
          final idx = mapEntry.key;
          final entry = mapEntry.value;
          return AnimatedOpacity(
            duration: 600.ms,
            opacity: _visible ? 1 : 0,
            child: AnimatedSlide(
              duration: Duration(milliseconds: 500 + idx * 60),
              offset: _visible ? Offset.zero : const Offset(0, 0.15),
              child: SizedBox(
                width: widget.isMobile ? double.infinity : 210,
                child: _SkillGroup(
                  category: entry.key,
                  skills: entry.value,
                  isMobile: widget.isMobile,
                  animate: _visible,
                  groupIndex: idx,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _SkillGroup extends StatelessWidget {
  final String category;
  final List<String> skills;
  final bool isMobile;
  final bool animate;
  final int groupIndex;

  const _SkillGroup({
    required this.category,
    required this.skills,
    required this.isMobile,
    required this.animate,
    required this.groupIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.toUpperCase(),
          style: TextStyle(
            fontSize: isMobile ? 10 : 11,
            letterSpacing: 2.5,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 14),
        ...skills.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        e.value,
                        style: TextStyle(
                          fontSize: isMobile ? 13 : 14,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                )
                    .animate(target: animate ? 1 : 0)
                    .fadeIn(
                      delay: Duration(milliseconds: 40 * e.key),
                      duration: 400.ms,
                    ),
              ),
            ),
      ],
    );
  }
}
