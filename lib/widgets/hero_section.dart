import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../data/portfolio_data.dart';
import 'shared/buttons.dart';

class HeroSection extends StatefulWidget {
  final bool isMobile;
  final bool isTablet;
  const HeroSection({super.key, required this.isMobile, required this.isTablet});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _roleIndex = 0;
  String _displayedRole = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    final target = roles[_roleIndex];
    int charIndex = 0;

    _timer = Timer.periodic(const Duration(milliseconds: 70), (t) {
      if (!mounted) { t.cancel(); return; }
      if (charIndex <= target.length) {
        setState(() => _displayedRole = target.substring(0, charIndex++));
      } else {
        t.cancel();
        Future.delayed(const Duration(milliseconds: 1200), _startErasing);
      }
    });
  }

  void _startErasing() {
    final target = roles[_roleIndex];
    int charIndex = target.length;

    _timer = Timer.periodic(const Duration(milliseconds: 45), (t) {
      if (!mounted) { t.cancel(); return; }
      if (charIndex >= 0) {
        setState(() => _displayedRole = target.substring(0, charIndex--));
      } else {
        t.cancel();
        setState(() => _roleIndex = (_roleIndex + 1) % roles.length);
        Future.delayed(const Duration(milliseconds: 300), _startTyping);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleFontSize =
        widget.isMobile ? 40.0 : widget.isTablet ? 48.0 : 56.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // "Available for Work" status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppTheme.secondaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PulsingDot(color: AppTheme.secondaryColor),
              const SizedBox(width: 7),
              Text(
                'AVAILABLE FOR WORK',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.secondaryColor,
                      fontSize: widget.isMobile ? 10 : 12,
                    ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),

        SizedBox(height: widget.isMobile ? 20 : 28),

        // Name with gradient
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [
              Color(0xFFA78BFA),
              Color(0xFF6C63FF),
              Color(0xFF00D4AA),
            ],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            widget.isMobile ? 'SUJEET\nKUMAR' : 'SUJEET KUMAR',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: titleFontSize,
                ),
          ),
        ),

        SizedBox(height: widget.isMobile ? 12 : 16),

        // Typewriter role
        Row(
          children: [
            Text(
              _displayedRole,
              style: TextStyle(
                fontFamily: 'Courier New',
                fontSize: widget.isMobile ? 16 : 20,
                color: AppTheme.primaryColor.withValues(alpha: 0.9),
                letterSpacing: 1,
              ),
            ),
            BlinkingCursor(color: AppTheme.primaryColor),
          ],
        ).animate().fadeIn(delay: 350.ms),

        SizedBox(height: widget.isMobile ? 18 : 22),

        // Bio
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'Flutter Developer with 4+ years of experience building enterprise-grade '
            'cross-platform mobile applications for Android and iOS at TCS. '
            'Delivering production-ready solutions integrating AI/ML, IoT hardware, '
            'real-time analytics, and native platform capabilities.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white54,
                  fontSize: widget.isMobile ? 14 : 15,
                ),
          ),
        ).animate().fadeIn(delay: 500.ms),

        SizedBox(height: widget.isMobile ? 12 : 16),

        // Location / company
        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 14, color: Colors.white30),
            const SizedBox(width: 4),
            Text(
              'Bangalore, Karnataka  ·  Tata Consultancy Services',
              style: TextStyle(
                fontSize: widget.isMobile ? 12 : 13,
                color: Colors.white30,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ).animate().fadeIn(delay: 550.ms),

        SizedBox(height: widget.isMobile ? 32 : 40),

        // CTA buttons
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            CTAButton(
              label: 'Get in touch',
              onTap: () =>
                  launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com')),
            ),
            OutlineButton(
              label: 'GitHub',
              icon: Icons.code,
              onTap: () => launchUrl(Uri.parse('https://github.com/gitSujeet')),
            ),
            OutlineButton(
              label: 'LinkedIn',
              icon: Icons.link,
              onTap: () => launchUrl(
                Uri.parse('https://www.linkedin.com/in/sujeet-kumar-ind/'),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
      ],
    );
  }
}
