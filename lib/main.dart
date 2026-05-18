import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const ResonateArchiveApp());
}

class Game {
  final String id;
  final String title;
  final String developer;
  final String coverUrl;
  final Color themeColor;

  const Game({
    required this.id,
    required this.title,
    required this.developer,
    required this.coverUrl,
    required this.themeColor,
  });
}

const List<Game> mockGames = [
  Game(
    id: 'g1',
    title: '去月球 (To the Moon)',
    developer: 'Freebird Games',
    coverUrl:
        'https://cdn.akamai.steamstatic.com/steam/apps/206440/capsule_616x353.jpg',
    themeColor: Color(0xFF8E7CFF),
  ),
  Game(
    id: 'g2',
    title: '我在七年后等你 (7 Years From Now)',
    developer: 'fumi',
    coverUrl:
        'https://shared.fastly.steamstatic.com/store_item_assets/steam/apps/1562920/header.jpg?t=1667899952',
    themeColor: Color(0xFF47C8FF),
  ),
  Game(
    id: 'g3',
    title: '尼尔：机械纪元 (NieR:Automata)',
    developer: 'PlatinumGames / Square Enix',
    coverUrl:
        'https://cdn.akamai.steamstatic.com/steam/apps/524220/capsule_616x353.jpg',
    themeColor: Color(0xFFD06BFF),
  ),
  Game(
    id: 'g4',
    title: '空洞骑士 (Hollow Knight)',
    developer: 'Team Cherry',
    coverUrl:
        'https://cdn.akamai.steamstatic.com/steam/apps/367520/capsule_616x353.jpg',
    themeColor: Color(0xFF5C89FF),
  ),
];

class ResonateArchiveApp extends StatelessWidget {
  const ResonateArchiveApp({super.key});

  @override
  Widget build(BuildContext context) {
    const accent = Color(0xFF7B61FF);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resonate Archive',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: accent,
          brightness: Brightness.dark,
          primary: accent,
          secondary: const Color(0xFF35D9FF),
          surface: const Color(0xFF111116),
        ),
      ),
      home: const GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A0A0F), Color(0xFF060608)],
          ),
        ),
        child: Stack(
          children: [
            ScrollConfiguration(
              behavior: const _NoGlowScrollBehavior(),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 120),
                itemCount: mockGames.length,
                itemBuilder: (context, index) {
                  final game = mockGames[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _GameCard(game: game),
                  );
                },
              ),
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _GlassHeader(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: _FloatingGlassNavBar(
                currentIndex: _currentIndex,
                onTap: (index) => setState(() => _currentIndex = index),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoGlowScrollBehavior extends MaterialScrollBehavior {
  const _NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}

class _GlassHeader extends StatelessWidget {
  const _GlassHeader();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.18),
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.12),
                width: 0.8,
              ),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 90,
              child: Center(
                child: Text(
                  'Resonate Archive',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                    fontSize: 22,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: const Color(0xFF7B61FF).withOpacity(0.55),
                        blurRadius: 16,
                      ),
                      Shadow(
                        color: const Color(0xFF35D9FF).withOpacity(0.25),
                        blurRadius: 28,
                      ),
                    ],
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

class _GameCard extends StatefulWidget {
  final Game game;

  const _GameCard({required this.game});

  @override
  State<_GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<_GameCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final game = widget.game;
    final borderRadius = BorderRadius.circular(16);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        // ignore: avoid_print
        print('Tapped game');
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 120),
        opacity: _pressed ? 0.9 : 1,
        child: Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                color: game.themeColor.withOpacity(0.22),
                blurRadius: 28,
                spreadRadius: 1.2,
                offset: const Offset(0, 12),
              ),
              const BoxShadow(
                color: Color(0x66000000),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: borderRadius,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  game.coverUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const ColoredBox(
                      color: Color(0xFF121218),
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (_, __, ___) => const ColoredBox(
                    color: Color(0xFF121218),
                    child: Center(
                      child: Icon(Icons.broken_image_outlined, color: Colors.white54),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.12),
                              Colors.black.withOpacity(0.42),
                              Colors.black.withOpacity(0.68),
                            ],
                          ),
                          border: Border(
                            top: BorderSide(
                              color: Colors.white.withOpacity(0.10),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    game.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.2,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    game.developer,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.72),
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.white.withOpacity(0.80),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingGlassNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _FloatingGlassNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.12),
                    Colors.white.withOpacity(0.04),
                  ],
                ),
                color: Colors.black.withOpacity(0.35),
                border: Border.all(
                  color: Colors.white.withOpacity(0.25),
                  width: 0.8,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF7B61FF).withOpacity(0.20),
                    blurRadius: 26,
                    offset: const Offset(0, 12),
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.36),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _NavItem(
                    icon: Icons.auto_awesome_mosaic_rounded,
                    label: 'Library',
                    active: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  const SizedBox(width: 2),
                  _NavItem(
                    icon: Icons.graphic_eq_rounded,
                    label: 'Resonate',
                    active: currentIndex == 1,
                    onTap: () => onTap(1),
                  ),
                  const SizedBox(width: 2),
                  _NavItem(
                    icon: Icons.settings_rounded,
                    label: 'Settings',
                    active: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = active
        ? const Color(0xFFB79FFF)
        : Colors.white.withOpacity(0.58);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: color,
              shadows: active
                  ? [
                      Shadow(
                        color: const Color(0xFF7B61FF).withOpacity(0.65),
                        blurRadius: 14,
                      ),
                    ]
                  : null,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.2,
                color: color,
                shadows: active
                    ? [
                        Shadow(
                          color: const Color(0xFF7B61FF).withOpacity(0.45),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
