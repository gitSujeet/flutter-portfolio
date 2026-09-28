import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../main.dart';
import 'shared/buttons.dart';

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
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.2),
              ),
              color: AppTheme.primaryColor.withValues(alpha: 0.04),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section label
                const Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Divider(
                          color: AppTheme.primaryColor, thickness: 1),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'GET IN TOUCH',
                      style: TextStyle(
                        fontSize: 11,
                        letterSpacing: 3.5,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: widget.isMobile ? 20 : 24),

                Text(
                  "Let's build\nsomething great.",
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: widget.isMobile ? 32 : 40,
                        color: Colors.white,
                      ),
                ),

                SizedBox(height: widget.isMobile ? 12 : 16),

                Text(
                  'Open to full-time roles, freelance projects, and technical collaborations.',
                  style: TextStyle(
                    fontSize: widget.isMobile ? 14 : 15,
                    color: Colors.white54,
                    height: 1.7,
                  ),
                ),

                SizedBox(height: widget.isMobile ? 20 : 24),

                // Contact details
                Wrap(
                  spacing: 20,
                  runSpacing: 10,
                  children: [
                    _ContactDetail(
                      icon: Icons.phone_outlined,
                      label: '+91-7209106002',
                      onTap: () => launchUrl(
                        Uri.parse('tel:+917209106002'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    _ContactDetail(
                      icon: Icons.email_outlined,
                      label: 'sujeetkumarnmd@gmail.com',
                      onTap: () => launchUrl(
                        Uri.parse('mailto:sujeetkumarnmd@gmail.com'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: widget.isMobile ? 24 : 28),

                // Action buttons
                Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  children: [
                    CTAButton(
                      label: 'Send Email',
                      onTap: () => launchUrl(
                        Uri.parse('mailto:sujeetkumarnmd@gmail.com'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    PortfolioOutlineButton(
                      label: 'GitHub',
                      icon: Icons.code,
                      onTap: () => launchUrl(
                        Uri.parse('https://github.com/gitSujeet'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    PortfolioOutlineButton(
                      label: 'LinkedIn',
                      icon: Icons.link,
                      onTap: () => launchUrl(
                        Uri.parse(
                            'https://www.linkedin.com/in/sujeet-kumar-ind/'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
                    PortfolioOutlineButton(
                      label: '+91-7209106002',
                      icon: Icons.phone_outlined,
                      onTap: () => launchUrl(
                        Uri.parse('tel:+917209106002'),
                        mode: LaunchMode.externalApplication,
                      ),
                    ),
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

  const _ContactDetail({
    required this.icon,
    required this.label,
    required this.onTap,
  });

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
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white38,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
