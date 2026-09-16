import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'effects/interactive_3d.dart';
import 'floating_motion.dart';

class TechPill extends StatelessWidget {
  const TechPill({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.border),
      ),
      child: Text(label, style: AppTextStyles.mono(fontSize: 11)),
    );
  }
}

class SurfaceCard extends StatelessWidget {
  const SurfaceCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.radius = 28,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}

class GlassButton extends StatelessWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.emoji,
    this.filled = false,
  });

  final String label;
  final VoidCallback onPressed;
  final String? emoji;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(16),
            child: Ink(
              decoration: BoxDecoration(
                gradient: filled
                    ? const LinearGradient(
                        colors: [AppColors.accentWarm, AppColors.accent],
                      )
                    : AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 16,
                ),
                child: Text(
                  label,
                  style: AppTextStyles.label(
                    weight: FontWeight.w600,
                    color: filled
                        ? AppColors.background
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (emoji != null)
          Positioned(
            top: -10,
            right: -6,
            child: FloatingMotion(
              amplitude: 4,
              sway: 3,
              duration: const Duration(milliseconds: 2600),
              child: Text(emoji!, style: const TextStyle(fontSize: 22)),
            ),
          ),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.heading(fontSize: 36)),
        const SizedBox(height: 8),
        Container(
          width: 88,
          height: 3,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ],
    );
  }
}

class AtmosphericBackground extends StatelessWidget {
  const AtmosphericBackground({super.key, required this.child, this.scroll});

  final Widget child;
  final ScrollController? scroll;

  @override
  Widget build(BuildContext context) {
    Widget depth(double factor, Widget blob) {
      final s = scroll;
      if (s == null) return blob;
      return DepthScrollLayer(scroll: s, factor: factor, child: blob);
    }

    return Stack(
      children: [
        const Positioned.fill(child: ColoredBox(color: AppColors.background)),
        Positioned(
          top: -80,
          right: -40,
          child: depth(
            0.12,
            FloatingMotion(
              amplitude: 28,
              sway: 22,
              duration: const Duration(milliseconds: 9000),
              child: _GlowBlob(
                color: const Color(0xFF3B82F6).withValues(alpha: 0.22),
                size: 320,
              ),
            ),
          ),
        ),
        Positioned(
          top: 120,
          right: 80,
          child: depth(
            0.22,
            FloatingMotion(
              amplitude: 34,
              sway: 18,
              delay: const Duration(milliseconds: 800),
              duration: const Duration(milliseconds: 11000),
              child: _GlowBlob(
                color: AppColors.accentWarm.withValues(alpha: 0.18),
                size: 380,
              ),
            ),
          ),
        ),
        Positioned(
          top: 200,
          left: -60,
          child: depth(
            0.08,
            FloatingMotion(
              amplitude: 24,
              sway: 26,
              delay: const Duration(milliseconds: 1400),
              duration: const Duration(milliseconds: 10000),
              child: _GlowBlob(
                color: const Color(0xFFA3A34A).withValues(alpha: 0.12),
                size: 280,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 40,
          child: depth(
            -0.15,
            FloatingMotion(
              amplitude: 30,
              sway: 20,
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 8500),
              child: _GlowBlob(
                color: const Color(0xFF7C3AED).withValues(alpha: 0.14),
                size: 300,
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.size,
    this.borderWidth = 2,
    this.borderColor,
    this.backgroundColor,
    this.shadowColor,
  });

  final double size;
  final double borderWidth;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? AppColors.card,
        border: Border.all(
          color: borderColor ?? AppColors.border,
          width: borderWidth,
        ),
        boxShadow: [
          if (shadowColor != null)
            BoxShadow(
              color: shadowColor!,
              blurRadius: size * 0.2,
            ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/avatar.png',
          width: size,
          height: size,
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.15),
        ),
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  const _GlowBlob({required this.color, required this.size});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
