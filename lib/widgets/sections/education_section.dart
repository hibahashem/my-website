import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'Education'),
            ),
            const SizedBox(height: 24),
            AnimateOnVisible(
              delay: const Duration(milliseconds: 120),
              slideY: 0.1,
              scaleBegin: 0.96,
              child: SurfaceCard(
                radius: 24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      educationContent.degree,
                      style: AppTextStyles.heading(
                        fontSize: 20,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(educationContent.institution, style: AppTextStyles.body()),
                    const SizedBox(height: 6),
                    Text(
                      educationContent.years,
                      style: AppTextStyles.body(
                        fontSize: 14,
                        color: AppColors.accent,
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
