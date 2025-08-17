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
      backgroundColor: AppColors.dark,
      body: Column(
        children: [
          // Status bar spacer
          SizedBox(height: topInset),
          // Filter tabs
          _buildFilterTabs(),
          // Main content
          Expanded(
            child: _buildMainContent(bottomInset),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTabs() {
    final tabs = ['Most Popular', 'Recent Uploads', 'Most Visited', 'Top Rated'];
    
    return Container(
      color: AppColors.darkGray,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < tabs.length; i++)
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: GestureDetector(
                  onTap: () => setState(() => _activeTab = i),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 4),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: i == _activeTab ? AppColors.accent : Colors.transparent,
                          width: 2,
                        ),
                      ),
                    ),
                    child: Text(
                      tabs[i],
                      style: TextStyle(
                        color: i == _activeTab ? AppColors.accent : Colors.grey,
                        fontWeight: i == _activeTab ? FontWeight.bold : FontWeight.normal,
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

  Widget _buildMainContent(double bottomInset) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 70 + bottomInset),
      child: Column(
        children: [
          // Featured Spot (filtered by rating > 4.5)
          _buildFeaturedSpot(),
          // Landscape Hotspots
          _buildCategorySection(
            title: 'Landscape Hotspots',
            child: _buildLandscapeSpots(),
          ),
          // Urban Photography
          _buildCategorySection(
            title: 'Urban Photography',
            child: _buildUrbanSpots(),
          ),
          // Community Picks
          _buildCategorySection(
            title: 'Community Picks',
            child: _buildCommunityPicks(),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSpot() {
    // Filter spots by rating > 4.5 for the featured section
    final highRatedSpots = _getAllSpots().where((spot) {
      final rating = double.tryParse(spot['rating'].split(' ')[0]) ?? 0.0;
      return rating > 4.5;
    }).toList();

    if (highRatedSpots.isEmpty) {
      return const SizedBox.shrink();
    }

    // Use the highest rated spot as featured
    final featuredSpot = highRatedSpots.first;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2),
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

  Widget _buildCategorySection({required String title, required Widget child}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: AppColors.accent,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    );
  }

  Widget _buildLandscapeSpots() {
    final spots = [
      {
        'name': 'Mountain View',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
        'rating': '4.6 (98)',
        'location': 'Rocky Mountains',
        'isBookmarked': true,
      },
      {
        'name': 'Silhouette Peak',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
        'rating': '4.5 (76)',
        'location': 'Highland Ridge',
        'isBookmarked': false,
      },
      {
        'name': 'Stargazer Point',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
        'rating': '4.9 (112)',
        'location': 'Dark Sky Reserve',
        'isBookmarked': false,
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 160,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: spots.length,
          separatorBuilder: (_, __) => const SizedBox(width: 12),
          itemBuilder: (_, i) => _buildLandscapeCard(spots[i]),
        ),
      ),
    );
  }

  Widget _buildLandscapeCard(Map<String, dynamic> spot) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Image with bookmark
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  spot['image'],
                  width: 160,
                  height: 128,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Icon(
                  spot['isBookmarked'] 
                      ? FontAwesomeIcons.solidBookmark 
                      : FontAwesomeIcons.bookmark,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spot['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
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
                      spot['rating'],
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      color: AppColors.accent,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        spot['location'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
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
    final spots = [
      {
        'name': 'Downtown Skyline',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-1.jpg',
        'rating': '4.7',
        'description': 'Perfect for night cityscape photography with reflections',
        'photos': '186 photos',
      },
      {
        'name': 'Historic District',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
        'rating': '4.5',
        'description': 'Cobblestone streets and architecture from the 1800s',
        'photos': '142 photos',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (final spot in spots)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildUrbanCard(spot),
            ),
        ],
      ),
    );
  }

  Widget _buildUrbanCard(Map<String, dynamic> spot) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
            child: Image.network(
              spot['image'],
              width: 96,
              height: 96,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        spot['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.solidStar,
                            color: Colors.amber,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            spot['rating'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    spot['description'],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.camera,
                            color: AppColors.accent,
                            size: 12,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            spot['photos'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildCustomMarker(),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.directions,
                                  color: Colors.white,
                                  size: 10,
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Go',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
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
    );
  }

  Widget _buildCustomMarker() {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  Widget _buildCommunityPicks() {
    final picks = [
      {
        'name': 'Waterfall Canyon',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
        'author': 'PhotoMaster',
        'likes': '243',
        'comments': '32',
      },
      {
        'name': 'Foggy Forest',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-7.jpg',
        'author': 'NatureLens',
        'likes': '187',
        'comments': '21',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
        children: [
          for (final pick in picks)
            _buildCommunityCard(pick),
        ],
      ),
    );
  }

  Widget _buildCommunityCard(Map<String, dynamic> pick) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          // Image with heart button
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  pick['image'],
                  width: double.infinity,
                  height: 144,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      FontAwesomeIcons.solidHeart,
                      color: AppColors.accent,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pick['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.user,
                      color: Colors.grey,
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'by ${pick['author']}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.solidHeart,
                          color: AppColors.accent,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pick['likes'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.comment,
                          color: Colors.grey,
                          size: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          pick['comments'],
                          style: const TextStyle(
                            fontSize: 12,
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
        ],
      ),
    );
  }
}
