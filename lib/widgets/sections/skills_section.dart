import 'package:flutter/material.dart';

import '../../data/skills_data.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'Skills'),
            ),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (context, constraints) {
                const gap = 14.0;
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
                          delay: Duration(milliseconds: 90 * i),
                          slideY: 0.14,
                          scaleBegin: 0.94,
                          child: SurfaceCard(
                            radius: 24,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  skillCategories[i].title,
                                  style: AppTextStyles.heading(
                                    fontSize: 17,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    for (final skill in skillCategories[i].skills)
                                      TechPill(label: skill),
                                  ],
                                ),
                              ],
                            ),
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
