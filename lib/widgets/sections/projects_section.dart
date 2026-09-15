import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/projects_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../responsive.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);
    final featured = projects.first;
    final rest = projects.skip(1).toList();

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'Projects'),
            ),
            const SizedBox(height: 32),
            AnimateOnVisible(
              delay: const Duration(milliseconds: 80),
              slideY: 0.1,
              scaleBegin: 0.95,
              child: ProjectShowcaseCard(
                project: featured,
                tall: true,
                glow: AppColors.accentWarm,
              ),
            ),
            const SizedBox(height: 18),
            if (isMobile)
              Column(
                children: [
                  for (var i = 0; i < rest.length; i++) ...[
                    AnimateOnVisible(
                      delay: Duration(milliseconds: 100 * (i + 1)),
                      slideY: 0.12,
                      scaleBegin: 0.94,
                      child: ProjectShowcaseCard(
                        project: rest[i],
                        glow: i.isEven
                            ? const Color(0xFF7C3AED)
                            : const Color(0xFF3B82F6),
                      ),
                    ),
                    if (i < rest.length - 1) const SizedBox(height: 18),
                  ],
                ],
              )
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  const gap = 18.0;
                  final itemWidth = (constraints.maxWidth - gap) / 2;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: [
                      for (var i = 0; i < rest.length; i++)
                        SizedBox(
                          width: itemWidth,
                          child: AnimateOnVisible(
                            delay: Duration(milliseconds: 120 * (i + 1)),
                            slideY: 0.12,
                            slideX: i.isEven ? -0.04 : 0.04,
                            scaleBegin: 0.94,
                            child: ProjectShowcaseCard(
                              project: rest[i],
                              glow: i.isEven
                                  ? const Color(0xFF7C3AED)
                                  : const Color(0xFF3B82F6),
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

class ProjectShowcaseCard extends StatefulWidget {
  const ProjectShowcaseCard({
    super.key,
    required this.project,
    this.tall = false,
    this.glow,
  });

  final Project project;
  final bool tall;
  final Color? glow;

  @override
  State<ProjectShowcaseCard> createState() => _ProjectShowcaseCardState();
}

class _ProjectShowcaseCardState extends State<ProjectShowcaseCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final year = '2025';
    final category = project.techStack.isNotEmpty
        ? project.techStack.first.toUpperCase()
        : 'FLUTTER';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.015 : 1,
        duration: const Duration(milliseconds: 180),
        child: InkWell(
          onTap: () => context.go('/projects/${project.id}'),
          borderRadius: BorderRadius.circular(36),
          child: Container(
            height: widget.tall ? 340 : 300,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(36),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                if (widget.glow != null)
                  BoxShadow(
                    color: widget.glow!.withValues(alpha: 0.18),
                    blurRadius: 40,
                    spreadRadius: 2,
                  ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment.center,
                        radius: 0.9,
                        colors: [
                          (widget.glow ?? AppColors.accent).withValues(alpha: 0.16),
                          AppColors.card,
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 18,
                  top: 18,
                  child: Text(
                    category,
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Positioned(
                  right: 18,
                  top: 18,
                  child: Text(
                    year,
                    style: AppTextStyles.mono(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Text(
                          project.title.split(' ').first.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading(
                            fontSize: widget.tall ? 64 : 42,
                            color: Colors.white.withValues(alpha: 0.08),
                            letterSpacing: 2,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              widget.tall
                                  ? Icons.laptop_mac_rounded
                                  : Icons.phone_iphone_rounded,
                              size: widget.tall ? 72 : 56,
                              color: AppColors.textPrimary.withValues(alpha: 0.85),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              project.title,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.heading(
                                fontSize: 22,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'View Details →',
                              style: AppTextStyles.label(
                                color: AppColors.accent,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
