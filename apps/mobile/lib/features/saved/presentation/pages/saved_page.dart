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
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: _buildBody(_saved, bottomInset, topInset),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppColors.accent,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jessica Parker',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Photography Enthusiast',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '24 saved spots',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        FontAwesomeIcons.share,
                        color: AppColors.accent,
                        size: 20,
                      ),
                    ),
                  ],
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _buildStatItem(
            context,
            'Total Photos',
            '156',
            FontAwesomeIcons.camera,
          ),
          const SizedBox(width: 32),
          _buildStatItem(
            context,
            'Categories',
            '8',
            FontAwesomeIcons.tags,
          ),
          const SizedBox(width: 32),
          _buildStatItem(
            context,
            'Countries',
            '12',
            FontAwesomeIcons.globe,
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Icon(
              icon,
              color: AppColors.accent,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  final int active;
  final ValueChanged<int> onSelected;

  const _CategoryRow({required this.active, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Landscape', 'Urban', 'Portrait', 'Nature', 'Architecture'];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < categories.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () => onSelected(i),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: i == active ? AppColors.accent : Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: i == active ? AppColors.accent : Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      categories[i],
                      style: TextStyle(
                        color: i == active ? Colors.white : Theme.of(context).colorScheme.onSurface,
                        fontWeight: i == active ? FontWeight.bold : FontWeight.normal,
                        fontSize: 14,
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

class _SpotCard extends StatelessWidget {
  final Spot spot;
  final bool liked;
  final ValueChanged<bool> onLikeToggled;

  const _SpotCard({
    required this.spot,
    required this.liked,
    required this.onLikeToggled,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
                child: Image.network(
                  spot.coverUrl,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              // Heart button
              Positioned(
                top: 12,
                right: 12,
                child: GestureDetector(
                  onTap: () => onLikeToggled(!liked),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(
                      liked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                      color: liked ? AppColors.accent : Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              // Rating badge
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        spot.rating.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and location
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            spot.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.locationDot,
                                size: 14,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${spot.locationInfo.city}, ${spot.locationInfo.state}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final tag in ['Landscape', 'Sunset', 'Mountains'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.accent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'Directions',
                        FontAwesomeIcons.directions,
                        AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'Share',
                        FontAwesomeIcons.share,
                        AppColors.accent,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildActionButton(
                        context,
                        'More',
                        FontAwesomeIcons.ellipsis,
                        Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 16,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
//  END
// -----------------------------------------------------------------------------
