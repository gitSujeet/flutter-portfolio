import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../main.dart';

/// Floating scroll-to-top button that fades in after the user scrolls down.
class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  const ScrollToTopButton({super.key, required this.scrollController});

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset > 400;
    if (shouldShow != _visible) {
      setState(() => _visible = shouldShow);
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      right: 32,
      child: AnimatedOpacity(
        duration: 300.ms,
        opacity: _visible ? 1.0 : 0.0,
        child: AnimatedScale(
          duration: 300.ms,
          scale: _visible ? 1.0 : 0.6,
          child: Semantics(
            button: true,
            label: 'Scroll to top',
            child: Tooltip(
              message: 'Back to top',
              child: GestureDetector(
                onTap: _scrollToTop,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.primaryColor.withValues(alpha: 0.15),
                    border: Border.all(
                      color: AppTheme.primaryColor.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.2),
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_up_rounded,
                    color: AppTheme.primaryColor,
                    size: 22,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
