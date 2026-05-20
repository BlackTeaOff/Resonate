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
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.98, end: 1).animate(animation),
                  child: child,
                ),
              );
            },
            child: _buildPage(_currentIndex),
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
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 1:
        return const _ResonatePage(key: ValueKey('resonate'));
      case 2:
        return const _SettingsPage(key: ValueKey('settings'));
      case 0:
      default:
        return const _LibraryPage(key: ValueKey('library'));
    }
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

class _LibraryPage extends StatelessWidget {
  const _LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0A0A0F), Color(0xFF060608)],
        ),
      ),
      child: ScrollConfiguration(
        behavior: const _NoGlowScrollBehavior(),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 150, 16, 120),
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
    );
  }
}

class _ResonatePage extends StatelessWidget {
  const _ResonatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF000000),
      child: Center(
        child: Text(
          'Resonate Player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
            shadows: [
              Shadow(
                color: Color(0x66000000),
                blurRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsPage extends StatelessWidget {
  const _SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF000000),
      child: Center(
        child: Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
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
                        color: Colors.black.withOpacity(0.35),
                        blurRadius: 8,
                        offset: Offset(0, 1),
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
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 320),
            reverseTransitionDuration: const Duration(milliseconds: 260),
            pageBuilder: (context, animation, secondaryAnimation) {
              return GameDetailScreen(game: game);
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final curved =
                  CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
              return ScaleTransition(
                scale: Tween<double>(begin: 0.98, end: 1).animate(curved),
                child: child,
              );
            },
          ),
        );
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
          child: Hero(
            tag: game.id,
            child: _HeroCover(
              game: game,
              borderRadius: borderRadius,
              overlayOpacity: 1,
              showMeta: true,
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
    const double itemWidth = 92;
    const double navHeight = 44;
    const double indicatorInset = 2;

    return SafeArea(
      top: false,
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
              child: SizedBox(
                width: itemWidth * 3,
                height: navHeight,
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      left: itemWidth * currentIndex,
                      top: indicatorInset,
                      bottom: indicatorInset,
                      child: Container(
                        width: itemWidth,
                        height: navHeight - indicatorInset * 2,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.22),
                            width: 0.6,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7B61FF).withOpacity(0.25),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _NavItem(
                          width: itemWidth,
                          height: navHeight,
                          icon: Icons.auto_awesome_mosaic_rounded,
                          label: 'Library',
                          active: currentIndex == 0,
                          onTap: () => onTap(0),
                        ),
                        _NavItem(
                          width: itemWidth,
                          height: navHeight,
                          icon: Icons.graphic_eq_rounded,
                          label: 'Resonate',
                          active: currentIndex == 1,
                          onTap: () => onTap(1),
                        ),
                        _NavItem(
                          width: itemWidth,
                          height: navHeight,
                          icon: Icons.settings_rounded,
                          label: 'Settings',
                          active: currentIndex == 2,
                          onTap: () => onTap(2),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _NavItem({
    required this.width,
    required this.height,
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color targetColor = active
        ? const Color(0xFFB79FFF)
        : Colors.white.withOpacity(0.58);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<Color?>(
              duration: const Duration(milliseconds: 250),
              tween: ColorTween(end: targetColor),
              builder: (context, color, child) {
                return Icon(
                  icon,
                  size: 18,
                  color: color,
                  shadows: active
                      ? [
                          Shadow(
                            color: const Color(0xFF7B61FF).withOpacity(0.55),
                            blurRadius: 12,
                          ),
                        ]
                      : null,
                );
              },
            ),
            const SizedBox(height: 2),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                fontSize: 10,
                fontWeight: active ? FontWeight.w600 : FontWeight.w500,
                letterSpacing: 0.2,
                color: targetColor,
                shadows: active
                    ? [
                        Shadow(
                          color: const Color(0xFF7B61FF).withOpacity(0.35),
                          blurRadius: 10,
                        ),
                      ]
                    : null,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}

class GameDetailScreen extends StatelessWidget {
  final Game game;

  const GameDetailScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Hero(
                        tag: game.id,
                        child: _HeroCover(
                          game: game,
                          borderRadius: BorderRadius.circular(16),
                          overlayOpacity: 0,
                          showMeta: true,
                        ),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Color(0xFF000000),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 24,
                        bottom: 20,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 48,
                          child: Text(
                            game.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              height: 1.05,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: ColoredBox(color: Color(0xFF000000)),
                ),
              ],
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 8),
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.18),
                          width: 0.8,
                        ),
                      ),
                      child: IconButton(
                        icon:
                            const Icon(Icons.arrow_back_rounded, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroCover extends StatelessWidget {
  final Game game;
  final BorderRadius borderRadius;
  final double overlayOpacity;
  final bool showMeta;

  const _HeroCover({
    required this.game,
    required this.borderRadius,
    required this.overlayOpacity,
    required this.showMeta,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Material(
        type: MaterialType.transparency,
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
            if (showMeta)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Opacity(
                  opacity: overlayOpacity,
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
              ),
          ],
        ),
      ),
    );
  }
}
