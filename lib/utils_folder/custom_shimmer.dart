import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainScreenShimmer extends StatelessWidget {
  const MainScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF070A09), // ✅ dark background
      body: const DiscoverLikeShimmer(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        currentIndex: 0,
        onTap: (_) {},
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Discover'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Category'),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music_sharp),
            label: 'Your Library',
          ),
        ],
      ),
    );
  }
}

class DiscoverLikeShimmer extends StatelessWidget {
  const DiscoverLikeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Much stronger contrast shimmer on dark UI
    const base = Color(0xFF1A1F1D);
    const highlight = Color(0xFF3A423E);

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      period: const Duration(milliseconds: 1100), // ✅ smoother shimmer
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                _SkelCircle(size: 20),
                SizedBox(width: 8),
                _SkelLine(width: 180, height: 16),
              ],
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 260,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (_, __) => const _EpisodeCardShimmer(),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: const [
                _SkelCircle(size: 20),
                SizedBox(width: 8),
                _SkelLine(width: 120, height: 16),
              ],
            ),
            const SizedBox(height: 12),

            const _EpisodeCardShimmer(large: true),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _EpisodeCardShimmer extends StatelessWidget {
  final bool large;
  const _EpisodeCardShimmer({this.large = false});

  @override
  Widget build(BuildContext context) {
    final w = large ? double.infinity : 170.0;

    return Container(
      width: w,
      decoration: BoxDecoration(
        color: const Color(0xFF121614), // ✅ darker “tile”
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: large ? 160 : 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFF171C1A),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SkelLine(width: 140, height: 14),
                SizedBox(height: 8),
                _SkelLine(width: 110, height: 12),
                SizedBox(height: 8),
                _SkelLine(width: 80, height: 12),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SkelLine extends StatelessWidget {
  final double width;
  final double height;
  const _SkelLine({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF121614),
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _SkelCircle extends StatelessWidget {
  final double size;
  const _SkelCircle({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF121614),
        shape: BoxShape.circle,
      ),
    );
  }
}
