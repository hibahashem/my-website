import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../animate_on_visible.dart';
import '../responsive.dart';

class CompaniesSection extends StatelessWidget {
  const CompaniesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimateOnVisible(
              child: Text(
                "Companies I've Worked With",
                style: AppTextStyles.heading(fontSize: 32, letterSpacing: -0.8),
              ),
            ),
            const SizedBox(height: 10),
            const AnimateOnVisible(
              delay: Duration(milliseconds: 60),
              child: Row(
                children: [
                  _Rule(width: 48, opacity: 1),
                  SizedBox(width: 8),
                  _Rule(width: 18, opacity: 0.7),
                  SizedBox(width: 8),
                  _Rule(width: 10, opacity: 0.38),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (var i = 0; i < companiesWorkedWith.length; i++)
                  AnimateOnVisible(
                    delay: Duration(milliseconds: 70 * i),
                    slideY: 0.1,
                    scaleBegin: 0.92,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        companiesWorkedWith[i],
                        style: AppTextStyles.label(
                          weight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.width, required this.opacity});

  final double width;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 3,
      color: Colors.white.withValues(alpha: opacity),
    );
  }
}
