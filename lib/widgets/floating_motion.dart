import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Continuous soft bob + optional sway (Dribbble-style float).
class FloatingMotion extends StatefulWidget {
  const FloatingMotion({
    super.key,
    required this.child,
    this.amplitude = 10,
    this.sway = 6,
    this.duration = const Duration(milliseconds: 3200),
    this.delay = Duration.zero,
    this.rotate = 0,
  });

  final Widget child;
  final double amplitude;
  final double sway;
  final Duration duration;
  final Duration delay;
  final double rotate; // max radians

  @override
  State<FloatingMotion> createState() => _FloatingMotionState();
}

class _FloatingMotionState extends State<FloatingMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(_controller.value);
        final dy = (t * 2 - 1) * widget.amplitude;
        final dx = math.sin(t * math.pi) * widget.sway;
        final rot = (t * 2 - 1) * widget.rotate;
        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.rotate(angle: rot, child: child),
        );
      },
      child: widget.child,
    );
  }
}

/// Pointer-driven parallax for a cluster of layers.
class ParallaxHover extends StatefulWidget {
  const ParallaxHover({
    super.key,
    required this.child,
    this.maxOffset = 18,
  });

  final Widget child;
  final double maxOffset;

  @override
  State<ParallaxHover> createState() => _ParallaxHoverState();
}

class _ParallaxHoverState extends State<ParallaxHover>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Offset _from = Offset.zero;
  Offset _to = Offset.zero;
  Offset _offset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 280),
    )..addListener(() {
        setState(() {
          _offset = Offset.lerp(
            _from,
            _to,
            Curves.easeOutCubic.transform(_controller.value),
          )!;
        });
      });
  }

  void _moveTo(Offset next) {
    _from = _offset;
    _to = next;
    _controller.forward(from: 0);
  }

  void _onHover(PointerEvent event, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final local = event.localPosition - center;
    final nx = (local.dx / (size.width / 2)).clamp(-1.0, 1.0);
    final ny = (local.dy / (size.height / 2)).clamp(-1.0, 1.0);
    _moveTo(Offset(nx * widget.maxOffset, ny * widget.maxOffset));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _onHover(e, size),
          onExit: (_) => _moveTo(Offset.zero),
          child: Transform.translate(offset: _offset, child: widget.child),
        );
      },
    );
  }
}
