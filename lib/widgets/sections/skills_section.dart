import 'package:flutter/material.dart';

import '../../data/skills_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  static const _icons = [
    Icons.code_rounded,
    Icons.account_tree_outlined,
    Icons.hub_outlined,
    Icons.cloud_outlined,
    Icons.build_circle_outlined,
    Icons.verified_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final columns = Breakpoints.isMobile(width)
        ? 1
        : Breakpoints.isTablet(width)
            ? 2
            : 3;

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'Skills'),
            ),
            const SizedBox(height: 12),
            AnimateOnVisible(
              delay: const Duration(milliseconds: 60),
              child: Text(
                'What I use to ship production Flutter apps.',
                style: AppTextStyles.body(fontSize: 15),
              ),
            ),
            const SizedBox(height: 36),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 16.0;
                final itemWidth =
                    (constraints.maxWidth - gap * (columns - 1)) / columns;

                return Wrap(
                  spacing: gap,
                  runSpacing: gap,
                  children: [
                    for (var i = 0; i < skillCategories.length; i++)
                      SizedBox(
                        width: itemWidth,
                        child: AnimateOnVisible(
                          delay: Duration(milliseconds: 70 * i),
                          slideY: 0.1,
                          scaleBegin: 0.97,
                          child: _SkillGroupCard(
                            index: i,
                            category: skillCategories[i],
                            icon: _icons[i % _icons.length],
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SkillGroupCard extends StatefulWidget {
  const _SkillGroupCard({
    required this.index,
    required this.category,
    required this.icon,
  });

  final int index;
  final SkillCategory category;
  final IconData icon;

  @override
  State<_SkillGroupCard> createState() => _SkillGroupCardState();
}

class _SkillGroupCardState extends State<_SkillGroupCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.45)
                : AppColors.border,
          ),
          boxShadow: [
            if (_hovered)
              BoxShadow(
                color: AppColors.accent.withValues(alpha: 0.08),
                blurRadius: 28,
                offset: const Offset(0, 12),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(widget.icon, size: 20, color: AppColors.accent),
                ),
                const Spacer(),
                Text(
                  '${widget.index + 1}'.padLeft(2, '0'),
                  style: AppTextStyles.mono(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Text(
              widget.category.title,
              style: AppTextStyles.heading(
                fontSize: 17,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final skill in widget.category.skills)
                  TechPill(label: skill),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
