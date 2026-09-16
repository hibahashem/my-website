import 'package:flutter/material.dart';

import '../../data/experience_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(child: SectionTitle(title: 'Experience')),
            const SizedBox(height: 36),
            for (var i = 0; i < experienceEntries.length; i++)
              AnimateOnVisible(
                delay: Duration(milliseconds: 80 * i),
                slideY: 0.08,
                child: _TimelineItem(
                  entry: experienceEntries[i],
                  isLast: i == experienceEntries.length - 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  const _TimelineItem({required this.entry, required this.isLast});

  final ExperienceEntry entry;
  final bool isLast;

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Breakpoints.isMobile(MediaQuery.sizeOf(context).width);

    final railWidth = isMobile ? 28.0 : 36.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: Stack(
        children: [
          if (!widget.isLast)
            Positioned(
              left: (railWidth - 2) / 2,
              top: 20,
              bottom: 0,
              child: Container(width: 2, color: AppColors.border),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: railWidth,
                height: 14,
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _hovered ? AppColors.accent : AppColors.card,
                      border: Border.all(color: AppColors.accent, width: 2),
                      boxShadow: [
                        if (_hovered)
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.35),
                            blurRadius: 10,
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: widget.isLast ? 0 : 28),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.all(isMobile ? 18 : 22),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: _hovered
                            ? AppColors.accent.withValues(alpha: 0.4)
                            : AppColors.border,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isMobile) ...[
                          Text(
                            widget.entry.dates,
                            style: AppTextStyles.mono(
                              fontSize: 11,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.entry.role,
                            style: AppTextStyles.heading(
                              fontSize: 17,
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.entry.company,
                            style: AppTextStyles.body(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ] else
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.entry.role,
                                      style: AppTextStyles.heading(
                                        fontSize: 18,
                                        letterSpacing: -0.3,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.entry.company,
                                      style: AppTextStyles.body(
                                        fontSize: 14,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                widget.entry.dates,
                                style: AppTextStyles.mono(
                                  fontSize: 12,
                                  color: AppColors.accent,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 14),
                        for (final bullet in widget.entry.highlights.take(3))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 7),
                                  child: Container(
                                    width: 5,
                                    height: 5,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.accent,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    bullet,
                                    style: AppTextStyles.body(fontSize: 14),
                                  ),
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
          ),
        ],
      ),
    );
  }
}
