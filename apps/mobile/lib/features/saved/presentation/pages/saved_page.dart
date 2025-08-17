// lib/explore/view/saved_page.dart
// -----------------------------------------------------------------------------
//  "Saved" screen for the Photography‑Spots app
// -----------------------------------------------------------------------------
//  Beautiful redesign matching the provided design with proper status bar handling
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

import '../../../explore/data/models/spot.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Saved Page (Stateful so we can mutate the active‑category filter)
// ─────────────────────────────────────────────────────────────────────────────
class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _activeCategory = 0; // 0 = All

  // Replace this with your real "saved" collection once it's wired up.
  final _saved = <Spot>[mockSpot, riverBank];

  final Set<String> _liked = {};

  @override
  void initState() {
    super.initState();
    // Set status bar to transparent to avoid overlap
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  // ────────────────────────────────────────────────────────────── UI BUILD ───
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    final topInset = MediaQuery.of(context).padding.top;

    // apply simple client‑side tag filter
    final filtered =
        _activeCategory == 0
            ? _saved
            : _saved.where((s) {
              const catTags = ['Landscape', 'Urban', 'Waterfront', 'Forest'];
              return s.tags.contains(catTags[_activeCategory - 1]);
            }).toList();

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: _buildBody(filtered, bottomInset, topInset),
    );
  }

  // Main scrollable content ---------------------------------------------------
  Widget _buildBody(List<Spot> spots, double bottomInset, double topInset) {
    final edgeBottom = 70 + 14 + bottomInset; // nav‑bar + gap + safe‑area

    return CustomScrollView(
              slivers: [
          // Status bar spacer
          SliverToBoxAdapter(
            child: SizedBox(height: topInset),
          ),
          // Profile section
          const SliverToBoxAdapter(child: _ProfileBar()),
          // Stats section
          const SliverToBoxAdapter(child: _StatsSection()),
          // Category filters
          SliverToBoxAdapter(
            child: _CategoryRow(
              active: _activeCategory,
              onSelected: (i) => setState(() => _activeCategory = i),
            ),
          ),
          // Spots list
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16, 12, 16, edgeBottom),
            sliver: SliverList.builder(
              itemCount: spots.length,
              itemBuilder:
                  (_, idx) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _SpotCard(
                      spot: spots[idx],
                      liked: _liked.contains(spots[idx].name),
                      onLikeToggled: (isLiked) {
                        // maintain the set in parent
                        setState(() {
                          if (isLiked) {
                            _liked.add(spots[idx].name);
                          } else {
                            _liked.remove(spots[idx].name);
                          }
                        });
                      },
                    ),
                  ),
            ),
          ),
        ],
    );
  }


}

// ───────────────────────────────────────────────────────────────── COMPONENTS ─



/// Avatar + name + share button bar.
class _ProfileBar extends StatelessWidget {
  const _ProfileBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGray,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.network(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
                width: 44,
                height: 44,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Jessica Parker',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  '42 saved photography spots',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: const [
                Icon(
                  FontAwesomeIcons.shareNodes,
                  size: 12,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'Share',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Statistics section with total photos, categories, and countries
class _StatsSection extends StatelessWidget {
  const _StatsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.dark,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: _StatItem(
              label: 'Total Photos',
              value: '248',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.lightGray,
          ),
          Expanded(
            child: _StatItem(
              label: 'Categories',
              value: '8',
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: AppColors.lightGray,
          ),
          Expanded(
            child: _StatItem(
              label: 'Countries',
              value: '12',
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual stat item
class _StatItem extends StatelessWidget {
  const _StatItem({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.active, required this.onSelected});

  final int active;
  final ValueChanged<int> onSelected;

  static const _chipData = [
    (null, 'All Spots'),
    (FontAwesomeIcons.mountain, 'Landscape'),
    (FontAwesomeIcons.city, 'Urban'),
    (FontAwesomeIcons.water, 'Waterfront'),
    (FontAwesomeIcons.tree, 'Forest'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.dark,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (var i = 0; i < _chipData.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => onSelected(i),
                  child: Container(
                    decoration: BoxDecoration(
                      color: i == active ? AppColors.accent : AppColors.darkGray,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: Row(
                      children: [
                        if (_chipData[i].$1 != null) ...[
                          Icon(
                            _chipData[i].$1!,
                            size: 12,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          _chipData[i].$2,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

class _SpotCard extends StatefulWidget {
  const _SpotCard({
    required this.spot,
    required this.liked,
    required this.onLikeToggled,
  });

  final Spot spot;
  final bool liked;
  final ValueChanged<bool> onLikeToggled;

  @override
  State<_SpotCard> createState() => _SpotCardState();
}

class _SpotCardState extends State<_SpotCard> {
  late bool _liked;

  @override
  void initState() {
    super.initState();
    _liked = widget.liked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          // cover image + heart + overlay
          Stack(
            children: [
              Container(
                height: 192, // 48 * 4 = 192px
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    widget.spot.coverUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Heart button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _liked = !_liked);
                    widget.onLikeToggled(_liked);
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      _liked
                          ? FontAwesomeIcons.solidHeart
                          : FontAwesomeIcons.heart,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Gradient overlay with title and location
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black, Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.spot.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationDot,
                            size: 12,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.spot.locationInfo.city}, ${widget.spot.locationInfo.state}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // rating & last visit
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.solidStar,
                  size: 14,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.spot.rating} (${widget.spot.photoCount} photos)',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Last visit: 2 weeks ago',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          // tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 8,
              children: [
                for (final tag in widget.spot.tags.take(2))
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tagIcon(tag),
                        const SizedBox(width: 4),
                        Text(
                          tag,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // action buttons
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                _ActionButton(
                  icon: FontAwesomeIcons.route,
                  label: 'Directions',
                  backgroundColor: AppColors.primary,
                  textColor: Colors.white,
                  onTap: () {},
                ),
                const SizedBox(width: 8),
                _ActionButton(
                  icon: FontAwesomeIcons.shareNodes,
                  label: 'Share',
                  backgroundColor: AppColors.lightGray,
                  textColor: Colors.white,
                  onTap: () {},
                ),
                const Spacer(),
                _ActionButton(
                  icon: FontAwesomeIcons.ellipsisVertical,
                  label: '',
                  backgroundColor: AppColors.lightGray,
                  textColor: Colors.white,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // helpers ------------------------------------------------------------------
  Widget _tagIcon(String tag) {
    const map = {
      'Golden Hour': FontAwesomeIcons.solidSun,
      'Landscape': FontAwesomeIcons.mountain,
      'Scenic': FontAwesomeIcons.eye,
      'Urban': FontAwesomeIcons.city,
      'Waterfront': FontAwesomeIcons.water,
      'Forest': FontAwesomeIcons.tree,
      'Sunset': FontAwesomeIcons.solidSun,
      'Seascape': FontAwesomeIcons.water,
      'Nature': FontAwesomeIcons.tree,
    };
    return Icon(
      map[tag] ?? FontAwesomeIcons.circle,
      size: 12,
      color: _getTagIconColor(tag),
    );
  }

  Color _getTagIconColor(String tag) {
    const colorMap = {
      'Golden Hour': Colors.amber,
      'Sunset': Colors.amber,
      'Landscape': Colors.blue,
      'Mountain': Colors.blue,
      'Urban': Colors.blue,
      'City': Colors.blue,
      'Waterfront': Colors.blue,
      'Water': Colors.blue,
      'Forest': Colors.green,
      'Tree': Colors.green,
      'Nature': Colors.green,
    };
    return colorMap[tag] ?? Colors.grey;
  }
}

/// Action button with icon and optional label
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: label.isNotEmpty ? 12 : 8,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 12,
              color: textColor,
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: textColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  END
// -----------------------------------------------------------------------------
