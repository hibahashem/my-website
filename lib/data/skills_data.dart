class SkillCategory {
  const SkillCategory({
    required this.title,
    required this.skills,
  });

  final String title;
  final List<String> skills;
}

const List<SkillCategory> skillCategories = [
  SkillCategory(
    title: 'Languages & Frameworks',
    skills: ['Flutter', 'Dart'],
  ),
  SkillCategory(
    title: 'Architecture',
    skills: ['Clean Architecture', 'MVC', 'MVVM'],
  ),
  SkillCategory(
    title: 'State Management',
    skills: ['BLoC', 'Provider', 'Riverpod', 'GetX'],
  ),
  SkillCategory(
    title: 'Backend & Integrations',
    skills: [
      'REST APIs',
      'Firebase Auth',
      'Firestore',
      'Analytics',
      'Crashlytics',
      'FCM',
      'Payment Gateways',
      'Third-Party SDKs',
    ],
  ),
  SkillCategory(
    title: 'DevOps & Tooling',
    skills: [
      'Git',
      'GitHub',
      'GitLab',
      'Codemagic CI/CD',
      'GitHub Actions',
      'Mason Bricks',
    ],
  ),
  SkillCategory(
    title: 'Practices',
    skills: [
      'Agile/Scrum',
      'Code Review',
      'Testing & Debugging',
      'Clean Code',
    ],
  ),
];
