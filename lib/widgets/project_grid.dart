import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../data/models.dart';
import '../data/portfolio_data.dart';

class ProjectGrid extends StatelessWidget {
  final bool isMobile;
  final bool isTablet;
  final bool isDesktop;

  const ProjectGrid({
    super.key,
    required this.isMobile,
    required this.isTablet,
    required this.isDesktop,
  });

  @override
  Widget build(BuildContext context) {
    final columns = isMobile ? 1 : 2;
    final aspectRatio = isMobile ? 1.5 : isTablet ? 1.75 : 2.0;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: isMobile ? 16 : 20,
        mainAxisSpacing: isMobile ? 16 : 20,
        childAspectRatio: aspectRatio,
      ),
      itemCount: projects.length,
      itemBuilder: (_, i) =>
          ProjectCard(data: projects[i], index: i, isMobile: isMobile),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel data;
  final int index;
  final bool isMobile;

  const ProjectCard({
    super.key,
    required this.data,
    required this.index,
    required this.isMobile,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered = false;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final padding = widget.isMobile ? 20.0 : 26.0;
    final titleSize = widget.isMobile ? 16.0 : 18.0;
    final accent = widget.data.accentColor;

    return VisibilityDetector(
      key: Key('project-${widget.index}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.25 && !_visible) {
          Future.delayed(Duration(milliseconds: 80 * widget.index), () {
            if (mounted) setState(() => _visible = true);
          });
        }
      },
      child: Semantics(
        label: '${widget.data.title}: ${widget.data.subtitle}',
        child: AnimatedOpacity(
          duration: 600.ms,
          opacity: _visible ? 1.0 : 0.0,
          child: AnimatedSlide(
            duration: 600.ms,
            offset: _visible ? Offset.zero : const Offset(0, 0.12),
            child: MouseRegion(
              onEnter: (_) => setState(() => _hovered = true),
              onExit: (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: 250.ms,
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered
                        ? accent.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.06),
                    width: _hovered ? 1.5 : 1,
                  ),
                  color: _hovered
                      ? accent.withValues(alpha: 0.06)
                      : Colors.white.withValues(alpha: 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tag row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            widget.data.tag,
                            style: TextStyle(
                              fontSize: widget.isMobile ? 10 : 11,
                              letterSpacing: 1.8,
                              color: accent,
                            ),
                          ),
                        ),
                        AnimatedOpacity(
                          duration: 200.ms,
                          opacity: _hovered ? 1.0 : 0.0,
                          child: Icon(Icons.arrow_outward, color: accent, size: 16),
                        ),
                      ],
                    ),

                    // Title + description
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.title,
                          style: TextStyle(
                            fontSize: titleSize,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: widget.isMobile ? 6 : 8),
                        Text(
                          widget.data.subtitle,
                          style: TextStyle(
                            fontSize: widget.isMobile ? 12 : 13,
                            color: Colors.white38,
                            height: 1.6,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),

                    // Tech chips + metric badge
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.data.techChips.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: widget.data.techChips
                                .map(
                                  (chip) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 2),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.05),
                                      borderRadius: BorderRadius.circular(4),
                                      border: Border.all(
                                        color: Colors.white
                                            .withValues(alpha: 0.08),
                                      ),
                                    ),
                                    child: Text(
                                      chip,
                                      style: TextStyle(
                                        fontSize: widget.isMobile ? 9 : 10,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: accent.withValues(alpha: 0.25),
                            ),
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: widget.data.metric,
                                  style: TextStyle(
                                    fontSize: widget.isMobile ? 12 : 13,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                    color: accent,
                                    fontFamily: 'Courier New',
                                  ),
                                ),
                                TextSpan(
                                  text: '  ${widget.data.metricLabel}',
                                  style: TextStyle(
                                    fontSize: widget.isMobile ? 10 : 11,
                                    color: accent.withValues(alpha: 0.7),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
