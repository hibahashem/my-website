import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/projects_data.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_theme.dart';
import '../utils/launch_utils.dart';
import '../widgets/common_widgets.dart';
import '../widgets/responsive.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.projectId});

  final String projectId;

  @override
  Widget build(BuildContext context) {
    final project = projectById(projectId);
    if (project == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Project not found', style: AppTextStyles.heading(fontSize: 28)),
              const SizedBox(height: 16),
              GlassButton(label: 'Back home', onPressed: () => context.go('/')),
            ],
          ),
        ),
      );
    }

    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: AppColors.background.withValues(alpha: 0.9),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppColors.textPrimary),
              onPressed: () => context.go('/'),
            ),
            title: Text(
              'Project',
              style: AppTextStyles.label(color: AppColors.textSecondary),
            ),
          ),
          SliverToBoxAdapter(
            child: ResponsivePadding(
              child: Padding(
                padding: EdgeInsets.only(
                  top: isMobile ? 24 : 40,
                  bottom: 80,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: AppTextStyles.heading(fontSize: isMobile ? 32 : 44),
                    ),
                    const SizedBox(height: 14),
                    Text(project.description, style: AppTextStyles.body(fontSize: 17)),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        for (final tech in project.techStack) TechPill(label: tech),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _DetailMedia(project: project),
                    const SizedBox(height: 32),
                    Text('Case study', style: AppTextStyles.heading(fontSize: 24)),
                    const SizedBox(height: 12),
                    SurfaceCard(
                      child: Text(
                        project.caseStudy ??
                            'Case study details coming soon. Add problem, solution, and outcomes in projects_data.dart.',
                        style: AppTextStyles.body(),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        if (project.liveUrl != null)
                          GlassButton(
                            label: 'Live demo',
                            filled: true,
                            onPressed: () => openExternalUrl(project.liveUrl!),
                          ),
                        if (project.repoUrl != null)
                          GlassButton(
                            label: 'View repository',
                            onPressed: () => openExternalUrl(project.repoUrl!),
                          ),
                        GlassButton(
                          label: 'Back to portfolio',
                          onPressed: () => context.go('/'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailMedia extends StatelessWidget {
  const _DetailMedia({required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    if (project.imageAsset != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(project.imageAsset!, fit: BoxFit.cover),
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.card,
            AppColors.accent.withValues(alpha: 0.16),
            AppColors.surface,
          ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.devices_rounded, size: 56, color: AppColors.accent),
            const SizedBox(height: 12),
            Text(
              'Screenshot placeholder',
              style: AppTextStyles.body(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
