import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  int _activeTab = 0; // 0 = Feed

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
          // Stories section
          _buildStoriesSection(),
          // Tabs
          _buildTabs(),
          // Content feed
          Expanded(
            child: _buildContentFeed(bottomInset),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(bottomInset),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildStoriesSection() {
    final stories = [
      {'type': 'add', 'name': 'Your Story'},
      {'type': 'user', 'name': 'MountainPro', 'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg', 'viewed': false},
      {'type': 'user', 'name': 'SunsetChaser', 'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg', 'viewed': false},
      {'type': 'user', 'name': 'UrbanShots', 'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg', 'viewed': true},
      {'type': 'user', 'name': 'NightSky', 'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-7.jpg', 'viewed': false},
    ];

    return Container(
      color: Theme.of(context).cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        height: 68,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, i) => _buildStoryItem(stories[i]),
        ),
      ),
    );
  }

  Widget _buildStoryItem(Map<String, dynamic> story) {
    if (story['type'] == 'add') {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Center(
              child: Icon(
                FontAwesomeIcons.plus,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            story['name'],
            style: TextStyle(
              fontSize: 10,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: story['viewed'] ? Colors.grey : AppColors.accent,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              story['avatar'],
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          story['name'],
          style: TextStyle(
            fontSize: 10,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    final tabs = ['Feed', 'Challenges', 'Discussions'];
    
    return Container(
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
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _activeTab = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: i == _activeTab ? AppColors.accent : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      fontWeight: i == _activeTab ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContentFeed(double bottomInset) {
    if (_activeTab == 0) {
      return _buildFeedTab(bottomInset);
    } else if (_activeTab == 1) {
      return _buildChallengesTab();
    } else {
      return _buildDiscussionsTab();
    }
  }

  Widget _buildFeedTab(double bottomInset) {
    final posts = [
      {
        'user': 'MountainPro',
        'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-2.jpg',
        'location': 'Mount Rainier, WA',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
        'cameraInfo': 'Sony A7IV • 24mm • f/8 • 1/125s',
        'likes': 248,
        'comments': 42,
        'caption': 'Finally caught that perfect golden hour at Mount Rainier! Worth the 4am hike. #GoldenHour #MountainPhotography',
        'timeAgo': '2 hours ago',
        'isLiked': true,
        'isBookmarked': false,
      },
      {
        'user': 'SunsetChaser',
        'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-5.jpg',
        'location': 'Sunset Point, CA',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-4e94eb3eeb9e8f55506f.png',
        'cameraInfo': 'Canon R5 • 16-35mm • f/11 • 1/60s',
        'likes': 173,
        'comments': 28,
        'caption': 'This spot never disappoints! I\'ve been here 20+ times and every sunset is different. Pro tip: arrive 2 hours early to get the best spot. #SunsetPhotography #CaliforniaCoast',
        'timeAgo': '5 hours ago',
        'isLiked': false,
        'isBookmarked': false,
      },
      {
        'user': 'UrbanShots',
        'avatar': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/avatars/avatar-3.jpg',
        'location': 'Downtown Seattle, WA',
        'image': 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6379450ba0-4ab9c1c76053ea803d0b.png',
        'cameraInfo': 'Fujifilm X-T4 • 23mm • f/2 • 1/15s',
        'likes': 96,
        'comments': 14,
        'caption': 'Rainy nights in Seattle create the perfect canvas for urban photography. Love how the neon reflects off the wet streets! #UrbanPhotography #NightShots',
        'timeAgo': 'Yesterday',
        'isLiked': false,
        'isBookmarked': false,
      },
    ];

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 80 + bottomInset),
      itemCount: posts.length,
      separatorBuilder: (_, __) => Container(
        height: 1,
        color: Theme.of(context).dividerColor,
      ),
      itemBuilder: (_, i) => _buildPostCard(posts[i]),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Column(
      children: [
        // Post Header
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  post['avatar'],
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post['user'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.locationDot,
                          size: 12,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          post['location'],
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.ellipsisVertical,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
        
        // Post Image
        SizedBox(
          width: double.infinity,
          height: 256,
          child: Stack(
            children: [
              Image.network(
                post['image'],
                width: double.infinity,
                height: 256,
                fit: BoxFit.cover,
              ),
              // Camera info overlay
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.camera,
                        size: 12,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post['cameraInfo'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        
        // Post Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    _buildActionButton(
                      icon: post['isLiked'] ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                      label: post['likes'].toString(),
                      isActive: post['isLiked'],
                      onTap: () {
                        setState(() {
                          post['isLiked'] = !post['isLiked'];
                          if (post['isLiked']) {
                            post['likes']++;
                          } else {
                            post['likes']--;
                          }
                        });
                      },
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      icon: FontAwesomeIcons.comment,
                      label: post['comments'].toString(),
                      isActive: false,
                      onTap: () {},
                    ),
                    const SizedBox(width: 16),
                    _buildActionButton(
                      icon: FontAwesomeIcons.share,
                      label: '',
                      isActive: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              _buildActionButton(
                icon: post['isBookmarked'] ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                label: '',
                isActive: post['isBookmarked'],
                onTap: () {
                  setState(() {
                    post['isBookmarked'] = !post['isBookmarked'];
                  });
                },
              ),
            ],
          ),
        ),
        
        // Caption
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: post['user'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: ' ${post['caption']}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'View all ${post['comments']} comments',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                post['timeAgo'],
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.accent : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            size: 20,
          ),
          if (label.isNotEmpty) ...[
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.accent : Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildChallengesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.trophy,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Challenges Coming Soon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscussionsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.comments,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text(
            'Discussions Coming Soon',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingActionButton(double bottomInset) {
    return Padding(
      padding: EdgeInsets.only(bottom: 80 + bottomInset + 8),
      child: FloatingActionButton(
        backgroundColor: AppColors.accent,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(
          FontAwesomeIcons.plus,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
