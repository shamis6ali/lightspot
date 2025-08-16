// lib/explore/widgets/spot_details_modal.dart

import 'package:flutter/material.dart';
import 'spot_details_content.dart';
import '../../data/models/spot.dart';           // ⬅︎  put Spot/SpotItem here (or adjust path)
import '../pages/explore_page.dart';     // ⬅︎  same for AppColors
import '../../../../common/theme/app_colors.dart';

class SpotDetailsModal extends StatelessWidget {
  final Spot spot;
  const SpotDetailsModal({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {

    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.25,
      maxChildSize: 0.9,
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
