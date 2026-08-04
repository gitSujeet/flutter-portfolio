import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../main.dart';
import '../state/scroll_state.dart';
import 'nav_bar.dart';
import 'hero_section.dart';
import 'stats_row.dart';
import 'project_grid.dart';
import 'experience_section.dart';
import 'skills_section.dart';
import 'contact_section.dart';
import 'shared/buttons.dart';

class ContentLayer extends StatelessWidget {
  final ScrollController scrollController;
  final PortfolioScrollState scrollState;
  final GlobalKey heroKey;
  final GlobalKey workKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;
  final Function(GlobalKey) onNavigate;

  const ContentLayer({
    super.key,
    required this.scrollController,
    required this.scrollState,
    required this.heroKey,
    required this.workKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.contactKey,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isMobile  = w < AppTheme.mobileBreakpoint;
    final isTablet  = w >= AppTheme.mobileBreakpoint && w < AppTheme.tabletBreakpoint;
    final isDesktop = w >= AppTheme.tabletBreakpoint;
    final hPad      = isMobile ? AppTheme.md : isTablet ? AppTheme.xl : 80.0;
    final vGap      = isMobile ? AppTheme.xxl : AppTheme.xxxl;

    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.fromLTRB(hPad, 60, hPad, 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Navigation ──────────────────────────────────────────────
              NavBar(
                isDesktop: isDesktop,
                isMobile: isMobile,
                scrollState: scrollState,
                onNavigate: onNavigate,
                workKey: workKey,
                skillsKey: skillsKey,
                experienceKey: experienceKey,
                contactKey: contactKey,
              ),

              SizedBox(height: isMobile ? 60 : 100),

              // ── Hero ─────────────────────────────────────────────────────
              Container(key: heroKey),
              HeroSection(isMobile: isMobile, isTablet: isTablet),
              SizedBox(height: vGap),

              // ── Stats ────────────────────────────────────────────────────
              StatsRow(isMobile: isMobile),
              SizedBox(height: vGap),

              // ── Selected Work ────────────────────────────────────────────
              Container(key: workKey),
              _SectionLabel(
                text: 'SELECTED WORK',
                sectionId: 'work',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              ProjectGrid(
                isMobile: isMobile,
                isTablet: isTablet,
                isDesktop: isDesktop,
              ),
              SizedBox(height: vGap),

              // ── Experience ───────────────────────────────────────────────
              Container(key: experienceKey),
              _SectionLabel(
                text: 'EXPERIENCE',
                sectionId: 'experience',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              ExperienceSection(isMobile: isMobile),
              SizedBox(height: vGap),

              // ── Skills ───────────────────────────────────────────────────
              Container(key: skillsKey),
              _SectionLabel(
                text: 'SKILLS & STACK',
                sectionId: 'skills',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              SkillsSection(isMobile: isMobile),
              SizedBox(height: vGap),

              // ── Contact ──────────────────────────────────────────────────
              Container(key: contactKey),
              ContactSection(isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }
}

/// Section heading row: "── LABEL"
/// Updates scroll state when the label scrolls into view.
class _SectionLabel extends StatelessWidget {
  final String text;
  final String sectionId;
  final PortfolioScrollState scrollState;

  const _SectionLabel({
    required this.text,
    required this.sectionId,
    required this.scrollState,
  });

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('section-$sectionId'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          scrollState.updateSection(sectionId);
        }
      },
      child: SectionLabel(
        text: text,
        sectionId: sectionId,
        scrollState: scrollState,
      ),
    );
  }
}
