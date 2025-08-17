// lib/explore/widgets/spot_details_modal.dart

import 'package:flutter/material.dart';
import 'package:lightspot_v1/features/explore/presentation/widgets/spot_details_content.dart';
import '../../data/models/spot.dart';           // ⬅︎  put Spot/SpotItem here (or adjust path)
import '../pages/explore_page.dart';     // ⬅︎  same for AppColors
import 'package:lightspot_v1/common/theme/app_colors.dart';

class SpotDetailsModal extends StatelessWidget {
  final Spot spot;
  const SpotDetailsModal({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollCtl) {
        return Material(
          color: AppColors.darkGray,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          child: SpotDetailsContent(
            spot: spot,
            controller: scrollCtl,   //  ←  THIS   ←
          ),
        );
      },
    );
  }
}
