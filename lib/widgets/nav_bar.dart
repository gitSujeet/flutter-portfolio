import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../state/scroll_state.dart';
import 'shared/buttons.dart';

class NavBar extends StatelessWidget {
  final bool isDesktop;
  final bool isMobile;
  final PortfolioScrollState scrollState;
  final Function(GlobalKey) onNavigate;
  final GlobalKey workKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;

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
          // Logo / name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SK.',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 28,
                      color: AppTheme.primaryColor,
                    ),
              ),
              Text(
                'Flutter & Mobile Engineer',
                style: TextStyle(
                  fontSize: isMobile ? 9 : 10,
                  letterSpacing: 2,
                  color: Colors.white30,
                ),
              ),
            ],
          ),

          // Desktop nav links
          if (isDesktop)
            Row(
              children: [
                _NavLink('Work', 'work', () => onNavigate(workKey), scrollState),
                const SizedBox(width: 32),
                _NavLink('Experience', 'experience',
                    () => onNavigate(experienceKey), scrollState),
                const SizedBox(width: 32),
                _NavLink(
                    'Skills', 'skills', () => onNavigate(skillsKey), scrollState),
                const SizedBox(width: 32),
                _NavLink('Contact', 'contact', () => onNavigate(contactKey),
                    scrollState),
                const SizedBox(width: 32),
                CTAButton(
                  label: 'Hire Me',
                  onTap: () => launchUrl(
                    Uri.parse('mailto:sujeetkumarnmd@gmail.com'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
              ],
            )
          else
            // Mobile hamburger
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.md),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppTheme.md),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              _MobileNavItem('Work',
                  () { Navigator.pop(context); onNavigate(workKey); }),
              _MobileNavItem('Experience',
                  () { Navigator.pop(context); onNavigate(experienceKey); }),
              _MobileNavItem('Skills',
                  () { Navigator.pop(context); onNavigate(skillsKey); }),
              _MobileNavItem('Contact',
                  () { Navigator.pop(context); onNavigate(contactKey); }),
              const SizedBox(height: AppTheme.sm),
              SizedBox(
                width: double.infinity,
                child: CTAButton(
                  label: 'Hire Me',
                  onTap: () {
                    Navigator.pop(context);
                    launchUrl(
                      Uri.parse('mailto:sujeetkumarnmd@gmail.com'),
                      mode: LaunchMode.externalApplication,
                    );
                  },
                ),
              ),
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
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

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
        onExit: (_) => setState(() => _hovered = false),
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
