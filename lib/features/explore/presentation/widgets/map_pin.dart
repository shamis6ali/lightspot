/// map_pin.dart
library;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/models/spot.dart';

class MapPin extends StatelessWidget {
  const MapPin({
    super.key,
    required this.spot,
    this.onTap,
  });

  final Spot spot;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final pin = GestureDetector(
      onTap: onTap,
      child: Container(
        width: 30,
        height: 30,
        decoration: const BoxDecoration(
          color: Color(0xFFFF3333),
          borderRadius:
              BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: const Center(
          child: Icon(FontAwesomeIcons.circle, size: 14, color: Color(0xFF003366)),
        ),
      ),
    );

    return Positioned(
      left: spot.pinPos.dx,   // caller gives absolute px; keep exactly as before
      top:  spot.pinPos.dy,
      child: Column(
        children: [
          pin,
          const SizedBox(height: 6),
          Container(
            width: 150,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(spot.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                Text('${spot.rating} ★ (${spot.photoCount} photos)',
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
