import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animate_do/animate_do.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() => runApp(const PortfolioApp());

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abhishek J Nair',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.spaceGroteskTextTheme().apply(
          bodyColor: Colors.white70,
          displayColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          secondary: Color(0xFF8B5CF6),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ItemScrollController _scrollController = ItemScrollController();

  final List<String> _sections = [
    'Home', 'About', 'Skills', 'Experience', 'Projects', 'Achievements', 'Contact'
  ];

  void scrollTo(int index) {
    _scrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: GlassNavbar(sections: _sections, onSelect: scrollTo),
      ),
      body: ScrollablePositionedList.builder(
        itemScrollController: _scrollController,
        itemCount: 8,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return  FadeInUp(duration: Duration(milliseconds: 800), child: HeroSection());
            case 1:
              return  FadeInUp(duration: Duration(milliseconds: 1000), child: GlassSection(child: AboutSection()));
            case 2:
              return  FadeInUp(duration: Duration(milliseconds: 1200), child: GlassSection(child: SkillsSection()));
            case 3:
              return  FadeInUp(duration: Duration(milliseconds: 1400), child: GlassSection(child: ExperienceSection()));
            case 4:
              return  FadeInUp(duration: Duration(milliseconds: 1600), child: GlassSection(child: ProjectsSection()));
            case 5:
              return  FadeInUp(duration: Duration(milliseconds: 1800), child: GlassSection(child: AchievementsSection()));
            case 6:
              return  FadeInUp(duration: Duration(milliseconds: 2000), child: GlassSection(child: ContactSection()));
            default:
              return  FadeInUp(duration: Duration(milliseconds: 2200), child: FooterSection());
          }
        },
      ),
    );
  }
}

class GlassNavbar extends StatelessWidget {
  final List<String> sections;
  final Function(int) onSelect;
  const GlassNavbar({super.key, required this.sections, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.25),
            border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.1))),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AJN', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 0; i < sections.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () => onSelect(i),
                        child: Text(sections[i],
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white70, fontWeight: FontWeight.w500)),
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GlassSection extends StatelessWidget {
  final Widget child;
  const GlassSection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(color: Colors.blueAccent.withOpacity(0.15), blurRadius: 20, offset: const Offset(0, 6)),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(padding: const EdgeInsets.all(24), child: child),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Text("Hi, I'm", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white70)),
            const SizedBox(height: 8),
            Text("Abhishek J Nair", style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Text(
              "Flutter Developer |  Building Cross-Platform Apps with Beautiful UI/UX and Robust Architecture",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About Me', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        const Text(
          "I’m a Flutter Developer with hands-on experience building and maintaining cross-platform applications. "
          "At ICICI Lombard, I developed new buying flows, API integrations, and responsive UI/UX components that improved customer engagement by 8% "
          "and reduced app crashes by 2.5%. Passionate about clean code, performance optimization, and delightful user experiences.",
        ),
        const SizedBox(height: 20),
        Text('Education', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Text("B.Tech (CSE) - Vellore Institute of Technology, Bhopal (2023) | CGPA: 8.6/10"),
        const Text("Class XII - Campion School, Bhopal (2019) | 72.4%"),
        const Text("Class X - Campion School, Bhopal (2017) | 10/10"),
      ],
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final skills = [
      "Flutter", "Dart", "Firebase", "REST API Integration", "State Management (Bloc, Riverpod)",
      "OOPs", "MVVM", "C++", "AI & ML", "AWS Cloud", "UI/UX Design"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Wrap(spacing: 10, runSpacing: 10, children: skills.map((s) => Chip(label: Text(s))).toList()),
      ],
    );
  }
}

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Experience', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      _tile("ICICI Lombard GIC Ltd.", "Associate Software Engineer | Aug 2023 – Present", [
        "Developing and maintaining cross-platform functionality using Flutter and Dart.",
        "Implemented buying flow and API integration; reduced Crashlytics crashes by 2.5%.",
        "Improved user engagement by 8% and sales by 10% through better UI/UX."
      ]),
      _tile("ICICI Lombard GIC Ltd.", "Flutter Developer Intern | Feb 2023 – Aug 2023", [
        "Built new buying flow with validation logic and payment integration."
      ]),
      _tile("LetsGrowMore", "Data Science Intern | Jun 2022 – Jul 2022", [
        "Created image-to-pencil sketch and decision tree-based predictive model."
      ]),
      _tile("The Sparks Foundation", "Web Developer Intern | May 2022 – Jun 2022", [
        "Developed Basic Banking and Payment Gateway Integration websites."
      ]),
    ]);
  }

  Widget _tile(String org, String role, List<String> bullets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(org, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(role, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        for (final b in bullets) Text("• $b"),
      ]),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final projects = [
      ["Watch Store App", "E-commerce Flutter app with cart, wishlist & payment integration", "https://github.com/DarkTitan007/watch_store_app"],
      ["Movie Profiling App", "Browse and view movie details (Flutter)", "https://github.com/DarkTitan007/Movie_App"],
      ["Face Recognition using ML", "Real-time face recognition model with pre-processed datasets", "https://github.com/DarkTitan007/Face_Recog_WorkShop_Model"],
      ["Data Cleaning in NLP", "Text preprocessing and normalization for NLP tasks", "https://github.com/DarkTitan007/Data_Cleaning_NLP"],
      ["Basic Banking Website", "Simple banking site with transaction logs and payment gateway", "https://github.com/DarkTitan007/Basic-Banking-SystemGRIPMAY2022"],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Projects', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ...projects.map((p) => _projectCard(context, p[0], p[1], p[2])).toList(),
      ],
    );
  }

  Widget _projectCard(BuildContext context, String title, String desc, String link) {
    return Card(
      color: Colors.white.withOpacity(0.05),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: IconButton(icon: const Icon(Icons.open_in_new), onPressed: () async => await launchUrl(Uri.parse(link))),
      ),
    );
  }
}

class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});
  @override
  Widget build(BuildContext context) {
    final achievements = [
      "Certificate of Appreciation – Face Recognition using ML (Coding Blocks Club, VIT Bhopal)",
      "5⭐ C++ and Python coder on HackerRank",
      "Featured in Economic Times Campus Stars 2022–23 (Interviewed by Zerodha CTO)",
      "Kshitij India 2022 – Reached Stage 2 (IIT Kharagpur)",
      "Student Coordinator, Artillegence Club (AI/ML)",
      "Campus Ambassador – National Engineering Olympiad",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Achievements', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        for (final a in achievements) Text("• $a"),
      ],
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Contact', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      const Text("📧 Email: abhisheknair366@gmail.com"),
      const Text("📞 Phone: +91 7879973072"),
      const SizedBox(height: 10),
      Row(children: [
        IconButton(icon: const Icon(Icons.link), onPressed: () async => await launchUrl(Uri.parse("https://www.linkedin.com/in/abhishek-j-nair-23991b227/"))),
        IconButton(icon: const Icon(Icons.code), onPressed: () async => await launchUrl(Uri.parse("https://github.com/DarkTitan007"))),
      ]),
    ]);
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
          child: Text("© ${DateTime.now().year} Abhishek J Nair — Built with Flutter",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white54))),
    );
  }
}
