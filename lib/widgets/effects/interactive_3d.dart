import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

/// Mouse-driven 3D tilt with perspective.
class Tilt3D extends StatefulWidget {
  const Tilt3D({
    super.key,
    required this.child,
    this.maxTilt = 0.14,
    this.perspective = 0.0012,
  });

  final Widget child;
  final double maxTilt;
  final double perspective;

  @override
  State<Tilt3D> createState() => _Tilt3DState();
}

class _Tilt3DState extends State<Tilt3D> {
  double _rx = 0;
  double _ry = 0;

  void _update(Offset local, Size size) {
    final nx = ((local.dx / size.width) * 2 - 1).clamp(-1.0, 1.0);
    final ny = ((local.dy / size.height) * 2 - 1).clamp(-1.0, 1.0);
    setState(() {
      _ry = nx * widget.maxTilt;
      _rx = -ny * widget.maxTilt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(
          constraints.maxWidth.isFinite ? constraints.maxWidth : 300,
          constraints.maxHeight.isFinite ? constraints.maxHeight : 300,
        );
        return MouseRegion(
          onHover: (e) => _update(e.localPosition, size),
          onExit: (_) => setState(() {
            _rx = 0;
            _ry = 0;
          }),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 140),
            curve: Curves.easeOut,
            transformAlignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, widget.perspective)
              ..rotateX(_rx)
              ..rotateY(_ry),
            child: widget.child,
          ),
        );
      },
    );
  }
}

/// Flutter-logo particles that tumble behind the cursor.
class CursorTrail extends StatefulWidget {
  const CursorTrail({super.key, required this.child, this.maxParticles = 14});

  final Widget child;
  final int maxParticles;

  @override
  State<CursorTrail> createState() => _CursorTrailState();
}

class _CursorTrailState extends State<CursorTrail>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tick;
  final List<_TrailDot> _dots = [];
  Offset? _pointer;
  int _frame = 0;

  @override
  void initState() {
    super.initState();
    _tick = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 16),
    )..addListener(() {
        if (_dots.isEmpty) return;
        setState(() {
          for (final d in _dots) {
            d.life -= 0.035;
            d.angle += d.spin;
            d.y += 0.4;
          }
          _dots.removeWhere((d) => d.life <= 0);
        });
      });
    _tick.repeat();
  }

  @override
  void dispose() {
    _tick.dispose();
    super.dispose();
  }

  void _onMove(PointerEvent e) {
    _pointer = e.localPosition;
    _frame++;
    if (_frame % 3 != 0) return;
    if (_dots.length >= widget.maxParticles) _dots.removeAt(0);
    setState(() {
      _dots.add(
        _TrailDot(
          x: e.localPosition.dx,
          y: e.localPosition.dy,
          angle: math.Random().nextDouble() * math.pi,
          spin: (math.Random().nextDouble() - 0.5) * 0.25,
          life: 1,
          size: 10 + math.Random().nextDouble() * 10,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerHover: _onMove,
      onPointerMove: _onMove,
      child: Stack(
        children: [
          widget.child,
          IgnorePointer(
            child: CustomPaint(
              painter: _TrailPainter(dots: _dots, pointer: _pointer),
              size: Size.infinite,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrailDot {
  _TrailDot({
    required this.x,
    required this.y,
    required this.angle,
    required this.spin,
    required this.life,
    required this.size,
  });

  double x;
  double y;
  double angle;
  double spin;
  double life;
  double size;
}

class _TrailPainter extends CustomPainter {
  _TrailPainter({required this.dots, required this.pointer});

  final List<_TrailDot> dots;
  final Offset? pointer;

  @override
  void paint(Canvas canvas, Size size) {
    for (final d in dots) {
      final paint = Paint()
        ..color = AppColors.accent.withValues(alpha: d.life * 0.55);
      canvas.save();
      canvas.translate(d.x, d.y);
      canvas.rotate(d.angle);
      final r = d.size / 2;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset.zero, width: d.size, height: d.size),
          Radius.circular(r * 0.35),
        ),
        paint,
      );
      canvas.drawCircle(Offset(-r * 0.15, -r * 0.15), r * 0.28, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter oldDelegate) => true;
}

/// Morphing liquid blob behind / as avatar plate.
class LiquidBlob extends StatefulWidget {
  const LiquidBlob({
    super.key,
    required this.size,
    this.child,
    this.tilt = true,
    this.colors = const [AppColors.accentWarm, AppColors.accent, AppColors.accentPink],
  });

  final double size;
  final Widget? child;
  final bool tilt;
  final List<Color> colors;

  @override
  State<LiquidBlob> createState() => _LiquidBlobState();
}

class _LiquidBlobState extends State<LiquidBlob>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5200),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = _c.value * math.pi * 2;
        Widget painted = CustomPaint(
          size: Size.square(widget.size),
          painter: _BlobPainter(t: t, colors: widget.colors),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: Center(child: child),
          ),
        );
        if (widget.tilt) {
          painted = Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(math.sin(t) * 0.08)
              ..rotateY(math.cos(t * 0.9) * 0.1),
            child: painted,
          );
        }
        return painted;
      },
      child: widget.child,
    );
  }
}

class _BlobPainter extends CustomPainter {
  _BlobPainter({required this.t, required this.colors});

  final double t;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.38;
    final path = Path();
    const steps = 48;
    for (var i = 0; i <= steps; i++) {
      final a = (i / steps) * math.pi * 2;
      final wobble =
          1 +
          0.12 * math.sin(a * 3 + t) +
          0.08 * math.cos(a * 5 - t * 1.3);
      final x = cx + math.cos(a) * r * wobble;
      final y = cy + math.sin(a) * r * wobble;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          colors[0].withValues(alpha: 0.55),
          colors[1].withValues(alpha: 0.28),
          colors[2].withValues(alpha: 0.05),
        ],
      ).createShader(Rect.fromCircle(center: Offset(cx, cy), radius: r * 1.4));
    canvas.drawPath(path, paint);
    canvas.drawPath(
      path,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = Colors.white.withValues(alpha: 0.18),
    );
  }

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) =>
      oldDelegate.t != t;
}

/// Draggable holographic resume plate.
class HologramCv extends StatefulWidget {
  const HologramCv({super.key, required this.onOpen, this.width = 168});

  final VoidCallback onOpen;
  final double width;

  @override
  State<HologramCv> createState() => _HologramCvState();
}

class _HologramCvState extends State<HologramCv>
    with SingleTickerProviderStateMixin {
  late final AnimationController _spin;
  double _dragY = 0.18;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = widget.width * 1.35;
    return GestureDetector(
      onHorizontalDragUpdate: (d) {
        setState(() => _dragY += d.delta.dx * 0.008);
      },
      onTap: widget.onOpen,
      child: AnimatedBuilder(
        animation: _spin,
        builder: (context, child) {
          final auto = math.sin(_spin.value * math.pi * 2) * 0.12;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX(-0.35)
              ..rotateY(_dragY + auto),
            child: child,
          );
        },
        child: Container(
          width: widget.width,
          height: h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xFF7DF9FF).withValues(alpha: 0.55),
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF0B3D4A).withValues(alpha: 0.85),
                const Color(0xFF1A1A2E).withValues(alpha: 0.9),
                const Color(0xFF3D1A5C).withValues(alpha: 0.75),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF7DF9FF).withValues(alpha: 0.28),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              children: [
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: const SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CV',
                        style: AppTextStyles.heading(
                          fontSize: 22,
                          color: const Color(0xFF7DF9FF),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Hiba Hashem',
                        style: AppTextStyles.label(
                          fontSize: 12,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                      Text(
                        'Senior Flutter Dev',
                        style: AppTextStyles.mono(
                          fontSize: 10,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF7DF9FF).withValues(alpha: 0),
                              const Color(0xFF7DF9FF),
                              const Color(0xFF7DF9FF).withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Drag · Tap to open',
                        style: AppTextStyles.mono(
                          fontSize: 9,
                          color: const Color(0xFF7DF9FF).withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                // scan line
                AnimatedBuilder(
                  animation: _spin,
                  builder: (context, _) {
                    final y = (_spin.value * h);
                    return Positioned(
                      top: y,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 18,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF7DF9FF).withValues(alpha: 0),
                              const Color(0xFF7DF9FF).withValues(alpha: 0.18),
                              const Color(0xFF7DF9FF).withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Skills icons that orbit / get pulled toward the cursor.
class MagneticOrbit extends StatefulWidget {
  const MagneticOrbit({
    super.key,
    required this.labels,
    this.height = 280,
  });

  final List<String> labels;
  final double height;

  @override
  State<MagneticOrbit> createState() => _MagneticOrbitState();
}

class _MagneticOrbitState extends State<MagneticOrbit>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  Offset _cursor = Offset.zero;
  bool _inside = false;
  late List<_OrbitNode> _nodes;

  @override
  void initState() {
    super.initState();
    final rnd = math.Random(7);
    _nodes = [
      for (var i = 0; i < widget.labels.length; i++)
        _OrbitNode(
          label: widget.labels[i],
          angle: (i / widget.labels.length) * math.pi * 2,
          radius: 70 + rnd.nextDouble() * 55,
          phase: rnd.nextDouble() * math.pi * 2,
        ),
    ];
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: MouseRegion(
        onEnter: (_) => setState(() => _inside = true),
        onExit: (_) => setState(() => _inside = false),
        onHover: (e) => setState(() => _cursor = e.localPosition),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) {
            return LayoutBuilder(
              builder: (context, constraints) {
                final center = Offset(
                  constraints.maxWidth / 2,
                  constraints.maxHeight / 2,
                );
                final t = _c.value * math.pi * 2;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight),
                      painter: _ConstellationPainter(
                        points: [
                          for (final n in _nodes) _nodePos(n, center, t),
                        ],
                        focus: _inside ? _cursor : null,
                      ),
                    ),
                    for (final n in _nodes)
                      _OrbitNodeView(
                        label: n.label,
                        position: () {
                          var pos = _nodePos(n, center, t);
                          if (_inside) pos += (_cursor - pos) * 0.18;
                          return pos;
                        }(),
                        phase: n.phase,
                        t: t,
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Offset _nodePos(_OrbitNode n, Offset center, double t) {
    final a = n.angle + t * 0.35;
    final r = n.radius + math.sin(t + n.phase) * 8;
    return Offset(
      center.dx + math.cos(a) * r,
      center.dy + math.sin(a) * r * 0.72,
    );
  }
}

class _OrbitNode {
  _OrbitNode({
    required this.label,
    required this.angle,
    required this.radius,
    required this.phase,
  });

  final String label;
  final double angle;
  final double radius;
  final double phase;
}

class _OrbitNodeView extends StatelessWidget {
  const _OrbitNodeView({
    required this.label,
    required this.position,
    required this.phase,
    required this.t,
  });

  final String label;
  final Offset position;
  final double phase;
  final double t;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 36,
      top: position.dy - 16,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(math.sin(t + phase) * 0.25)
          ..rotateX(math.cos(t + phase) * 0.15),
        child: _OrbitChip(label: label),
      ),
    );
  }
}

class _OrbitChip extends StatelessWidget {
  const _OrbitChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: AppColors.accent.withValues(alpha: 0.15),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        label,
        style: AppTextStyles.label(fontSize: 11, weight: FontWeight.w600),
      ),
    );
  }
}

class _ConstellationPainter extends CustomPainter {
  _ConstellationPainter({required this.points, this.focus});

  final List<Offset> points;
  final Offset? focus;

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.22)
      ..strokeWidth = 1;
    for (var i = 0; i < points.length; i++) {
      final a = points[i];
      final b = points[(i + 1) % points.length];
      canvas.drawLine(a, b, line);
      if (focus != null && (a - focus!).distance < 90) {
        canvas.drawLine(
          a,
          focus!,
          Paint()
            ..color = AppColors.accentWarm.withValues(alpha: 0.45)
            ..strokeWidth = 1.2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _ConstellationPainter oldDelegate) => true;
}

/// Project card frosted panel that peels into shards on hover.
class GlassShardReveal extends StatefulWidget {
  const GlassShardReveal({
    super.key,
    required this.child,
    required this.reveal,
  });

  final Widget child;
  final Widget reveal;

  @override
  State<GlassShardReveal> createState() => _GlassShardRevealState();
}

class _GlassShardRevealState extends State<GlassShardReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  static const _alignments = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 520),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _c.forward(),
      onExit: (_) => _c.reverse(),
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = Curves.easeOutCubic.transform(_c.value);
          return LayoutBuilder(
            builder: (context, constraints) {
              final cover = SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: widget.child,
              );
              return Stack(
                fit: StackFit.expand,
                children: [
                  widget.reveal,
                  for (var i = 0; i < 4; i++)
                    Opacity(
                      opacity: (1 - t * 1.1).clamp(0.0, 1.0),
                      child: Transform(
                        alignment: _alignments[i],
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.002)
                          ..translateByDouble(
                            (i.isEven ? -1.0 : 1.0) * 48 * t,
                            (i < 2 ? -1.0 : 1.0) * 36 * t,
                            28 * t,
                            1,
                          )
                          ..rotateZ((i - 1.5) * 0.2 * t)
                          ..rotateY((i - 1.5) * 0.15 * t),
                        child: ClipRect(
                          child: Align(
                            alignment: _alignments[i],
                            widthFactor: 0.5,
                            heightFactor: 0.5,
                            child: cover,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Horizontal fling turntable of project discs.
class ProjectTurntable extends StatefulWidget {
  const ProjectTurntable({
    super.key,
    required this.items,
    required this.onSelect,
  });

  final List<({String title, Color glow, String id})> items;
  final ValueChanged<String> onSelect;

  @override
  State<ProjectTurntable> createState() => _ProjectTurntableState();
}

class _ProjectTurntableState extends State<ProjectTurntable>
    with SingleTickerProviderStateMixin {
  late final AnimationController _inertia;
  double _angle = 0;
  double _velocity = 0;

  @override
  void initState() {
    super.initState();
    _inertia = AnimationController.unbounded(vsync: this)
      ..addListener(() {
        setState(() {
          _angle = _inertia.value;
          _velocity *= 0.96;
          if (_velocity.abs() > 0.0005) {
            _inertia.value = _angle + _velocity;
          }
        });
      });
    _inertia.value = 0;
  }

  @override
  void dispose() {
    _inertia.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final n = widget.items.length;
    final width = MediaQuery.sizeOf(context).width;
    final scale = (width / 900).clamp(0.55, 1.0);
    final tableHeight = 260.0 * scale;
    final orbit = 120.0 * scale;
    final plate = 320.0 * scale;
    final cardW = 140.0 * scale;
    final cardH = 160.0 * scale;

    return Column(
      children: [
        ClipRect(
          child: GestureDetector(
            onHorizontalDragUpdate: (d) {
              setState(() {
                _angle += d.delta.dx * 0.008;
                _velocity = d.delta.dx * 0.0009;
              });
            },
            onHorizontalDragEnd: (_) => _inertia.value = _angle,
            child: SizedBox(
              height: tableHeight,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.hardEdge,
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateX(1.15),
                    child: Container(
                      width: plate,
                      height: plate,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border, width: 2),
                        gradient: RadialGradient(
                          colors: [
                            AppColors.card,
                            AppColors.background.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
                  for (var i = 0; i < n; i++)
                    _TurntableItem(
                      angle: _angle + (i / n) * math.pi * 2,
                      item: widget.items[i],
                      onTap: () => widget.onSelect(widget.items[i].id),
                      orbit: orbit,
                      width: cardW,
                      height: cardH,
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Drag to spin · tap a project',
          style: AppTextStyles.mono(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _TurntableItem extends StatelessWidget {
  const _TurntableItem({
    required this.angle,
    required this.item,
    required this.onTap,
    required this.orbit,
    required this.width,
    required this.height,
  });

  final double angle;
  final ({String title, Color glow, String id}) item;
  final VoidCallback onTap;
  final double orbit;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final x = math.sin(angle) * orbit;
    final z = math.cos(angle);
    final scale = 0.75 + 0.25 * ((z + 1) / 2);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..translateByDouble(x, -20 * z, z * 40, 1)
        ..scaleByDouble(scale, scale, 1, 1),
      child: Opacity(
        opacity: (0.45 + 0.55 * ((z + 1) / 2)).clamp(0.4, 1),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: item.glow.withValues(alpha: 0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone_iphone_rounded, color: item.glow, size: 36 * (width / 140)),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.label(
                    fontSize: 12,
                    weight: FontWeight.w600,
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

/// Flip-book style experience card.
class FlipBookCard extends StatefulWidget {
  const FlipBookCard({
    super.key,
    required this.front,
    this.index = 0,
  });

  final Widget front;
  final int index;

  @override
  State<FlipBookCard> createState() => _FlipBookCardState();
}

class _FlipBookCardState extends State<FlipBookCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  bool _flipped = false;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() => _flipped = !_flipped);
    if (_flipped) {
      _c.forward();
    } else {
      _c.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggle,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, child) {
          final t = Curves.easeInOutCubic.transform(_c.value);
          // page-turn feel
          final rotY = t * math.pi;
          final depth = math.sin(t * math.pi) * 18;
          return Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.0014)
              ..translateByDouble(0, -widget.index * 2.0 + depth * 0.2, depth, 1)
              ..rotateY(-rotY * 0.35)
              ..rotateZ(t * 0.04),
            child: child,
          );
        },
        child: widget.front,
      ),
    );
  }
}

/// Scroll-linked depth shift for background layers.
class DepthScrollLayer extends StatelessWidget {
  const DepthScrollLayer({
    super.key,
    required this.scroll,
    required this.factor,
    required this.child,
  });

  final ScrollController scroll;
  final double factor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scroll,
      builder: (context, child) {
        final offset = scroll.hasClients ? scroll.offset * factor : 0.0;
        return Transform.translate(
          offset: Offset(0, offset),
          child: child,
        );
      },
      child: child,
    );
  }
}

/// Ink-sphere bloom when a section becomes visible.
class InkDropReveal extends StatefulWidget {
  const InkDropReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<InkDropReveal> createState() => _InkDropRevealState();
}

class _InkDropRevealState extends State<InkDropReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  bool _armed = false;
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _attach());
  }

  void _attach() {
    if (!mounted) return;
    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_check);
    _check();
  }

  void _check() {
    if (!mounted || _armed) return;
    final box = context.findRenderObject();
    if (box is! RenderBox || !box.hasSize) return;
    final pos = box.localToGlobal(Offset.zero);
    final h = MediaQuery.sizeOf(context).height;
    if (pos.dy < h * 0.85) {
      _armed = true;
      _position?.removeListener(_check);
      Future<void>.delayed(widget.delay, () {
        if (mounted) _c.forward();
      });
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (context, child) {
        final t = Curves.easeOutCubic.transform(_c.value);
        return ClipPath(
          clipper: _InkClipper(progress: t),
          child: Opacity(
            opacity: t.clamp(0.15, 1),
            child: Transform.scale(
              scale: 0.92 + 0.08 * t,
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _InkClipper extends CustomClipper<Path> {
  _InkClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    final r = progress * size.longestSide * 0.85;
    return Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width * 0.5, size.height * 0.4),
          radius: r,
        ),
      );
  }

  @override
  bool shouldReclip(covariant _InkClipper oldClipper) =>
      oldClipper.progress != progress;
}
