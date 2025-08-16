// lib/explore/view/saved_page.dart
// -----------------------------------------------------------------------------
//  "Saved" screen for the Photography‑Spots app
// -----------------------------------------------------------------------------
//  Reuses palette (AppColors), BottomNav, and Spot model from the Explore page.
//  Hook it into your router or set `home: SavedPage()` in main.dart to test.
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../explore/data/models/spot.dart';
import '../../../../common/theme/app_colors.dart';

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

  // ────────────────────────────────────────────────────────────── UI BUILD ───
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;

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
      body: _buildBody(filtered, bottomInset),
      floatingActionButton: _buildFab(bottomInset),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Main scrollable content ---------------------------------------------------
  Widget _buildBody(List<Spot> spots, double bottomInset) {
    final edgeBottom = 70 + 14 + bottomInset; // nav‑bar + gap + safe‑area

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: _ProfileBar()),
        SliverToBoxAdapter(
          child: _CategoryRow(
            active: _activeCategory,
            onSelected: (i) => setState(() => _activeCategory = i),
          ),
        ),
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

  // plus button ---------------------------------------------------------------
  Widget _buildFab(double bottomInset) => Padding(
    padding: EdgeInsets.only(bottom: 70 + bottomInset + 10),
    child: FloatingActionButton(
      backgroundColor: AppColors.accent,
      shape: const CircleBorder(),
      onPressed: () {},
      child: const Icon(FontAwesomeIcons.plus),
    ),
  );
}

// ───────────────────────────────────────────────────────────────── COMPONENTS ─

/// Avatar + name + share button bar.
class _ProfileBar extends StatelessWidget {
  const _ProfileBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.darkGray,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Jessica Parker',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Text(
                '42 saved photography spots',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: const [
                Icon(FontAwesomeIcons.shareNodes, size: 12),
                SizedBox(width: 4),
                Text('Share', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                        Icon(_chipData[i].$1!, size: 10),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        _chipData[i].$2,
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
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
          // cover image + heart
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(widget.spot.coverUrl, fit: BoxFit.cover),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() => _liked = !_liked);
                    widget.onLikeToggled(_liked); // bubble up to SavedPage
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      _liked
                          ? FontAwesomeIcons
                              .solidHeart // filled
                          : FontAwesomeIcons.heart, // outline
                      size: 12,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black54, Colors.transparent],
                    ),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.spot.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationDot,
                            size: 10,
                            color: AppColors.accent,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.spot.latLng.latitude.toStringAsFixed(2)}, '
                            '${widget.spot.latLng.longitude.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 10),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // rating & last visit (mocked)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                const Icon(
                  FontAwesomeIcons.solidStar,
                  size: 12,
                  color: Colors.amber,
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.spot.rating} (${widget.spot.photoCount} photos)',
                  style: const TextStyle(fontSize: 12),
                ),
                const Spacer(),
                const Text(
                  'Last visit: 2w',
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ),

          // tags
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Wrap(
              spacing: 6,
              children: [
                for (final tag in widget.spot.tags.take(2))
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.lightGray,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _tagIcon(tag),
                        const SizedBox(width: 4),
                        Text(tag, style: const TextStyle(fontSize: 10)),
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
                _circleIcon(FontAwesomeIcons.route),
                const SizedBox(width: 12),
                _circleIcon(FontAwesomeIcons.shareNodes),
                const Spacer(),
                _circleIcon(FontAwesomeIcons.ellipsisVertical),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // helpers ------------------------------------------------------------------
  Widget _circleIcon(IconData icon) => Container(
    width: 32,
    height: 32,
    decoration: const BoxDecoration(
      color: AppColors.lightGray,
      shape: BoxShape.circle,
    ),
    child: Center(child: Icon(icon, size: 12)),
  );

  Widget _tagIcon(String tag) {
    const map = {
      'Golden Hour': FontAwesomeIcons.solidSun,
      'Landscape': FontAwesomeIcons.mountain,
      'Scenic': FontAwesomeIcons.eye,
      'Urban': FontAwesomeIcons.city,
      'Waterfront': FontAwesomeIcons.water,
      'Forest': FontAwesomeIcons.tree,
    };
    return Icon(map[tag] ?? FontAwesomeIcons.circle, size: 10);
  }
}

// -----------------------------------------------------------------------------
//  END
// -----------------------------------------------------------------------------
