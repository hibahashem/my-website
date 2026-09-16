import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../../utils/launch_utils.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key, required this.onNavigate});

  final void Function(String sectionId) onNavigate;

  List<(String, VoidCallback)> get _connectLinks => [
    ('Email', () => openMailto(contactContent.email)),
    ('LinkedIn', () => openExternalUrl(contactContent.linkedinUrl)),
  ];

  List<(String, VoidCallback)> _menuLinks() => [
    ('Home', () => onNavigate('hero')),
    ('About', () => onNavigate('about')),
    ('Work', () => onNavigate('projects')),
    ('Contact', () => onNavigate('contact')),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);
    final isCompact = Breakpoints.isCompact(width);

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 56),
        child: isMobile
            ? _MobileFollowCard(
                connectLinks: _connectLinks,
                menuLinks: _menuLinks(),
              )
            : _DesktopFollowBlock(
                isCompact: isCompact,
                connectLinks: _connectLinks,
                menuLinks: _menuLinks(),
              ),
      ),
    );
  }
}

class _MobileFollowCard extends StatelessWidget {
  const _MobileFollowCard({
    required this.connectLinks,
    required this.menuLinks,
  });

  final List<(String, VoidCallback)> connectLinks;
  final List<(String, VoidCallback)> menuLinks;

  @override
  Widget build(BuildContext context) {
    return AnimateOnVisible(
      slideY: 0.1,
      scaleBegin: 0.96,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF1A1A24), Color(0xFF0E0E14)],
          ),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            // Follow me + avatar — horizontal
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Follow me',
                    style: AppTextStyles.script(
                      fontSize: 26,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                ProfileAvatar(
                  size: 72,
                  shadowColor: AppColors.accentWarm.withValues(alpha: 0.22),
                ),
              ],
            ),
            const SizedBox(height: 22),
            // Connect + Quick Menu — horizontal
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _LinkColumn(title: 'Connect', links: connectLinks),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LinkColumn(title: 'Quick Menu', links: menuLinks),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Divider(color: AppColors.border),
            const SizedBox(height: 14),
            Text(
              contactContent.copyright,
              textAlign: TextAlign.center,
              style: AppTextStyles.body(fontSize: 12),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SocialCircle(
                  icon: Icons.mail_outline_rounded,
                  onTap: () => openMailto(contactContent.email),
                ),
                const SizedBox(width: 10),
                _SocialCircle(
                  icon: Icons.business_center_outlined,
                  onTap: () => openExternalUrl(contactContent.linkedinUrl),
                ),
                const SizedBox(width: 10),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DesktopFollowBlock extends StatelessWidget {
  const _DesktopFollowBlock({
    required this.isCompact,
    required this.connectLinks,
    required this.menuLinks,
  });

  final bool isCompact;
  final List<(String, VoidCallback)> connectLinks;
  final List<(String, VoidCallback)> menuLinks;

  @override
  Widget build(BuildContext context) {
    final avatarSize = isCompact ? 110.0 : 120.0;

    return Column(
      children: [
        AnimateOnVisible(
          slideY: 0.12,
          scaleBegin: 0.94,
          child: Column(
            children: [
              Text(
                'Follow me',
                style: AppTextStyles.script(
                  fontSize: 28,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              ProfileAvatar(
                size: avatarSize,
                shadowColor: AppColors.accentWarm.withValues(alpha: 0.25),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: Offset(0, isCompact ? -28 : -36),
          child: AnimateOnVisible(
            delay: const Duration(milliseconds: 100),
            slideY: 0.08,
            scaleBegin: 0.97,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(
                isCompact ? 28 : 36,
                isCompact ? 52 : 44,
                isCompact ? 28 : 36,
                28,
              ),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1A1A24), Color(0xFF0E0E14)],
                ),
                borderRadius: BorderRadius.circular(36.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AnimateOnVisible(
                          delay: const Duration(milliseconds: 160),
                          slideX: -0.04,
                          child: _LinkColumn(
                            title: 'Connect',
                            links: connectLinks,
                          ),
                        ),
                      ),
                      Expanded(
                        child: AnimateOnVisible(
                          delay: const Duration(milliseconds: 240),
                          slideX: 0.04,
                          child: _LinkColumn(
                            title: 'Quick Menu',
                            links: menuLinks,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  const Divider(color: AppColors.border),
                  const SizedBox(height: 18),
                  AnimateOnVisible(
                    delay: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        Text(
                          contactContent.copyright,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.body(fontSize: 13),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialCircle(
                              icon: Icons.mail_outline_rounded,
                              onTap: () => openMailto(contactContent.email),
                            ),
                            const SizedBox(width: 10),
                            _SocialCircle(
                              icon: Icons.business_center_outlined,
                              onTap: () =>
                                  openExternalUrl(contactContent.linkedinUrl),
                            ),
                            const SizedBox(width: 10),
                           
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _LinkColumn extends StatelessWidget {
  const _LinkColumn({required this.title, required this.links});

  final String title;
  final List<(String, VoidCallback)> links;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.heading(fontSize: 17, letterSpacing: -0.3),
        ),
        const SizedBox(height: 12),
        for (final (label, onTap) in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: onTap,
              child: Text(
                label,
                style: AppTextStyles.body(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _SocialCircle extends StatelessWidget {
  const _SocialCircle({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 18, color: AppColors.textPrimary),
      ),
    );
  }
}
