import 'package:flutter/material.dart';
import '../state/scroll_state.dart';
import '../widgets/content_layer.dart';
import '../widgets/shared/particle_background.dart';
import '../widgets/shared/spotlight_overlay.dart';
import '../widgets/shared/scroll_to_top.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final _scrollController = ScrollController();
  final _scrollState      = PortfolioScrollState();

  final _heroKey       = GlobalKey();
  final _workKey       = GlobalKey();
  final _skillsKey     = GlobalKey();
  final _experienceKey = GlobalKey();
  final _contactKey    = GlobalKey();

  Offset _cursorPosition = Offset.zero;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollState.updateOffset(_scrollController.offset);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollState.dispose();
    super.dispose();
  }

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MouseRegion(
        onHover: (e) => setState(() => _cursorPosition = e.position),
        child: Stack(
          children: [
            // Animated particle canvas — isolated in its own repaint boundary
            RepaintBoundary(
              child: const ParticleBackground(),
            ),

            // Subtle spotlight that follows the cursor
            SpotlightOverlay(position: _cursorPosition),

            // Main scrollable content — only rebuilds when scroll state changes
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

            // Floating scroll-to-top button
            ScrollToTopButton(scrollController: _scrollController),
          ],
        ),
      ),
    );
  }
}
