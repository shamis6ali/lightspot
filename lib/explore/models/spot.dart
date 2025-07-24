// lib/explore/models/spot.dart
// -----------------------------------------------------------------------------
//  Spot model & demo data for the Photography-Spots app
// -----------------------------------------------------------------------------

import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
as cm;

/// Single spot on the map.
///
/// Extend or serialize this as you grow the app (e.g., add `id`, `description`,
/// `author`, Firebase converters, etc.).
class Spot {
  final String name;
  final double rating;
  final int reviewCount;
  final int photoCount;
  final String coverUrl;
  final List<String> gallery;
  final List<String> tags;
  final Offset pinPos;      // 0-1 fractional pos in static map snapshot
  final LatLng latLng;

  const Spot({
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.photoCount,
    required this.coverUrl,
    required this.gallery,
    required this.tags,
    required this.pinPos,
    required this.latLng,
  });
}

/// Adapter so `google_maps_cluster_manager_2` can work with our [Spot] model.
class SpotItem with cm.ClusterItem {
  SpotItem(this.spot);
  final Spot spot;

  @override
  LatLng get location => spot.latLng;
}

// ───────────────────────────────────────────────────────────────── demo data ──

// first demo spot (const →  safe to reference properties elsewhere)
const Spot mockSpot = Spot(
  name: 'Sunset Point',
  rating: 4.8,
  reviewCount: 124,
  photoCount: 124,
  coverUrl:
  'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-4e94eb3eeb9e8f55506f.png',
  gallery: [
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-4e94eb3eeb9e8f55506f.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
  ],
  tags: ['Golden Hour', 'Landscape', 'Scenic'],
  pinPos: Offset(0.45, 0.30),
  latLng: LatLng(51.0447, -114.0719), // Calgary, AB
);

// second demo spot  (non-const so we can reuse mockSpot’s values)
final Spot riverBank = Spot(
  name: 'River Bank',
  rating: 4.6,
  reviewCount: 80,
  photoCount: 200,
  coverUrl: mockSpot.coverUrl,
  gallery: mockSpot.gallery,
  tags: mockSpot.tags,
  pinPos: Offset(0.55, 0.35),
  latLng: LatLng(51.05, -114.09),
);

// export list that can be passed straight to ClusterManager
final List<SpotItem> demoItems = [
  SpotItem(mockSpot),
  SpotItem(riverBank),
];
