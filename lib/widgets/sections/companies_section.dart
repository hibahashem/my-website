import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../../utils/launch_utils.dart';
import '../animate_on_visible.dart';
import '../floating_motion.dart';
import '../responsive.dart';

class CompaniesSection extends StatelessWidget {
  const CompaniesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.only(top: 24, bottom: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimateOnVisible(
              child: Text(
                "Companies I've Worked With",
                style: AppTextStyles.heading(
                  fontSize: isMobile ? 26 : 32,
                  letterSpacing: -0.8,
                ),
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
            const SizedBox(height: 12),
            AnimateOnVisible(
              delay: const Duration(milliseconds: 80),
              child: Text(
                'Click a company to visit their page',
                style: AppTextStyles.mono(
                  fontSize: 11,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 28),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              children: [
                for (var i = 0; i < companiesWorkedWith.length; i++)
                  AnimateOnVisible(
                    delay: Duration(milliseconds: 70 * i),
                    slideY: 0.1,
                    scaleBegin: 0.92,
                    child: FloatingMotion(
                      amplitude: 5,
                      sway: 3,
                      delay: Duration(milliseconds: 120 * i),
                      duration: Duration(milliseconds: 2800 + (i % 3) * 400),
                      child: _CompanyChip(company: companiesWorkedWith[i]),
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

class _CompanyChip extends StatefulWidget {
  const _CompanyChip({required this.company});

  final CompanyLink company;

  @override
  State<_CompanyChip> createState() => _CompanyChipState();
}

class _CompanyChipState extends State<_CompanyChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => openExternalUrl(widget.company.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..translateByDouble(0, _hovered ? -4 : 0, 0, 1),
          transformAlignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.accent.withValues(alpha: 0.12)
                : AppColors.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(
              color: _hovered ? AppColors.accent : AppColors.border,
            ),
            boxShadow: [
              if (_hovered)
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.company.name,
                style: AppTextStyles.label(
                  weight: FontWeight.w600,
                  color: _hovered ? AppColors.accent : AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedRotation(
                turns: _hovered ? 0.125 : 0,
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  Icons.arrow_outward_rounded,
                  size: 16,
                  color: _hovered ? AppColors.accent : AppColors.textSecondary,
                ),
              ),
            ],
          ),
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
