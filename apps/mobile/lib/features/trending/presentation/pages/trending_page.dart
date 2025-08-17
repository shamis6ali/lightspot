import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  int _activeTab = 0; // 0 = Most Popular

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

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    final bottomInset = MediaQuery.of(context).padding.bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(height: topInset), // Status bar spacer
          _buildFilterTabs(), // Filter tabs
          Expanded(
            child: _buildMainContent(bottomInset), // Main content
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['All', 'Landscape', 'Urban', 'Portrait'];
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _activeTab = i),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  decoration: BoxDecoration(
                    color: i == _activeTab ? AppColors.accent : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: i == _activeTab ? AppColors.accent : Theme.of(context).dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    tabs[i],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: i == _activeTab ? Colors.white : Theme.of(context).colorScheme.onSurface,
                      fontWeight: i == _activeTab ? FontWeight.bold : FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMainContent(double bottomInset) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 70 + bottomInset),
      child: Column(
        children: [
          _buildFeaturedSpot(), // Featured Spot (filtered by rating > 4.5)
          _buildCategorySection(
            title: 'Landscape Hotspots',
            child: _buildLandscapeSpots(),
          ),
          _buildCategorySection(
            title: 'Urban Photography',
            child: _buildUrbanSpots(),
          ),
          _buildCategorySection(
            title: 'Community Picks',
            child: _buildCommunityPicks(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSpot() {
    final highRatedSpots = _getAllSpots().where((spot) {
      final rating = double.tryParse(spot['rating'].split(' ')[0]) ?? 0.0;
      return rating > 4.5;
    }).toList();

    if (highRatedSpots.isEmpty) {
      return const SizedBox.shrink();
    }

    final featuredSpot = highRatedSpots.first; // Using the first high-rated spot

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.onSurface, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                featuredSpot['image'],
                width: double.infinity,
                height: 192,
                fit: BoxFit.cover,
              ),
              // HOT SPOT badge
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        FontAwesomeIcons.fire,
                        color: Colors.white,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'HOT SPOT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Gradient overlay with content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
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
                        featuredSpot['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.solidStar,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                featuredSpot['rating'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                featuredSpot['photos'] ?? '0 photos',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getAllSpots() {
    return [
      {
        'name': 'Sunset Point',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-4e94eb3eeb9e8f55506f.png',
        'rating': '4.8 (124 reviews)',
        'photos': '256 photos',
      },
      {
        'name': 'Mountain View',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
        'rating': '4.6 (98)',
        'photos': '156 photos',
      },
      {
        'name': 'Silhouette Peak',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
        'rating': '4.5 (76)',
        'photos': '89 photos',
      },
      {
        'name': 'Stargazer Point',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
        'rating': '4.9 (112)',
        'photos': '203 photos',
      },
      {
        'name': 'Downtown Skyline',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
        'rating': '4.7',
        'photos': '186 photos',
      },
      {
        'name': 'Historic District',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
        'rating': '4.5',
        'photos': '142 photos',
      },
    ];
  }

  Widget _buildCategorySection({
    required String title,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildLandscapeSpots() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _buildLandscapeCard(i),
      ),
    );
  }

  Widget _buildLandscapeCard(int index) {
    final spots = [
      {
        'name': 'Mountain Peak',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
        'rating': '4.8',
        'location': 'Rocky Mountains',
      },
      {
        'name': 'Sunset Valley',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-4e94eb3eeb9e8f55506f.png',
        'rating': '4.7',
        'location': 'Grand Canyon',
      },
      {
        'name': 'Alpine Lake',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
        'rating': '4.6',
        'location': 'Swiss Alps',
      },
      {
        'name': 'Desert Dunes',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
        'rating': '4.5',
        'location': 'Sahara Desert',
      },
      {
        'name': 'Forest Path',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
        'rating': '4.4',
        'location': 'Black Forest',
      },
    ];

    final spot = spots[index % spots.length];

    return Container(
      width: 160,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            child: Image.network(
              spot['image']!,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot['name']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      spot['rating']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      size: 10,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        spot['location']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildUrbanSpots() {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _buildUrbanCard(i),
      ),
    );
  }

  Widget _buildUrbanCard(int index) {
    final spots = [
      {
        'name': 'City Skyline',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6379450ba0-4ab9c1c76053ea803d0b.png',
        'rating': '4.7',
        'location': 'New York',
      },
      {
        'name': 'Street Art',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
        'rating': '4.6',
        'location': 'Berlin',
      },
      {
        'name': 'Modern Architecture',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
        'rating': '4.5',
        'location': 'Dubai',
      },
      {
        'name': 'Historic District',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-7.jpg',
        'rating': '4.4',
        'location': 'Rome',
      },
      {
        'name': 'Night Lights',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
        'rating': '4.3',
        'location': 'Tokyo',
      },
    ];

    final spot = spots[index % spots.length];

    return Container(
      width: 160,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            child: Image.network(
              spot['image']!,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot['name']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.solidStar,
                      color: Colors.amber,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      spot['rating']!,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.locationDot,
                      size: 10,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        spot['location']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
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

  Widget _buildCustomMarker() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Center(
        child: Icon(
          FontAwesomeIcons.mapPin,
          color: Colors.white,
          size: 12,
        ),
      ),
    );
  }

  Widget _buildCommunityPicks() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, i) => _buildCommunityCard(i),
    );
  }

  Widget _buildCommunityCard(int index) {
    final picks = [
      {
        'name': 'Community Choice #1',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
        'rating': '4.9',
        'votes': '156 votes',
        'description': 'Amazing sunset captured by our community!',
      },
      {
        'name': 'Community Choice #2',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
        'rating': '4.8',
        'votes': '142 votes',
        'description': 'Incredible urban photography moment.',
      },
      {
        'name': 'Community Choice #3',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
        'rating': '4.7',
        'votes': '128 votes',
        'description': 'Stunning landscape that wowed everyone.',
      },
    ];

    final pick = picks[index % picks.length];

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(11)),
            child: Image.network(
              pick['image']!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pick['name']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        color: Colors.amber,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        pick['rating']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        pick['votes']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pick['description']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
