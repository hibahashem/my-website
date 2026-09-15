import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../animate_on_visible.dart';
import '../common_widgets.dart';
import '../floating_motion.dart';
import '../responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);

    return ResponsivePadding(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 72),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnimateOnVisible(
              child: SectionTitle(title: 'About Me'),
            ),
            const SizedBox(height: 36),
            if (isMobile)
              Column(
                children: [
                  const AnimateOnVisible(
                    delay: Duration(milliseconds: 80),
                    child: _AboutAvatar(),
                  ),
                  const SizedBox(height: 24),
                  AnimateOnVisible(
                    delay: const Duration(milliseconds: 180),
                    child: Text(
                      aboutContent.bio,
                      style: AppTextStyles.body(fontSize: 16),
                    ),
                  ),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AnimateOnVisible(
                    delay: Duration(milliseconds: 80),
                    slideX: -0.06,
                    child: _AboutAvatar(),
                  ),
                  const SizedBox(width: 36),
                  Expanded(
                    child: AnimateOnVisible(
                      delay: const Duration(milliseconds: 180),
                      slideX: 0.06,
                      child: Text(
                        aboutContent.bio,
                        style: AppTextStyles.body(fontSize: 17),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 48),
            _StatsRow(isMobile: isMobile),
          ],
        ),
      ),
    );
  }
}

class _AboutAvatar extends StatelessWidget {
  const _AboutAvatar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          FloatingMotion(
            amplitude: 6,
            sway: 4,
            duration: const Duration(milliseconds: 4000),
            child: CustomPaint(
              size: const Size(180, 180),
              painter: _ScribblePainter(),
            ),
          ),
          FloatingMotion(
            amplitude: 8,
            sway: 3,
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 3200),
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.card,
                border: Border.all(color: AppColors.border),
              ),
              child: const Icon(
                Icons.waving_hand_rounded,
                size: 48,
                color: AppColors.accent,
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 28,
            child: FloatingMotion(
              amplitude: 5,
              sway: 3,
              duration: const Duration(milliseconds: 2400),
              child: const Text('✦', style: TextStyle(color: Colors.white70, fontSize: 14)),
            ),
          ),
          Positioned(
            top: 28,
            right: 12,
            child: FloatingMotion(
              amplitude: 4,
              sway: 4,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 2800),
              child: const Text('✧', style: TextStyle(color: Colors.white54, fontSize: 10)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScribblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 62, paint);
    canvas.drawCircle(center.translate(4, -3), 70, paint);
    canvas.drawCircle(center.translate(-6, 5), 78, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatsRow extends StatelessWidget {
  const _StatsRow({required this.isMobile});

  final bool isMobile;

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: [
          for (var i = 0; i < aboutContent.stats.length; i++) ...[
            AnimateOnVisible(
              delay: Duration(milliseconds: 80 * i),
              child: _StatBlock(stat: aboutContent.stats[i]),
            ),
            if (i < aboutContent.stats.length - 1) const SizedBox(height: 28),
          ],
        ],
      );
    }

    final children = <Widget>[];
    for (var i = 0; i < aboutContent.stats.length; i++) {
      if (i > 0) {
        children.add(
          Container(
            width: 1,
            height: 64,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
        );
      }
      children.add(
        Expanded(
          child: AnimateOnVisible(
            delay: Duration(milliseconds: 100 * i),
            child: _StatBlock(stat: aboutContent.stats[i]),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({required this.stat});

  final StatItem stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppColors.statGradient.createShader(bounds),
          child: Text(
            stat.value,
            style: AppTextStyles.heading(
              fontSize: 48,
              color: Colors.white,
              letterSpacing: -1.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          stat.label,
          textAlign: TextAlign.center,
          style: AppTextStyles.body(fontSize: 14),
        ),
      ],
    );
  }
}
