import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../../utils/launch_utils.dart';
import '../animate_on_visible.dart';
import '../responsive.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({
    super.key,
    required this.onNavigate,
  });

  final void Function(String sectionId) onNavigate;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 56),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            AnimateOnVisible(
              delay: const Duration(milliseconds: 100),
              slideY: 0.08,
              scaleBegin: 0.97,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 48),
                padding: EdgeInsets.fromLTRB(
                  isMobile ? 22 : 40,
                  isMobile ? 72 : 40,
                  isMobile ? 22 : 40,
                  28,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1A1A24), Color(0xFF0E0E14)],
                  ),
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  children: [
                    if (isMobile) const SizedBox(height: 8),
                    isMobile
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimateOnVisible(
                                delay: const Duration(milliseconds: 160),
                                child: _LinkColumn(
                                  title: 'Connect',
                                  links: [
                                    ('Email', () => openMailto(contactContent.email)),
                                    ('LinkedIn', () => openExternalUrl(contactContent.linkedinUrl)),
                                    ('GitHub', () => openExternalUrl(contactContent.githubUrl)),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 28),
                              AnimateOnVisible(
                                delay: const Duration(milliseconds: 240),
                                child: _LinkColumn(
                                  title: 'Quick Menu',
                                  links: [
                                    ('Home', () => onNavigate('hero')),
                                    ('About', () => onNavigate('about')),
                                    ('Work', () => onNavigate('projects')),
                                    ('Contact', () => onNavigate('contact')),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(width: 180),
                              Expanded(
                                child: AnimateOnVisible(
                                  delay: const Duration(milliseconds: 160),
                                  slideX: -0.04,
                                  child: _LinkColumn(
                                    title: 'Connect',
                                    links: [
                                      ('Email', () => openMailto(contactContent.email)),
                                      ('LinkedIn', () => openExternalUrl(contactContent.linkedinUrl)),
                                      ('GitHub', () => openExternalUrl(contactContent.githubUrl)),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: AnimateOnVisible(
                                  delay: const Duration(milliseconds: 240),
                                  slideX: 0.04,
                                  child: _LinkColumn(
                                    title: 'Quick Menu',
                                    links: [
                                      ('Home', () => onNavigate('hero')),
                                      ('About', () => onNavigate('about')),
                                      ('Work', () => onNavigate('projects')),
                                      ('Contact', () => onNavigate('contact')),
                                    ],
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
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              contactContent.copyright,
                              style: AppTextStyles.body(fontSize: 13),
                            ),
                          ),
                          _SocialCircle(
                            icon: Icons.mail_outline_rounded,
                            onTap: () => openMailto(contactContent.email),
                          ),
                          const SizedBox(width: 8),
                          _SocialCircle(
                            icon: Icons.business_center_outlined,
                            onTap: () => openExternalUrl(contactContent.linkedinUrl),
                          ),
                          const SizedBox(width: 8),
                          _SocialCircle(
                            icon: Icons.code_rounded,
                            onTap: () => openExternalUrl(contactContent.githubUrl),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: isMobile ? null : 36,
              right: isMobile ? 0 : null,
              child: AnimateOnVisible(
                slideY: 0.15,
                scaleBegin: 0.9,
                child: Column(
                  children: [
                    Text(
                      'Follow me',
                      style: AppTextStyles.script(
                        fontSize: 28,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.card,
                        border: Border.all(color: AppColors.border, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accentWarm.withValues(alpha: 0.25),
                            blurRadius: 24,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 52,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
        Text(title, style: AppTextStyles.heading(fontSize: 18, letterSpacing: -0.3)),
        const SizedBox(height: 14),
        for (final (label, onTap) in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: onTap,
              child: Text(
                label,
                style: AppTextStyles.body(fontSize: 15, color: AppColors.textSecondary),
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
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
        ),
        child: Icon(icon, size: 16, color: AppColors.textPrimary),
      ),
    );
  }
}
