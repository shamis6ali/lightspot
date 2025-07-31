import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/spot.dart';           // ⬅︎  put Spot/SpotItem here (or adjust path)
import '../pages/explore_page.dart';     // ⬅︎  same for AppColors
import 'package:lightspot_v1/common/theme/app_colors.dart';

/// Draggable bottom-sheet that shows details for the selected [spot].
class SpotDetailsContent extends StatelessWidget {
  const SpotDetailsContent({
    super.key,
    required this.spot,
    required this.controller,      //  <-- required
  });

  final Spot spot;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,          // ← wire it up
      slivers: [
        SliverToBoxAdapter(child: _grabHandle()),
        SliverToBoxAdapter(child: _titleRow(spot)),
        const SliverPadding(padding: EdgeInsets.only(top: 12)),
        SliverToBoxAdapter(child: _tagChips(spot)),
        const SliverPadding(padding: EdgeInsets.only(top: 14)),
        SliverToBoxAdapter(child: _gallery(spot)),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }


  // ─────────────────────────── helpers ───────────────────────────

  Widget _grabHandle() => Center(
    child: Container(
      margin: const EdgeInsets.only(top: 6, bottom: 14),
      width: 48,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.circular(4),
      ),
    ),
  );

  Widget _titleRow(Spot s) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(s.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(FontAwesomeIcons.solidStar, size: 12, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text('${s.rating} (${s.reviewCount} reviews)',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        _circleIcon(FontAwesomeIcons.bookmark),
      ],
    ),
  );

  Widget _tagChips(Spot s) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Wrap(
      spacing: 6,
      children: [
        for (final tag in s.tags)
          Chip(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            backgroundColor: AppColors.lightGray,
            avatar: _tagIcon(tag),
            label: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ),
      ],
    ),
  );

  Widget _gallery(Spot s) => SizedBox(   // fixes both crashes
    height: 140,                         // any reasonable photo-strip height
    child: ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      scrollDirection: Axis.horizontal,
      itemCount: s.gallery.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (_, i) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          s.gallery[i],
          width: 130,
          height: 130,
          fit: BoxFit.cover,
        ),
      ),
    ),
  );


  Widget _circleIcon(IconData icon) => Container(
    width: 40,
    height: 40,
    decoration: const BoxDecoration(
      color: AppColors.darkGray,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2))],
    ),
    child: Center(child: Icon(icon, size: 16, color: Colors.white)),
  );

  Widget _tagIcon(String tag) {
    const map = {
      'Golden Hour': FontAwesomeIcons.solidSun,
      'Landscape': FontAwesomeIcons.mountain,
      'Scenic': FontAwesomeIcons.eye,
    };
    return Icon(map[tag] ?? FontAwesomeIcons.circle, size: 12, color: Colors.white);
  }
}
