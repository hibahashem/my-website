import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/projects_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../effects/interactive_3d.dart';
import '../responsive.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  static const _glows = [
    AppColors.accentWarm,
    Color(0xFF7C3AED),
    Color(0xFF3B82F6),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = Breakpoints.isCompact(width);
    final featured = projects.first;
    final rest = projects.skip(1).toList();

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(child: SectionTitle(title: 'Projects')),
            const SizedBox(height: 28),
            AnimateOnVisible(
              delay: const Duration(milliseconds: 60),
              child: ProjectTurntable(
                items: [
                  for (var i = 0; i < projects.length; i++)
                    (
                      title: projects[i].title,
                      glow: _glows[i % _glows.length],
                      id: projects[i].id,
                    ),
                ],
                onSelect: (id) => context.go('/projects/$id'),
              ),
            ),
            const SizedBox(height: 36),
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
            if (isCompact)
              Column(
                children: [
                  for (var i = 0; i < rest.length; i++) ...[
                    AnimateOnVisible(
                      delay: Duration(milliseconds: 100 * (i + 1)),
                      slideY: 0.12,
                      scaleBegin: 0.94,
                      child: ProjectShowcaseCard(
                        project: rest[i],
                        glow: _glows[(i + 1) % _glows.length],
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
                              glow: _glows[(i + 1) % _glows.length],
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
  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final year = project.year;
    final category = project.techStack.isNotEmpty
        ? project.techStack.first.toUpperCase()
        : 'FLUTTER';

    final cover = _ProjectCover(
      project: project,
      tall: widget.tall,
      glow: widget.glow,
      category: category,
      year: year,
      frosted: true,
    );

    final revealed = _ProjectCover(
      project: project,
      tall: widget.tall,
      glow: widget.glow,
      category: category,
      year: year,
      frosted: false,
    );

    return Tilt3D(
      maxTilt: 0.1,
      child: InkWell(
        onTap: () => context.go('/projects/${project.id}'),
        borderRadius: BorderRadius.circular(36),
        child: SizedBox(
          height: widget.tall ? 340 : 300,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: GlassShardReveal(reveal: revealed, child: cover),
          ),
        ),
      ),
    );
  }
}

class _ProjectCover extends StatelessWidget {
  const _ProjectCover({
    required this.project,
    required this.tall,
    required this.category,
    required this.year,
    required this.frosted,
    this.glow,
  });

  final Project project;
  final bool tall;
  final String category;
  final String year;
  final bool frosted;
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        boxShadow: [
          if (glow != null)
            BoxShadow(
              color: glow!.withValues(alpha: 0.18),
              blurRadius: 40,
              spreadRadius: 2,
            ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 0.9,
                colors: [
                  (glow ?? AppColors.accent).withValues(
                    alpha: frosted ? 0.1 : 0.28,
                  ),
                  AppColors.card,
                ],
              ),
            ),
          ),
          if (project.coverAsset != null)
            Positioned.fill(
              child: Image.asset(
                project.coverAsset!,
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          if (project.coverAsset != null)
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.card.withValues(alpha: frosted ? 0.35 : 0.15),
                      AppColors.card.withValues(alpha: frosted ? 0.72 : 0.55),
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (project.coverAsset == null)
                    Icon(
                      tall
                          ? Icons.laptop_mac_rounded
                          : Icons.phone_iphone_rounded,
                      size: tall ? 72 : 56,
                      color: AppColors.textPrimary.withValues(alpha: 0.85),
                    ),
                  if (project.coverAsset == null) const SizedBox(height: 16),
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
                    frosted ? 'Hover to shatter →' : 'View Details →',
                    style: AppTextStyles.label(
                      color: AppColors.accent,
                      weight: FontWeight.w600,
                    ),
                  ),
                  if (!frosted) ...[
                    const SizedBox(height: 10),
                    Text(
                      project.description,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.body(fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
