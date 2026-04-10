import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const PortfolioApp());
}

// ═══════════════════════════════════════════════════════════════════════════
// THEME & CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

class AppTheme {
  static const primaryColor   = Color(0xFF6C63FF);
  static const secondaryColor = Color(0xFF00D4AA);
  static const accentColor    = Color(0xFFFF6B6B);
  static const bgColor        = Color(0xFF0A0A0F);
  static const cardColor      = Color(0xFF1A1A2E);
  static const surfaceColor   = Color(0xFF12121C);

  static const double mobileBreakpoint  = 600.0;
  static const double tabletBreakpoint  = 900.0;
  static const double desktopBreakpoint = 1200.0;

  static const double xs   = 8.0;
  static const double sm   = 16.0;
  static const double md   = 24.0;
  static const double lg   = 32.0;
  static const double xl   = 48.0;
  static const double xxl  = 64.0;
  static const double xxxl = 100.0;
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA MODELS
// ═══════════════════════════════════════════════════════════════════════════

class ProjectModel {
  final String title;
  final String subtitle;
  final String tag;
  final String metric;
  final String metricLabel;
  final Color accentColor;
  final List<String> techChips;

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.metric,
    required this.metricLabel,
    this.accentColor = AppTheme.secondaryColor,
    this.techChips = const [],
  });
}

class ExperienceModel {
  final String role;
  final String company;
  final String location;
  final String duration;
  final List<String> highlights;
  final List<String> awards;

  const ExperienceModel({
    required this.role,
    required this.company,
    required this.location,
    required this.duration,
    required this.highlights,
    required this.awards,
  });
}

// ═══════════════════════════════════════════════════════════════════════════
// DATA
// ═══════════════════════════════════════════════════════════════════════════

const _projects = [
  ProjectModel(
    title: 'Telecom Self-Service App',
    subtitle:
    'Migrated a leading UK telecom provider\'s native Android & iOS codebase to a unified Flutter app with Speed Test modules, GA4 analytics, and BLoC clean architecture.',
    tag: 'Flutter · BLoC · GA4',
    metric: '1M+',
    metricLabel: 'Active Users',
    accentColor: AppTheme.secondaryColor,
    techChips: ['Flutter', 'Dart', 'BLoC', 'Firebase', 'GA4'],
  ),
  ProjectModel(
    title: 'AI Healthcare Monitor',
    subtitle:
    'Post-surgery health monitoring with on-device TFLite inference, wearable vitals sync via Health Connect, Azure sentiment analysis, and OpenEMR / FHIR integration.',
    tag: 'TFLite · Azure AI · FHIR',
    metric: '~40%',
    metricLabel: 'Faster Launch',
    accentColor: AppTheme.primaryColor,
    techChips: ['TFLite', 'Azure AI', 'GetX', 'FHIR', 'Health Connect'],
  ),
  ProjectModel(
    title: 'Portable ECG Monitor',
    subtitle:
    'Real-time ECG signal acquisition over USB using FTDI D2XX drivers, with cloud REST API sync for arrhythmia detection and RBAC-based user role management.',
    tag: 'Android · Java · USB · FTDI',
    metric: '1ms',
    metricLabel: 'Stream Latency',
    accentColor: AppTheme.accentColor,
    techChips: ['Android', 'Java', 'USB FTDI', 'REST API', 'RBAC'],
  ),
  ProjectModel(
    title: 'BLE & NFC SDK',
    subtitle:
    'Modular internal library for BLE device discovery, GATT operations, and NFC/NDEF parsing — built with Kotlin Coroutines and clean architecture for plug-and-play reuse.',
    tag: 'Kotlin · BLE · NFC · Coroutines',
    metric: '30–40%',
    metricLabel: 'Faster Onboarding',
    accentColor: AppTheme.secondaryColor,
    techChips: ['Kotlin', 'BLE/GATT', 'NFC', 'Coroutines'],
  ),
  ProjectModel(
    title: 'On-Device Sentiment AI',
    subtitle:
    'Reusable Flutter template running MobileBERT via TFLite for multi-class sentiment classification with a custom Dart WordPiece tokenizer — no cloud required.',
    tag: 'Flutter · TFLite · MobileBERT',
    metric: '94%',
    metricLabel: 'Model Accuracy',
    accentColor: AppTheme.primaryColor,
    techChips: ['Flutter', 'TFLite', 'MobileBERT', 'Dart NLP'],
  ),
  ProjectModel(
    title: 'MQTT Secure Comm App',
    subtitle:
    'Client POC demonstrating real-time secure device messaging over MQTT with SSL/TLS via OpenSSL, Mosquitto ACL, and per-device client ID topic segregation.',
    tag: 'Kotlin · MQTT · SSL/TLS',
    metric: '100%',
    metricLabel: 'Client Approved',
    accentColor: AppTheme.accentColor,
    techChips: ['Kotlin', 'MQTT', 'OpenSSL', 'Mosquitto'],
  ),
];

const _experience = ExperienceModel(
  role: 'Android / Flutter Developer',
  company: 'Tata Consultancy Services',
  location: 'Bangalore, India',
  duration: 'May 2022 – Present',
  highlights: [
    'Migrated a major UK telecom provider\'s native Android & iOS app to Flutter, improving dev speed and cross-platform UI consistency.',
    'Integrated Google Analytics 4 (GA4) via Firebase Analytics with custom user journey events, screen views, and CTA tracking.',
    'Built an AI-powered post-surgery health monitoring app using TFLite, Azure Cognitive Services, Health Connect, and FHIR APIs.',
    'Developed reusable BLE + NFC internal libraries, reducing new project onboarding time by 30–40%.',
    'Implemented real-time ECG signal acquisition via USB FTDI D2XX drivers with cloud sync for arrhythmia detection.',
    'Improved app launch time by ~40% through async loading and Nginx reverse proxy optimisation.',
    'Conducted performance and load testing using BlazeMeter to ensure reliability under high user activity.',
  ],
  awards: [
    '🏆  TCS Award — Outstanding Technical Contribution',
    '🏆  TCS Award — Innovation & Problem Solving',
  ],
);

const _skillGroups = {
  'Mobile': ['Flutter & Dart', 'Android (Kotlin / Java)', 'iOS (Swift)', 'Method Channels', 'BLoC / GetX', 'Clean Architecture'],
  'AI / ML': ['TensorFlow Lite', 'MobileBERT', 'Azure Cognitive Services', 'Google Gemini AI', 'Azure Sentiment API', 'On-Device Inference'],
  'IoT & Hardware': ['Bluetooth BLE / GATT', 'NFC / NDEF', 'USB (FTDI D2XX)', 'MQTT', 'Health Connect API', 'ESP32'],
  'Backend & Cloud': ['Firebase / GA4', 'Azure', 'REST APIs', 'OpenEMR / FHIR', 'Nginx', 'Docker', 'SQLite'],
  'Security': ['SSL / TLS', 'OpenSSL', 'RBAC', 'Mosquitto ACL'],
  'Tools & DevOps': ['Git / GitHub / SVN', 'Android Studio / VS Code', 'Postman / Swagger', 'BlazeMeter', 'Amazon Q Developer'],
};

const _roles = [
  'Flutter Engineer',
  'Android Developer',
  'iOS Developer',
  'AI / ML Integrator',
  'IoT & BLE Developer',
];

// ═══════════════════════════════════════════════════════════════════════════
// SCROLL STATE NOTIFIER  (replaces scattered setState calls)
// ═══════════════════════════════════════════════════════════════════════════

class PortfolioScrollState extends ChangeNotifier {
  String _activeSection = 'hero';
  double _scrollOffset = 0;

  String get activeSection => _activeSection;
  double get scrollOffset => _scrollOffset;

  void updateSection(String section) {
    if (_activeSection != section) {
      _activeSection = section;
      notifyListeners();
    }
  }

  void updateOffset(double offset) {
    _scrollOffset = offset;
    notifyListeners();
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// APP ROOT
// ═══════════════════════════════════════════════════════════════════════════

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sujeet Kumar — Flutter & Mobile Engineer',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppTheme.bgColor,
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.secondaryColor,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Courier New', fontSize: 56, fontWeight: FontWeight.w700, letterSpacing: -1.5, height: 1.1),
          displayMedium: TextStyle(fontFamily: 'Courier New', fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -1.0, height: 1.2),
          titleMedium: TextStyle(fontSize: 13, letterSpacing: 3, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 15, height: 1.7),
        ),
      ),
      home: const PortfolioPage(),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// ROOT PAGE
// ═══════════════════════════════════════════════════════════════════════════

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _scrollState = PortfolioScrollState();

  final _heroKey       = GlobalKey();
  final _workKey       = GlobalKey();
  final _skillsKey     = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey    = GlobalKey();

  // Global mouse position for spotlight cursor effect
  Offset _cursorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollState.updateOffset(_scrollController.offset);
    });
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (e) => setState(() => _cursorPosition = e.position),
        child: Stack(
          children: [
            // Particle background in its own RepaintBoundary
            RepaintBoundary(child: const ParticleBackground()),

            // Cursor spotlight overlay
            _SpotlightOverlay(position: _cursorPosition),

            // Main scrollable content
            ListenableBuilder(
              listenable: _scrollState,
              builder: (context, _) => ContentLayer(
                scrollController: _scrollController,
                scrollState: _scrollState,
                heroKey: _heroKey,
                workKey: _workKey,
                skillsKey: _skillsKey,
                experienceKey: _experienceKey,
                contactKey: _contactKey,
                onNavigate: _scrollTo,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SPOTLIGHT CURSOR OVERLAY
// ═══════════════════════════════════════════════════════════════════════════

class _SpotlightOverlay extends StatelessWidget {
  final Offset position;
  const _SpotlightOverlay({required this.position});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: _SpotlightPainter(position),
        ),
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

// ═══════════════════════════════════════════════════════════════════════════
// PARTICLE BACKGROUND  (optimised: spatial partitioning, Float64List cache)
// ═══════════════════════════════════════════════════════════════════════════

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({super.key});

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final w = MediaQuery.of(context).size.width;
    final count = w < AppTheme.mobileBreakpoint ? 25 : 50;
    final rng = Random();
    _particles = List.generate(count, (_) => _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      speed: 0.02 + rng.nextDouble() * 0.05,
      size: 1.0 + rng.nextDouble() * 2.0,
    ));
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
  const _Particle({required this.x, required this.y, required this.speed, required this.size});
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;

  _ParticlePainter(this.particles, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    // Pre-compute positions (avoid redundant math)
    final positions = particles.map((p) => Offset(
      ((p.x + progress * p.speed) % 1.0) * size.width,
      ((p.y + progress * p.speed * 0.5) % 1.0) * size.height,
    )).toList(growable: false);

    // Only draw connections within a threshold bucket
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

    final dotPaint = Paint()..color = AppTheme.primaryColor.withValues(alpha: 0.3);
    for (int i = 0; i < positions.length; i++) {
      canvas.drawCircle(positions[i], particles[i].size, dotPaint);
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => old.progress != progress;
}

// ═══════════════════════════════════════════════════════════════════════════
// CONTENT LAYER
// ═══════════════════════════════════════════════════════════════════════════

class ContentLayer extends StatelessWidget {
  final ScrollController scrollController;
  final PortfolioScrollState scrollState;
  final GlobalKey heroKey, workKey, skillsKey, experienceKey, contactKey;
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
              Container(key: heroKey),
              HeroSection(isMobile: isMobile, isTablet: isTablet),
              SizedBox(height: vGap),
              StatsRow(isMobile: isMobile),
              SizedBox(height: vGap),
              Container(key: workKey),
              _SectionLabel(
                text: 'SELECTED WORK',
                sectionId: 'work',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              ProjectGrid(isMobile: isMobile, isTablet: isTablet, isDesktop: isDesktop),
              SizedBox(height: vGap),
              Container(key: experienceKey),
              _SectionLabel(
                text: 'EXPERIENCE',
                sectionId: 'experience',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              ExperienceSection(isMobile: isMobile),
              SizedBox(height: vGap),
              Container(key: skillsKey),
              _SectionLabel(
                text: 'SKILLS & STACK',
                sectionId: 'skills',
                scrollState: scrollState,
              ),
              const SizedBox(height: AppTheme.lg),
              SkillsSection(isMobile: isMobile),
              SizedBox(height: vGap),
              Container(key: contactKey),
              ContactSection(isMobile: isMobile),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// NAVIGATION BAR  (with active-section highlight)
// ═══════════════════════════════════════════════════════════════════════════

class NavBar extends StatelessWidget {
  final bool isDesktop, isMobile;
  final PortfolioScrollState scrollState;
  final Function(GlobalKey) onNavigate;
  final GlobalKey workKey, skillsKey, experienceKey, contactKey;

  const NavBar({
    super.key,
    required this.isDesktop,
    required this.isMobile,
    required this.scrollState,
    required this.onNavigate,
    required this.workKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.contactKey,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SK.',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 28, color: AppTheme.primaryColor)),
              Text('Flutter & Mobile Engineer',
                  style: TextStyle(fontSize: isMobile ? 9 : 10, letterSpacing: 2, color: Colors.white30)),
            ],
          ),
          if (isDesktop)
            Row(
              children: [
                _NavLink('Work',       'work',       () => onNavigate(workKey),       scrollState),
                const SizedBox(width: 32),
                _NavLink('Experience', 'experience', () => onNavigate(experienceKey), scrollState),
                const SizedBox(width: 32),
                _NavLink('Skills',     'skills',     () => onNavigate(skillsKey),     scrollState),
                const SizedBox(width: 32),
                _NavLink('Contact',    'contact',    () => onNavigate(contactKey),    scrollState),
                const SizedBox(width: 32),
                _CTAButton(label: 'Hire Me',
                    onTap: () => launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com'))),
              ],
            )
          else
            Semantics(
              button: true,
              label: 'Open navigation menu',
              child: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => _showMobileMenu(context),
              ),
            ),
        ],
      ).animate().fadeIn(duration: 600.ms),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardColor,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(width: 40, height: 4, margin: const EdgeInsets.only(bottom: AppTheme.md),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2))),
              _MobileNavItem('Work',       () { Navigator.pop(context); onNavigate(workKey);       }),
              _MobileNavItem('Experience', () { Navigator.pop(context); onNavigate(experienceKey); }),
              _MobileNavItem('Skills',     () { Navigator.pop(context); onNavigate(skillsKey);     }),
              _MobileNavItem('Contact',    () { Navigator.pop(context); onNavigate(contactKey);    }),
              const SizedBox(height: AppTheme.sm),
              SizedBox(width: double.infinity,
                  child: _CTAButton(label: 'Hire Me',
                      onTap: () { Navigator.pop(context); launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com')); })),
            ],
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _MobileNavItem(this.label, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Navigate to $label section',
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: AppTheme.sm),
          child: Text(label, style: const TextStyle(fontSize: 16, letterSpacing: 2, color: Colors.white)),
        ),
      ),
    );
  }
}

// Nav link with active-section highlight
class _NavLink extends StatefulWidget {
  final String label;
  final String sectionId;
  final VoidCallback onTap;
  final PortfolioScrollState scrollState;

  const _NavLink(this.label, this.sectionId, this.onTap, this.scrollState);

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.scrollState.activeSection == widget.sectionId;
    return Semantics(
      button: true,
      label: 'Navigate to ${widget.label}',
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: 200.ms,
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 2,
              color: (_hovered || isActive)
                  ? AppTheme.primaryColor
                  : Colors.white54,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(widget.label),
                AnimatedContainer(
                  duration: 200.ms,
                  height: 1.5,
                  width: isActive ? 20 : 0,
                  margin: const EdgeInsets.only(top: 3),
                  color: AppTheme.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// HERO SECTION  (typewriter role animation)
// ═══════════════════════════════════════════════════════════════════════════

class HeroSection extends StatefulWidget {
  final bool isMobile, isTablet;
  const HeroSection({super.key, required this.isMobile, required this.isTablet});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  int _roleIndex = 0;
  String _displayedRole = '';
  bool _typing = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    final target = _roles[_roleIndex];
    int charIndex = 0;
    _typing = true;

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
    final target = _roles[_roleIndex];
    int charIndex = target.length;

    _timer = Timer.periodic(const Duration(milliseconds: 45), (t) {
      if (!mounted) { t.cancel(); return; }
      if (charIndex >= 0) {
        setState(() => _displayedRole = target.substring(0, charIndex--));
      } else {
        t.cancel();
        setState(() {
          _roleIndex = (_roleIndex + 1) % _roles.length;
        });
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
    final titleFontSize = widget.isMobile ? 40.0 : widget.isTablet ? 48.0 : 56.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppTheme.secondaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppTheme.secondaryColor.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PulsingDot(color: AppTheme.secondaryColor),
              const SizedBox(width: 7),
              Text('AVAILABLE FOR WORK',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.secondaryColor,
                    fontSize: widget.isMobile ? 10 : 12,
                  )),
            ],
          ),
        ).animate().fadeIn(delay: 100.ms).slideX(begin: -0.1),

        SizedBox(height: widget.isMobile ? 20 : 28),

        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFFA78BFA), Color(0xFF6C63FF), Color(0xFF00D4AA)],
            stops: [0.0, 0.5, 1.0],
          ).createShader(bounds),
          child: Text(
            widget.isMobile ? 'SUJEET\nKUMAR' : 'SUJEET KUMAR',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: titleFontSize),
          ),
        ),
        SizedBox(height: widget.isMobile ? 12 : 16),

        // Animated typewriter role
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
            _BlinkingCursor(color: AppTheme.primaryColor),
          ],
        ).animate().fadeIn(delay: 350.ms),

        SizedBox(height: widget.isMobile ? 18 : 22),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'Flutter Developer with 3.5+ years of experience building high-quality '
                'cross-platform mobile applications at TCS. Delivering production-ready '
                'solutions integrating AI/ML, IoT hardware, real-time cloud APIs, and '
                'native platform capabilities across Android & iOS.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white54,
              fontSize: widget.isMobile ? 14 : 15,
            ),
          ),
        ).animate().fadeIn(delay: 500.ms),

        SizedBox(height: widget.isMobile ? 12 : 16),

        Row(
          children: [
            const Icon(Icons.location_on_outlined, size: 14, color: Colors.white30),
            const SizedBox(width: 4),
            Text('Bangalore, Karnataka  ·  Tata Consultancy Services',
                style: TextStyle(fontSize: widget.isMobile ? 12 : 13, color: Colors.white30, letterSpacing: 0.5)),
          ],
        ).animate().fadeIn(delay: 550.ms),

        SizedBox(height: widget.isMobile ? 32 : 40),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            _CTAButton(label: 'Get in touch',
                onTap: () => launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com'))),
            _OutlineButton(label: 'GitHub', icon: Icons.code,
                onTap: () => launchUrl(Uri.parse('https://github.com/gitSujeet'))),
            _OutlineButton(label: 'LinkedIn', icon: Icons.link,
                onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/sujeet-kumar-ind/'))),
          ],
        ).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1),
      ],
    );
  }
}

// Blinking cursor widget
class _BlinkingCursor extends StatefulWidget {
  final Color color;
  const _BlinkingCursor({required this.color});

  @override
  State<_BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<_BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 530))..repeat(reverse: true);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Opacity(
        opacity: _ctrl.value > 0.5 ? 1.0 : 0.0,
        child: Container(
          width: 2,
          height: 20,
          margin: const EdgeInsets.only(left: 3, top: 2),
          color: widget.color,
        ),
      ),
    );
  }
}

// Pulsing dot for status badge
class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: 7, height: 7,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(
            color: widget.color.withValues(alpha: _anim.value * 0.8),
            blurRadius: 6 + _anim.value * 6,
          )],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// STATS ROW  (animated count-up on visibility)
// ═══════════════════════════════════════════════════════════════════════════

class StatsRow extends StatefulWidget {
  final bool isMobile;
  const StatsRow({super.key, required this.isMobile});

  @override
  State<StatsRow> createState() => _StatsRowState();
}

class _StatsRowState extends State<StatsRow> {
  bool _visible = false;

  static const _stats = [
    ('3.5+', 'Years Experience'),
    ('1M+',  'App Users'),
    ('10+',  'Projects Delivered'),
    ('2×',   'TCS Award Winner'),
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
                horizontal: widget.isMobile ? 20 : 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              color: Colors.white.withValues(alpha: 0.02),
            ),
            child: widget.isMobile
                ? Wrap(spacing: 24, runSpacing: 20,
                children: _stats.map((s) => _StatItem(value: s.$1, label: s.$2, isMobile: widget.isMobile, animate: _visible)).toList())
                : Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _stats.map((s) => _StatItem(value: s.$1, label: s.$2, isMobile: widget.isMobile, animate: _visible)).toList()),
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  final bool isMobile, animate;
  const _StatItem({required this.value, required this.label, required this.isMobile, required this.animate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
          style: TextStyle(
            fontFamily: 'Courier New',
            fontSize: isMobile ? 28 : 36,
            fontWeight: FontWeight.w700,
            color: AppTheme.primaryColor,
            height: 1,
          ),
        ).animate(target: animate ? 1 : 0).fadeIn(duration: 600.ms).slideY(begin: 0.3),
        const SizedBox(height: 4),
        Text(label,
            style: TextStyle(fontSize: isMobile ? 11 : 12, letterSpacing: 1.5, color: Colors.white38)),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SECTION LABEL  (updates scroll state when visible)
// ═══════════════════════════════════════════════════════════════════════════

class _SectionLabel extends StatelessWidget {
  final String text, sectionId;
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
      child: Row(
        children: [
          Container(width: 24, height: 1, color: AppTheme.primaryColor),
          const SizedBox(width: 12),
          Text(text,
              style: const TextStyle(
                fontSize: 11, letterSpacing: 3.5,
                color: AppTheme.primaryColor, fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// PROJECT GRID  (scroll-triggered stagger reveal per card)
// ═══════════════════════════════════════════════════════════════════════════

class ProjectGrid extends StatelessWidget {
  final bool isMobile, isTablet, isDesktop;
  const ProjectGrid({super.key, required this.isMobile, required this.isTablet, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final columns     = isMobile ? 1 : 2;
    final aspectRatio = isMobile ? 1.6 : isTablet ? 1.85 : 2.1;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: isMobile ? 16 : 20,
        mainAxisSpacing: isMobile ? 16 : 20,
        childAspectRatio: aspectRatio,
      ),
      itemCount: _projects.length,
      itemBuilder: (_, i) => ProjectCard(data: _projects[i], index: i, isMobile: isMobile),
    );
  }
}

class ProjectCard extends StatefulWidget {
  final ProjectModel data;
  final int index;
  final bool isMobile;
  const ProjectCard({super.key, required this.data, required this.index, required this.isMobile});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _hovered  = false;
  bool _visible  = false;

  @override
  Widget build(BuildContext context) {
    final padding    = widget.isMobile ? 20.0 : 26.0;
    final titleSize  = widget.isMobile ? 16.0 : 18.0;
    final accent     = widget.data.accentColor;

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
              onExit:  (_) => setState(() => _hovered = false),
              child: AnimatedContainer(
                duration: 250.ms,
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _hovered ? accent.withValues(alpha: 0.5) : Colors.white.withValues(alpha: 0.06),
                    width: _hovered ? 1.5 : 1,
                  ),
                  color: _hovered ? accent.withValues(alpha: 0.06) : Colors.white.withValues(alpha: 0.02),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Tag row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(child: Text(widget.data.tag,
                            style: TextStyle(fontSize: widget.isMobile ? 10 : 11, letterSpacing: 1.8, color: accent))),
                        AnimatedOpacity(
                          duration: 200.ms,
                          opacity: _hovered ? 1.0 : 0.0,
                          child: Icon(Icons.arrow_outward, color: accent, size: 16),
                        ),
                      ],
                    ),

                    // Title + desc
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.data.title,
                            style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w600, letterSpacing: -0.3, color: Colors.white)),
                        SizedBox(height: widget.isMobile ? 6 : 8),
                        Text(widget.data.subtitle,
                            style: TextStyle(fontSize: widget.isMobile ? 12 : 13, color: Colors.white38, height: 1.6),
                            maxLines: 3, overflow: TextOverflow.ellipsis),
                      ],
                    ),

                    // Tech chips + metric
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.data.techChips.isNotEmpty)
                          Wrap(
                            spacing: 6,
                            runSpacing: 4,
                            children: widget.data.techChips.map((chip) => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                              ),
                              child: Text(chip, style: TextStyle(fontSize: widget.isMobile ? 9 : 10, color: Colors.white38)),
                            )).toList(),
                          ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: accent.withValues(alpha: 0.25)),
                          ),
                          child: RichText(text: TextSpan(children: [
                            TextSpan(
                              text: widget.data.metric,
                              style: TextStyle(fontSize: widget.isMobile ? 12 : 13, fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5, color: accent, fontFamily: 'Courier New'),
                            ),
                            TextSpan(
                              text: '  ${widget.data.metricLabel}',
                              style: TextStyle(fontSize: widget.isMobile ? 10 : 11, color: accent.withValues(alpha: 0.7), letterSpacing: 1),
                            ),
                          ])),
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

// ═══════════════════════════════════════════════════════════════════════════
// EXPERIENCE SECTION  (scroll-triggered reveal)
// ═══════════════════════════════════════════════════════════════════════════

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
              border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
              color: Colors.white.withValues(alpha: 0.02),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                widget.isMobile
                    ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _TcsBadge(),
                  const SizedBox(height: 14),
                  _RoleInfo(isMobile: widget.isMobile, exp: _experience),
                  const SizedBox(height: 10),
                  _DateBadge(text: _experience.duration),
                ])
                    : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _TcsBadge(),
                  const SizedBox(width: 16),
                  Expanded(child: _RoleInfo(isMobile: widget.isMobile, exp: _experience)),
                  _DateBadge(text: _experience.duration),
                ]),

                const SizedBox(height: 28),
                Container(height: 1, color: Colors.white.withValues(alpha: 0.05)),
                const SizedBox(height: 24),

                const Text('KEY HIGHLIGHTS',
                    style: TextStyle(fontSize: 10, letterSpacing: 3, color: Colors.white30)),
                const SizedBox(height: 16),

                ..._experience.highlights.asMap().entries.map((e) => _HighlightRow(
                  text: e.value,
                  index: e.key,
                  isMobile: widget.isMobile,
                  visible: _visible,
                )),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  children: _experience.awards.map((a) => _AwardBadge(a)).toList(),
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
  final bool isMobile, visible;
  const _HighlightRow({required this.text, required this.index, required this.isMobile, required this.visible});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 5, height: 5,
            margin: const EdgeInsets.only(top: 7, right: 12),
            decoration: const BoxDecoration(color: AppTheme.primaryColor, shape: BoxShape.circle),
          ),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: isMobile ? 13 : 14, color: Colors.white60, height: 1.6)),
          ),
        ],
      )
          .animate(target: visible ? 1 : 0)
          .fadeIn(delay: Duration(milliseconds: 60 * index), duration: 500.ms)
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
        width: 44, height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppTheme.primaryColor.withValues(alpha: 0.15),
          border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
        ),
        child: const Center(
          child: Text('TCS',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
                  color: AppTheme.primaryColor, letterSpacing: 1)),
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
        Text(exp.role,
            style: TextStyle(fontSize: isMobile ? 16 : 18, fontWeight: FontWeight.w600, color: Colors.white)),
        const SizedBox(height: 4),
        Text('${exp.company}  ·  ${exp.location}',
            style: const TextStyle(fontSize: 13, color: Colors.white38)),
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
        border: Border.all(color: AppTheme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Text(text,
          style: const TextStyle(fontSize: 11, color: AppTheme.secondaryColor, letterSpacing: 0.5)),
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
          border: Border.all(color: const Color(0xFFFFD700).withValues(alpha: 0.2)),
        ),
        child: Text(text,
            style: const TextStyle(fontSize: 12, color: Color(0xFFFFD700), letterSpacing: 0.3)),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SKILLS SECTION  (animated skill bars on scroll-entry)
// ═══════════════════════════════════════════════════════════════════════════

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
        children: _skillGroups.entries.toList().asMap().entries.map((mapEntry) {
          final idx   = mapEntry.key;
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
  final bool isMobile, animate;
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
        Text(category.toUpperCase(),
            style: TextStyle(
              fontSize: isMobile ? 10 : 11,
              letterSpacing: 2.5,
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 14),
        ...skills.asMap().entries.map((e) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4, height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Expanded(child: Text(e.value,
                      style: TextStyle(fontSize: isMobile ? 13 : 14, color: Colors.white70))),
                ],
              ),
            ],
          ).animate(target: animate ? 1 : 0)
              .fadeIn(delay: Duration(milliseconds: 40 * e.key), duration: 400.ms),
        )),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// CONTACT SECTION
// ═══════════════════════════════════════════════════════════════════════════

class ContactSection extends StatefulWidget {
  final bool isMobile;
  const ContactSection({super.key, required this.isMobile});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('contact-section'),
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
            padding: EdgeInsets.all(widget.isMobile ? 32 : 48),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.2)),
              color: AppTheme.primaryColor.withValues(alpha: 0.04),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(children: [
                  SizedBox(width: 24, child: Divider(color: AppTheme.primaryColor, thickness: 1)),
                  SizedBox(width: 12),
                  Text('GET IN TOUCH',
                      style: TextStyle(fontSize: 11, letterSpacing: 3.5,
                          color: AppTheme.primaryColor, fontWeight: FontWeight.w500)),
                ]),
                SizedBox(height: widget.isMobile ? 20 : 24),
                Text("Let's build\nsomething great.",
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: widget.isMobile ? 32 : 40, color: Colors.white)),
                SizedBox(height: widget.isMobile ? 12 : 16),
                Text('Open to full-time roles, freelance projects, and technical collaborations.',
                    style: TextStyle(fontSize: widget.isMobile ? 14 : 15, color: Colors.white54, height: 1.7)),
                SizedBox(height: widget.isMobile ? 20 : 24),

                // Contact details
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    _ContactDetail(icon: Icons.phone_outlined,
                        label: '+91-7209106002',
                        onTap: () => launchUrl(Uri.parse('tel:+917209106002'))),
                    _ContactDetail(icon: Icons.email_outlined,
                        label: 'sujeetkumarnmd@gmail.com',
                        onTap: () => launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com'))),
                  ],
                ),
                SizedBox(height: widget.isMobile ? 24 : 28),

                Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: [
                    _CTAButton(label: 'Send Email',
                        onTap: () => launchUrl(Uri.parse('mailto:sujeetkumarnmd@gmail.com'))),
                    _OutlineButton(label: 'GitHub', icon: Icons.code,
                        onTap: () => launchUrl(Uri.parse('https://github.com/gitSujeet'))),
                    _OutlineButton(label: 'LinkedIn', icon: Icons.link,
                        onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/sujeet-kumar-ind'))),
                    _OutlineButton(label: '+91-7209106002', icon: Icons.phone_outlined,
                        onTap: () => launchUrl(Uri.parse('tel:+917209106002'))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContactDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ContactDetail({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white30),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(fontSize: 13, color: Colors.white38, letterSpacing: 0.3)),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════════════════
// SHARED BUTTONS  (magnetic hover with Semantics)
// ═══════════════════════════════════════════════════════════════════════════

class _CTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _CTAButton({required this.label, required this.onTap});

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _hovered = false;
  Offset _magnetOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() { _hovered = false; _magnetOffset = Offset.zero; }),
        onHover: (e) {
          // Magnetic effect: shift toward cursor inside button
          final RenderBox? box = context.findRenderObject() as RenderBox?;
          if (box != null) {
            final local = box.globalToLocal(e.position);
            final center = Offset(box.size.width / 2, box.size.height / 2);
            setState(() => _magnetOffset = (local - center) * 0.15);
          }
        },
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: 180.ms,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            transform: Matrix4.translationValues(_magnetOffset.dx, _magnetOffset.dy, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _hovered ? const Color(0xFF8B85FF) : AppTheme.primaryColor,
              boxShadow: _hovered
                  ? [BoxShadow(color: AppTheme.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 16, offset: const Offset(0, 4))]
                  : null,
            ),
            child: Text(widget.label,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600,
                    letterSpacing: 0.5, color: Colors.white)),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  const _OutlineButton({required this.label, required this.onTap, this.icon});

  @override
  State<_OutlineButton> createState() => _OutlineButtonState();
}

class _OutlineButtonState extends State<_OutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit:  (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: 180.ms,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: _hovered ? Colors.white54 : Colors.white.withValues(alpha: 0.15)),
              color: _hovered ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: 14,
                      color: _hovered ? Colors.white : Colors.white54),
                  const SizedBox(width: 7),
                ],
                Text(widget.label,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,
                        letterSpacing: 0.5, color: _hovered ? Colors.white : Colors.white54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}