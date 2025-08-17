import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../data/models/spot.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

/// Draggable bottom-sheet that shows comprehensive details for the selected [spot].
class SpotDetailsContent extends StatelessWidget {
  const SpotDetailsContent({
    super.key,
    required this.spot,
    required this.controller,
  });

  final Spot spot;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: controller,
      slivers: [
        SliverToBoxAdapter(child: _grabHandle()),
        SliverToBoxAdapter(child: _spotHeader()),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverToBoxAdapter(child: _featuredPhoto()),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverToBoxAdapter(child: _photoSettings()),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverToBoxAdapter(child: _locationInfo()),
        const SliverPadding(padding: EdgeInsets.only(top: 16)),
        SliverToBoxAdapter(child: _communityPhotos()),
        const SliverPadding(padding: EdgeInsets.only(bottom: 32)),
      ],
    );
  }

  // ─────────────────────────── UI Components ───────────────────────────

  Widget _grabHandle() => Center(
    child: Container(
      margin: const EdgeInsets.only(top: 12, bottom: 4),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(2),
      ),
    ),
  );

  Widget _spotHeader() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    spot.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.solidStar,
                        size: 14,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${spot.rating}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${spot.reviewCount} reviews',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                _actionButton(
                  icon: FontAwesomeIcons.bookmark,
                  onTap: () {
                    // TODO: Implement bookmark toggle
                  },
                ),
                const SizedBox(width: 12),
                _actionButton(
                  icon: FontAwesomeIcons.shareNodes,
                  onTap: () {
                    // TODO: Implement share
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        _tagChips(),
      ],
    ),
  );

  Widget _tagChips() => SizedBox(
    height: 32,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: spot.tags.length,
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          spot.tags[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );

  Widget _featuredPhoto() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Container(
      height: 224,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              spot.coverUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                             decoration: BoxDecoration(
                 color: AppColors.darkBackground.withOpacity(0.7),
                 borderRadius: BorderRadius.circular(8),
               ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    FontAwesomeIcons.camera,
                    size: 12,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'View all ${spot.photoCount} photos',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _photoSettings() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Optimal Photo Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _photoSettingCard(
              icon: FontAwesomeIcons.clock,
              title: 'Best Time',
              value: spot.photoSettings.bestTime,
            ),
            _photoSettingCard(
              icon: FontAwesomeIcons.calendarDays,
              title: 'Best Season',
              value: spot.photoSettings.bestSeason,
            ),
            _photoSettingCard(
              icon: FontAwesomeIcons.cameraRetro,
              title: 'Camera Settings',
              value: spot.photoSettings.cameraSettings,
            ),
            _photoSettingCard(
              icon: FontAwesomeIcons.circleHalfStroke,
              title: 'Recommended Gear',
              value: spot.photoSettings.recommendedGear,
            ),
          ],
        ),
      ],
    ),
  );

  Widget _photoSettingCard({
    required IconData icon,
    required String title,
    required String value,
  }) =>
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget _locationInfo() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Location',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement directions
              },
              child: const Text(
                'Directions',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                spot.locationInfo.fullName,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                spot.locationInfo.fullAddress,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.car,
                    size: 12,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    spot.locationInfo.distanceFromUser,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
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

  Widget _communityPhotos() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Community Photos',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            TextButton(
              onPressed: () {
                // TODO: Implement view all photos
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: AppColors.accent,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: spot.communityPhotos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (_, i) => ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                spot.communityPhotos[i].imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _actionButton({
    required IconData icon,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      );
}
