import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../pages/explore_page.dart';
import 'package:lightspot_v1/common/theme/app_colors.dart';

// lib/widgets/map_controls.dart
class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onRecenter,
  });

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onRecenter;

  @override
  Widget build(BuildContext context) => Positioned(
    top: 150,
    right: 16,
    child: Column(
      children: [
        _circleIcon(FontAwesomeIcons.plus, onZoomIn),
        const SizedBox(height: 12),
        _circleIcon(FontAwesomeIcons.minus, onZoomOut),
        const SizedBox(height: 12),
        _circleIcon(FontAwesomeIcons.locationCrosshairs, onRecenter),
      ],
    ),
  );

  Widget _circleIcon(IconData icon, VoidCallback onTap) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.darkGray,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2))
        ],
      ),
      child: Center(child: Icon(icon, size: 16, color: Colors.white)),
    ),
  );
}
