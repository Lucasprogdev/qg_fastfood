import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/contact_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const QGFastfoodApp());
}

class QGFastfoodApp extends StatelessWidget {
  const QGFastfoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QG Fastfood',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        splashFactory: NoSplash.splashFactory,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        fontFamily: 'Outfit',
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFFF6B1A),
          surface: Color(0xFF111111),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  int _previousIndex = 0;

  // Nav pill animations
  late List<AnimationController> _navControllers;
  late List<Animation<double>> _scaleAnimations;

  // Fade transition animation
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final _navItems = const [
    _NavItem(icon: Icons.home_rounded, label: 'Accueil'),
    _NavItem(icon: Icons.restaurant_menu_rounded, label: 'Menu'),
    _NavItem(icon: Icons.star_rounded, label: 'Avis'),
    _NavItem(icon: Icons.location_on_rounded, label: 'Contact'),
  ];

  @override
  void initState() {
    super.initState();

    // Nav pill controllers
    _navControllers = List.generate(
      _navItems.length,
      (i) => AnimationController(
        duration: const Duration(milliseconds: 200),
        vsync: this,
      ),
    );
    _scaleAnimations = _navControllers
        .map((c) => Tween<double>(begin: 1.0, end: 0.88).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();
    _navControllers[0].forward();

    // Fade controller
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 320),
      vsync: this,
      value: 1.0, // starts fully visible
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    for (final c in _navControllers) {
      c.dispose();
    }
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _navigateTo(int index) async {
    if (index == _currentIndex) return;

    // Fade out
    await _fadeController.animateTo(0.0,
        duration: const Duration(milliseconds: 160), curve: Curves.easeIn);

    // Switch screen
    _navControllers[_currentIndex].reverse();
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
    _navControllers[index].forward();
    HapticFeedback.selectionClick();

    // Fade in
    _fadeController.animateTo(1.0,
        duration: const Duration(milliseconds: 280), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onNavigate: _navigateTo),
      const MenuScreen(),
      const ReviewsScreen(),
      const ContactScreen(),
    ];

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
      ),
      bottomNavigationBar: _LiquidGlassNavBar(
        currentIndex: _currentIndex,
        onTap: _navigateTo,
        items: _navItems,
        scaleAnimations: _scaleAnimations,
      ),
    );
  }
}

// ─── DATA CLASS ───────────────────────────────────────────────
class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ─── LIQUID GLASS NAV BAR ─────────────────────────────────────
class _LiquidGlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<_NavItem> items;
  final List<Animation<double>> scaleAnimations;

  const _LiquidGlassNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    required this.scaleAnimations,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, bottomPadding + 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            decoration: BoxDecoration(
              // Liquid glass: calque semi-transparent avec légère teinte blanche
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.14),
                  Colors.white.withOpacity(0.07),
                ],
              ),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: Colors.white.withOpacity(0.18),
                width: 0.8,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 40,
                  offset: const Offset(0, 12),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.04),
                  blurRadius: 1,
                  offset: const Offset(0, -0.5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  items.length,
                  (i) => _NavBarItem(
                    item: items[i],
                    isSelected: currentIndex == i,
                    scaleAnimation: scaleAnimations[i],
                    onTap: () => onTap(i),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── INDIVIDUAL NAV ITEM ──────────────────────────────────────
class _NavBarItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final Animation<double> scaleAnimation;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.scaleAnimation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: isSelected ? scaleAnimation.value : 1.0,
          child: child,
        ),
        child: SizedBox(
          width: 70,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pill indicator + icon
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? const Color(0xFFFF6B1A).withOpacity(0.18)
                      : Colors.transparent,
                  border: isSelected
                      ? Border.all(
                          color: const Color(0xFFFF6B1A).withOpacity(0.35),
                          width: 0.8,
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: const Color(0xFFFF6B1A).withOpacity(0.25),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ]
                      : null,
                ),
                child: AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutBack,
                  child: Icon(
                    item.icon,
                    size: 22,
                    color: isSelected
                        ? const Color(0xFFFF6B1A)
                        : Colors.white.withOpacity(0.45),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              // Label
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 250),
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 10.5,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFFFF6B1A)
                      : Colors.white.withOpacity(0.4),
                  letterSpacing: 0.2,
                ),
                child: Text(item.label, maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
        ),
      ),
    );
  }
}