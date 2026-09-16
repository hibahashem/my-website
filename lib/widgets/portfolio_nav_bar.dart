import 'dart:ui';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/launch_utils.dart';

class PortfolioNavBar extends StatelessWidget {
  const PortfolioNavBar({
    super.key,
    required this.scrolled,
    required this.onNavigate,
  });

  final bool scrolled;
  final void Function(String sectionId) onNavigate;

  static const _links = [
    ('Home', 'hero'),
    ('About', 'about'),
    ('Work', 'projects'),
    ('Contact', 'contact'),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final showLinks = Breakpoints.isDesktop(width);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: scrolled ? 14 : 0,
          sigmaY: scrolled ? 14 : 0,
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: scrolled ? 0.72 : 0),
            border: Border(
              bottom: BorderSide(
                color: scrolled ? AppColors.border : Colors.transparent,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: showLinks ? 40 : 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => onNavigate('hero'),
                    child: Text(
                      'Hiba.',
                      style: AppTextStyles.heading(
                        fontSize: 22,
                        letterSpacing: -0.6,
                      ),
                    ),
                  ),
                  if (showLinks) ...[
                    const Spacer(),
                    for (final (label, id) in _links)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextButton(
                          onPressed: () => onNavigate(id),
                          child: Text(
                            label,
                            style: AppTextStyles.label(
                              color: AppColors.textSecondary,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    const Spacer(),
                    _ResumeChip(onPressed: openResumePdf),
                  ] else ...[
                    const Spacer(),
                    IconButton(
                      tooltip: 'Resume',
                      onPressed: openResumePdf,
                      icon: const Icon(
                        Icons.download_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      onPressed: () => _openMenu(context),
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openMenu(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final (label, id) in _links)
                  ListTile(
                    title: Text(label, style: AppTextStyles.label()),
                    onTap: () {
                      Navigator.pop(context);
                      onNavigate(id);
                    },
                  ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      openResumePdf();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.card,
                      foregroundColor: AppColors.textPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: const BorderSide(color: AppColors.border),
                      ),
                    ),
                    icon: const Icon(Icons.download_rounded, size: 18),
                    label: const Text('Resume'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ResumeChip extends StatelessWidget {
  const _ResumeChip({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: Ink(
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Resume', style: AppTextStyles.label(weight: FontWeight.w600)),
                const SizedBox(width: 8),
                const Icon(Icons.download_rounded, size: 16, color: AppColors.textPrimary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
