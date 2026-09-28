import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../main.dart';

/// Filled primary CTA button with a subtle magnetic hover effect.
class CTAButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const CTAButton({super.key, required this.label, required this.onTap});

  @override
  State<CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<CTAButton> {
  bool _hovered = false;
  Offset _magnetOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() {
          _hovered = false;
          _magnetOffset = Offset.zero;
        }),
        onHover: (e) {
          final box = context.findRenderObject() as RenderBox?;
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
            transform: Matrix4.translationValues(
              _magnetOffset.dx,
              _magnetOffset.dy,
              0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: _hovered
                  ? const Color(0xFF8B85FF)
                  : AppTheme.primaryColor,
              boxShadow: _hovered
                  ? [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.4),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Outlined secondary button with hover state.
class PortfolioOutlineButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  const PortfolioOutlineButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon,
  });

  @override
  State<PortfolioOutlineButton> createState() => _PortfolioOutlineButtonState();
}

class _PortfolioOutlineButtonState extends State<PortfolioOutlineButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: widget.label,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: 180.ms,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _hovered
                    ? Colors.white54
                    : Colors.white.withValues(alpha: 0.15),
              ),
              color: _hovered
                  ? Colors.white.withValues(alpha: 0.05)
                  : Colors.transparent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 14,
                    color: _hovered ? Colors.white : Colors.white54,
                  ),
                  const SizedBox(width: 7),
                ],
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: _hovered ? Colors.white : Colors.white54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small pulsing dot used in the "Available for Work" status badge.
class PulsingDot extends StatefulWidget {
  final Color color;
  const PulsingDot({super.key, required this.color});

  @override
  State<PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _anim = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: widget.color.withValues(alpha: _anim.value * 0.8),
              blurRadius: 6 + _anim.value * 6,
            ),
          ],
        ),
      ),
    );
  }
}

/// Blinking text cursor used in the typewriter animation.
class BlinkingCursor extends StatefulWidget {
  final Color color;
  const BlinkingCursor({super.key, required this.color});

  @override
  State<BlinkingCursor> createState() => _BlinkingCursorState();
}

class _BlinkingCursorState extends State<BlinkingCursor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 530),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

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

/// Section label row: "── SECTION TITLE"
class SectionLabel extends StatelessWidget {
  final String text;
  final String sectionId;

  const SectionLabel({
    super.key,
    required this.text,
    required this.sectionId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 24, height: 1, color: AppTheme.primaryColor),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 3.5,
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
