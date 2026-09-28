import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class PortfolioFooter extends StatelessWidget {
  final bool isMobile;
  const PortfolioFooter({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final year = DateTime.now().year;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 24 : 32,
        horizontal: 0,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _FooterLinks(),
                const SizedBox(height: 16),
                _Copyright(year: year),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Copyright(year: year),
                _FooterLinks(),
              ],
            ),
    );
  }
}

class _Copyright extends StatelessWidget {
  final int year;
  const _Copyright({required this.year});

  @override
  Widget build(BuildContext context) {
    return Text(
      '© $year Sujeet Kumar. Built with Flutter.',
      style: const TextStyle(
        fontSize: 12,
        color: Colors.white24,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _FooterLinks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterLink(
          label: 'GitHub',
          onTap: () => launchUrl(
            Uri.parse('https://github.com/gitSujeet'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        const SizedBox(width: 24),
        _FooterLink(
          label: 'LinkedIn',
          onTap: () => launchUrl(
            Uri.parse('https://www.linkedin.com/in/sujeet-kumar-ind/'),
            mode: LaunchMode.externalApplication,
          ),
        ),
        const SizedBox(width: 24),
        _FooterLink(
          label: 'Email',
          onTap: () => launchUrl(
            Uri.parse('mailto:sujeetkumarnmd@gmail.com'),
            mode: LaunchMode.externalApplication,
          ),
        ),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _FooterLink({required this.label, required this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
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
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: TextStyle(
              fontSize: 12,
              letterSpacing: 0.5,
              color: _hovered ? AppTheme.primaryColor : Colors.white30,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}
