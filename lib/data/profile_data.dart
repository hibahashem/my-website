class AboutContent {
  const AboutContent({
    required this.bio,
    required this.stats,
  });

  final String bio;
  final List<StatItem> stats;
}

class StatItem {
  const StatItem({required this.label, required this.value});

  final String value;
  final String label;
}

class HeroContent {
  const HeroContent({
    required this.scriptPrefix,
    required this.name,
    required this.roleLine,
    required this.subheading,
    required this.marqueeSkills,
    required this.email,
    required this.linkedinUrl,
  });

  final String scriptPrefix;
  final String name;
  final String roleLine;
  final String subheading;
  final List<String> marqueeSkills;
  final String email;
  final String linkedinUrl;

}

class ContactContent {
  const ContactContent({
    required this.email,
    required this.linkedinUrl,
    required this.copyright,
  });

  final String email;
  final String linkedinUrl;
  final String copyright;
}

class EducationContent {
  const EducationContent({
    required this.degree,
    required this.institution,
    required this.years,
  });

  final String degree;
  final String institution;
  final String years;
}

const heroContent = HeroContent(
  scriptPrefix: "I'm",
  name: 'Hiba Hashem',
  roleLine: 'Senior Flutter Developer',
  subheading:
      'I build fast, reliable Flutter apps for Android & iOS — shipping scalable '
      'cross-platform products with Clean Architecture and modern state management.',
  marqueeSkills: [
    'Flutter',
    'Dart',
    'Clean Architecture',
    'BLoC',
    'Riverpod',
    'Firebase',
    'CI/CD',
    'REST APIs',
  ],
  email: 'hashemhiba4@gmail.com',
  // TODO: replace with real LinkedIn profile URL
  linkedinUrl: 'https://www.linkedin.com/in/TODO-hiba-hashem',
  // TODO: replace with real GitHub profile URL
);

const aboutContent = AboutContent(
  bio:
      "Hey there! I'm Hiba, a Senior Flutter Developer focused on building scalable, "
      'maintainable cross-platform apps. With Clean Architecture, modern state management, '
      "Firebase, and CI/CD, I'm on a mission to ship products that feel polished in production. "
      "Let's collaborate and bring your product vision to life!",
  stats: [
    StatItem(value: '4+', label: 'Years of Flutter Experience'),
    StatItem(value: '5', label: 'Companies Worked With'),
    StatItem(value: '2', label: 'Platforms — Android & iOS'),
  ],
);

const educationContent = EducationContent(
  degree: 'B.Sc. in Software Engineering',
  institution: 'College of Information Technology Engineering, Damascus University',
  years: '2019–2023',
);

const contactContent = ContactContent(
  email: 'hashemhiba4@gmail.com',
  // TODO: replace with real LinkedIn profile URL
  linkedinUrl: 'https://www.linkedin.com/in/hiba-hashem-3abab01b1/',
  // TODO: replace with real GitHub profile URL

  copyright: '© 2026 Hiba Hashem · All Rights Reserved',
);

/// Company pills shown under projects (from experience).
class CompanyLink {
  const CompanyLink({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;
}

const companiesWorkedWith = [
  CompanyLink(
    name: 'R-link',
    url: 'https://www.linkedin.com/company/rlinkbs',
  ),
  CompanyLink(
    name: 'Ridgetech',
    // TODO: replace with official site if available
    url: 'https://www.linkedin.com/company/ridgetech',
  ),
  CompanyLink(
    name: 'Madfox Solutions',
    url: 'https://www.linkedin.com/company/madfoxdxb',
  ),
  CompanyLink(
    name: 'SunriseIT',
    url: 'https://mysunriseit.com/en',
  ),
];
