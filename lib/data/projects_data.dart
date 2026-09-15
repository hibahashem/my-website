class Project {
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    this.imageAsset,
    this.repoUrl,
    this.liveUrl,
    this.caseStudy,
  });

  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final String? imageAsset;
  final String? repoUrl;
  final String? liveUrl;

  /// Longer case-study copy for the detail screen (optional for now).
  final String? caseStudy;
}

final List<Project> projects = [
  // TODO: replace with real project
  const Project(
    id: 'placeholder-1',
    title: 'Cross-Platform Commerce App',
    description:
        'Placeholder case study for a scalable Flutter commerce experience with clean architecture and payment flows.',
    techStack: ['Flutter', 'Dart', 'BLoC', 'Firebase', 'Stripe'],
    caseStudy:
        'TODO: Expand this case study with problem statement, architecture decisions, '
        'screenshots, and measurable outcomes once real project details are available.',
  ),
  // TODO: replace with real project
  const Project(
    id: 'placeholder-2',
    title: 'Realtime Ops Dashboard',
    description:
        'Placeholder project highlighting Firebase sync, push notifications, and modular feature packages.',
    techStack: ['Flutter', 'Riverpod', 'FCM', 'Codemagic'],
    caseStudy:
        'TODO: Expand this case study with problem statement, architecture decisions, '
        'screenshots, and measurable outcomes once real project details are available.',
  ),
  // TODO: replace with real project
  const Project(
    id: 'placeholder-3',
    title: 'Healthcare Companion App',
    description:
        'Placeholder entry for a production Flutter app focused on reliability, accessibility, and CI/CD.',
    techStack: ['Flutter', 'Provider', 'REST APIs', 'GitHub Actions'],
    caseStudy:
        'TODO: Expand this case study with problem statement, architecture decisions, '
        'screenshots, and measurable outcomes once real project details are available.',
  ),
];

Project? projectById(String id) {
  for (final project in projects) {
    if (project.id == id) return project;
  }
  return null;
}
