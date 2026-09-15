import 'package:flutter/material.dart';

import '../../data/experience_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'Experience'),
            ),
            const SizedBox(height: 28),
            for (var i = 0; i < experienceEntries.length; i++) ...[
              AnimateOnVisible(
                delay: Duration(milliseconds: 100 * i),
                slideY: 0.1,
                slideX: i.isEven ? -0.04 : 0.04,
                child: SurfaceCard(
                  radius: 24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        experienceEntries[i].role,
                        style: AppTextStyles.heading(
                          fontSize: 18,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${experienceEntries[i].company}  ·  ${experienceEntries[i].dates}',
                        style: AppTextStyles.body(
                          fontSize: 14,
                          color: AppColors.accent,
                        ),
                      ),
                      const SizedBox(height: 12),
                      for (final bullet
                          in experienceEntries[i].highlights.take(3))
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('•  ', style: AppTextStyles.body(fontSize: 14)),
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
              if (i < experienceEntries.length - 1) const SizedBox(height: 14),
            ],
          ],
        ),
      ),
    );
  }
}
