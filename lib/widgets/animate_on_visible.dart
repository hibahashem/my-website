import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Fades + slides once the widget first enters the viewport.
class AnimateOnVisible extends StatefulWidget {
  const AnimateOnVisible({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 650),
    this.slideY = 0.12,
    this.slideX = 0,
    this.scaleBegin = 0.96,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final double slideY;
  final double slideX;
  final double scaleBegin;

  @override
  State<AnimateOnVisible> createState() => _AnimateOnVisibleState();
}

class _AnimateOnVisibleState extends State<AnimateOnVisible> {
  bool _visible = false;
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _attach());
  }

  void _attach() {
    if (!mounted) return;
    _position = Scrollable.maybeOf(context)?.position;
    _position?.addListener(_checkVisibility);
    _checkVisibility();
  }

  void _checkVisibility() {
    if (!mounted || _visible) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final position = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final isInView =
        position.dy < screenHeight * 0.88 && position.dy + size.height > 24;

    if (isInView) {
      setState(() => _visible = true);
      _position?.removeListener(_checkVisibility);
    }
  }

  @override
  void dispose() {
    _position?.removeListener(_checkVisibility);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child
        .animate(target: _visible ? 1 : 0)
        .fadeIn(
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOut,
        )
        .slideY(
          begin: widget.slideY,
          end: 0,
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOutCubic,
        )
        .slideX(
          begin: widget.slideX,
          end: 0,
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOutCubic,
        )
        .scale(
          begin: Offset(widget.scaleBegin, widget.scaleBegin),
          end: const Offset(1, 1),
          duration: widget.duration,
          delay: widget.delay,
          curve: Curves.easeOutCubic,
        );
  }
}
