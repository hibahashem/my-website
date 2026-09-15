import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ResponsivePadding extends StatelessWidget {
  const ResponsivePadding({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final horizontal = Breakpoints.isMobile(width)
            ? 20.0
            : Breakpoints.isTablet(width)
                ? 40.0
                : 80.0;
        return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontal),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: const Color(0xFFF5F5F5),
                fontWeight: FontWeight.w700,
                letterSpacing: -0.6,
              ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xFF9CA3AF),
                  height: 1.5,
                ),
          ),
        ],
      ],
    );
  }
}
