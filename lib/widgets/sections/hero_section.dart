import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../data/profile_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_theme.dart';
import '../common_widgets.dart';
import '../floating_motion.dart';
import '../responsive.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onHireMe,
    required this.onMyStory,
  });

  final VoidCallback onHireMe;
  final VoidCallback onMyStory;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);
    final isTablet = Breakpoints.isTablet(width);
    final nameSize = isMobile ? 42.0 : isTablet ? 56.0 : 72.0;

    return Column(
      children: [
        ResponsivePadding(
          child: Padding(
            padding: EdgeInsets.only(
              top: isMobile ? 110 : 140,
              bottom: isMobile ? 40 : 56,
            ),
            child: isMobile
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _HeroCopy(
                        nameSize: nameSize,
                        onHireMe: onHireMe,
                        onMyStory: onMyStory,
                      ),
                      const SizedBox(height: 36),
                      const Center(child: _HeroAvatar(size: 240)),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 6,
                        child: _HeroCopy(
                          nameSize: nameSize,
                          onHireMe: onHireMe,
                          onMyStory: onMyStory,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Expanded(
                        flex: 5,
                        child: Center(child: _HeroAvatar(size: 360)),
                      ),
                    ],
                  ),
          ),
        ),
        const SkillsMarquee(),
        const SizedBox(height: 48),
      ],
    );
  }
}

class _HeroCopy extends StatelessWidget {
  const _HeroCopy({
    required this.nameSize,
    required this.onHireMe,
    required this.onMyStory,
  });

  final double nameSize;
  final VoidCallback onHireMe;
  final VoidCallback onMyStory;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FloatingMotion(
          amplitude: 4,
          sway: 2,
          duration: const Duration(milliseconds: 3800),
          child: Transform.translate(
            offset: const Offset(4, 14),
            child: Text(
              heroContent.scriptPrefix,
              style: AppTextStyles.script(fontSize: nameSize * 0.55),
            ),
          ),
        ),
        Text(
          heroContent.name,
          style: AppTextStyles.heading(
            fontSize: nameSize,
            height: 1.05,
            letterSpacing: -2,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          heroContent.roleLine,
          style: AppTextStyles.label(
            fontSize: 15,
            color: AppColors.accent,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            heroContent.subheading,
            style: AppTextStyles.body(fontSize: 16),
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            FloatingMotion(
              amplitude: 5,
              sway: 3,
              duration: const Duration(milliseconds: 2800),
              child: GlassButton(
                label: 'Hire Me',
                emoji: '💼',
                onPressed: onHireMe,
                filled: true,
              ),
            ),
            FloatingMotion(
              amplitude: 5,
              sway: 3,
              delay: const Duration(milliseconds: 400),
              duration: const Duration(milliseconds: 3100),
              child: GlassButton(
                label: 'My Story',
                emoji: '🎤',
                onPressed: onMyStory,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HeroAvatar extends StatelessWidget {
  const _HeroAvatar({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ParallaxHover(
        maxOffset: 14,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            FloatingMotion(
              amplitude: 14,
              sway: 10,
              duration: const Duration(milliseconds: 4200),
              child: Align(
                alignment: const Alignment(-0.85, -0.55),
                child: _Cloud(width: size * 0.34),
              ),
            ),
            FloatingMotion(
              amplitude: 12,
              sway: 8,
              delay: const Duration(milliseconds: 600),
              duration: const Duration(milliseconds: 3600),
              child: Align(
                alignment: const Alignment(0.75, -0.72),
                child: _Cloud(width: size * 0.28),
              ),
            ),
            FloatingMotion(
              amplitude: 10,
              sway: 12,
              delay: const Duration(milliseconds: 1100),
              duration: const Duration(milliseconds: 4800),
              child: Align(
                alignment: const Alignment(0.95, 0.55),
                child: _Cloud(width: size * 0.3),
              ),
            ),
            FloatingMotion(
              amplitude: 8,
              sway: 4,
              duration: const Duration(milliseconds: 3400),
              child: Container(
                width: size * 0.68,
                height: size * 0.68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accentWarm.withValues(alpha: 0.35),
                      AppColors.card,
                    ],
                  ),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accentWarm.withValues(alpha: 0.25),
                      blurRadius: 40,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_rounded,
                  size: size * 0.36,
                  color: AppColors.textPrimary.withValues(alpha: 0.9),
                ),
              ),
            ),
            // Floating skill chips
            Positioned(
              top: size * 0.08,
              left: size * 0.02,
              child: FloatingMotion(
                amplitude: 9,
                sway: 5,
                rotate: 0.04,
                delay: const Duration(milliseconds: 200),
                duration: const Duration(milliseconds: 3000),
                child: const _FloatChip(label: 'Flutter', icon: Icons.flutter_dash),
              ),
            ),
            Positioned(
              top: size * 0.22,
              right: size * 0.0,
              child: FloatingMotion(
                amplitude: 11,
                sway: 6,
                rotate: -0.05,
                delay: const Duration(milliseconds: 700),
                duration: const Duration(milliseconds: 3400),
                child: const _FloatChip(label: 'BLoC', icon: Icons.hub_outlined),
              ),
            ),
            Positioned(
              bottom: size * 0.14,
              left: size * 0.0,
              child: FloatingMotion(
                amplitude: 10,
                sway: 7,
                rotate: 0.03,
                delay: const Duration(milliseconds: 450),
                duration: const Duration(milliseconds: 3700),
                child: const _FloatChip(
                  label: 'Firebase',
                  icon: Icons.local_fire_department_outlined,
                ),
              ),
            ),
            Positioned(
              bottom: size * 0.06,
              right: size * 0.08,
              child: FloatingMotion(
                amplitude: 8,
                sway: 5,
                rotate: -0.04,
                delay: const Duration(milliseconds: 900),
                duration: const Duration(milliseconds: 2900),
                child: const _FloatChip(label: 'Clean Arch', icon: Icons.architecture),
              ),
            ),
            // Twinkling stars
            Positioned(
              top: size * 0.16,
              right: size * 0.22,
              child: FloatingMotion(
                amplitude: 6,
                sway: 3,
                duration: const Duration(milliseconds: 2200),
                child: _Twinkle(size: 18, delay: Duration.zero),
              ),
            ),
            Positioned(
              bottom: size * 0.28,
              left: size * 0.18,
              child: FloatingMotion(
                amplitude: 5,
                sway: 4,
                delay: const Duration(milliseconds: 500),
                duration: const Duration(milliseconds: 2600),
                child: _Twinkle(size: 14, delay: const Duration(milliseconds: 400)),
              ),
            ),
            Positioned(
              top: size * 0.42,
              left: size * 0.08,
              child: FloatingMotion(
                amplitude: 7,
                sway: 3,
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 2400),
                child: _Twinkle(size: 12, delay: const Duration(milliseconds: 800)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatChip extends StatelessWidget {
  const _FloatChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.accent),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.label(fontSize: 12, weight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _Twinkle extends StatefulWidget {
  const _Twinkle({required this.size, required this.delay});

  final double size;
  final Duration delay;

  @override
  State<_Twinkle> createState() => _TwinkleState();
}

class _TwinkleState extends State<_Twinkle> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween(begin: 0.35, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      ),
      child: ScaleTransition(
        scale: Tween(begin: 0.85, end: 1.15).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Text(
          '✦',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: widget.size,
          ),
        ),
      ),
    );
  }
}

class _Cloud extends StatelessWidget {
  const _Cloud({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: width * 0.45,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(999),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withValues(alpha: 0.25),
            blurRadius: 16,
          ),
        ],
      ),
    );
  }
}

class SkillsMarquee extends StatefulWidget {
  const SkillsMarquee({super.key});

  @override
  State<SkillsMarquee> createState() => _SkillsMarqueeState();
}

class _SkillsMarqueeState extends State<SkillsMarquee> {
  late final ScrollController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
        if (!_controller.hasClients) return;
        final max = _controller.position.maxScrollExtent;
        final next = _controller.offset + 1.2;
        if (next >= max) {
          _controller.jumpTo(0);
        } else {
          _controller.jumpTo(next);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = [...heroContent.marqueeSkills, ...heroContent.marqueeSkills];

    return Transform.rotate(
      angle: -2.2 * math.pi / 180,
      child: Container(
        width: double.infinity,
        color: const Color(0xFF101018),
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: SizedBox(
          height: 28,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (_, _) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                '✦',
                style: AppTextStyles.label(color: AppColors.textPrimary),
              ),
            ),
            itemBuilder: (context, index) {
              return Center(
                child: Text(
                  items[index],
                  style: AppTextStyles.heading(
                    fontSize: 18,
                    letterSpacing: 0.2,
                    weight: FontWeight.w700,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
