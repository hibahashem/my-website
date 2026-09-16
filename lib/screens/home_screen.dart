import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../widgets/common_widgets.dart';
import '../widgets/portfolio_nav_bar.dart';
import '../widgets/sections/about_section.dart';
import '../widgets/sections/companies_section.dart';
import '../widgets/sections/contact_section.dart';
import '../widgets/sections/education_section.dart';
import '../widgets/sections/experience_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/projects_section.dart';
import '../widgets/sections/skills_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialSection});

  final String? initialSection;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();
  final _sectionKeys = <String, GlobalKey>{
    'hero': GlobalKey(),
    'about': GlobalKey(),
    'skills': GlobalKey(),
    'experience': GlobalKey(),
    'projects': GlobalKey(),
    'contact': GlobalKey(),
  };

  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final section = widget.initialSection;
      if (section != null) {
        scrollToSection(section);
      }
    });
  }

  void _onScroll() {
    final next = _scrollController.offset > 12;
    if (next != _scrolled) {
      setState(() => _scrolled = next);
    }
  }

  Future<void> scrollToSection(String id) async {
    final key = _sectionKeys[id];
    final ctx = key?.currentContext;
    if (ctx == null) return;
    await Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
      alignment: id == 'hero' ? 0 : 0.08,
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: AtmosphericBackground(
        scroll: _scrollController,
        child: Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                controller: _scrollController,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  children: [
                    KeyedSubtree(
                      key: _sectionKeys['hero'],
                      child: HeroSection(
                        onHireMe: () => scrollToSection('contact'),
                        onMyStory: () => scrollToSection('about'),
                      ),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['about'],
                      child: const AboutSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['skills'],
                      child: const SkillsSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['experience'],
                      child: const ExperienceSection(),
                    ),
                    KeyedSubtree(
                      key: _sectionKeys['projects'],
                      child: const ProjectsSection(),
                    ),
                    const CompaniesSection(),
                    const EducationSection(),
                    KeyedSubtree(
                      key: _sectionKeys['contact'],
                      child: ContactSection(onNavigate: scrollToSection),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PortfolioNavBar(
                scrolled: _scrolled,
                onNavigate: scrollToSection,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
