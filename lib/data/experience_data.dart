class ExperienceEntry {
  const ExperienceEntry({
    required this.role,
    required this.company,
    required this.dates,
    required this.highlights,
  });

  final String role;
  final String company;
  final String dates;
  final List<String> highlights;
}

/// Newest first.
const List<ExperienceEntry> experienceEntries = [
  ExperienceEntry(
    role: 'Senior Mobile Application Developer',
    company: 'R-link',
    dates: 'Feb 2025–Present',
    highlights: [
      'Built and maintained scalable cross-platform apps in Flutter/Dart for Android & iOS',
      'Implemented BLoC/Provider/Riverpod for maintainable, testable architecture',
      'Integrated Firebase, REST APIs, payment gateways, and third-party SDKs',
      'Set up CI/CD with Codemagic and built reusable packages with Mason Bricks',
    ],
  ),
  ExperienceEntry(
    role: 'Mobile Application Developer',
    company: 'Ridgetech',
    dates: 'Aug 2024–Feb 2025',
    highlights: [
      'Implemented Firebase Authentication and push notifications (FCM)',
      'Translated UI/UX designs into intuitive Flutter interfaces',
      'Worked across GetX and BLoC state management patterns',
    ],
  ),
  ExperienceEntry(
    role: 'Mobile Application Developer',
    company: 'Madfox Solutions',
    dates: 'Jan 2023–Jan 2024',
    highlights: [
      'Built and maintained production Flutter apps for real-world users',
      'Integrated REST APIs, Firebase, and third-party libraries',
      'Resolved live production issues and shipped performance improvements',
    ],
  ),
  ExperienceEntry(
    role: 'Mobile Application Developer',
    company: 'SunriseIT',
    dates: 'Jul 2022–Nov 2022',
    highlights: [
      'Connected apps to REST APIs for real-time data handling',
      'Improved app speed/responsiveness through optimization',
      'Implemented structured state management for maintainability',
    ],
  ),
];
