// lib/explore/models/spot.dart
// -----------------------------------------------------------------------------
//  Spot model & demo data for the Photography-Spots app
// -----------------------------------------------------------------------------

import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
as cm;

/// Photo settings for optimal photography at a spot
class PhotoSettings {
  final String bestTime;
  final String bestSeason;
  final String cameraSettings;
  final String recommendedGear;

  const PhotoSettings({
    required this.bestTime,
    required this.bestSeason,
    required this.cameraSettings,
    required this.recommendedGear,
  });

  /// Create a copy with some fields replaced
  PhotoSettings copyWith({
    String? bestTime,
    String? bestSeason,
    String? cameraSettings,
    String? recommendedGear,
  }) {
    return PhotoSettings(
      bestTime: bestTime ?? this.bestTime,
      bestSeason: bestSeason ?? this.bestSeason,
      cameraSettings: cameraSettings ?? this.cameraSettings,
      recommendedGear: recommendedGear ?? this.recommendedGear,
    );
  }
}

/// Location information for a spot
class LocationInfo {
  final String fullName;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String distanceFromUser;

  const LocationInfo({
    required this.fullName,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.distanceFromUser,
  });

  String get fullAddress => '$city, $state $zipCode';
  
  /// Create a copy with some fields replaced
  LocationInfo copyWith({
    String? fullName,
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? distanceFromUser,
  }) {
    return LocationInfo(
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      distanceFromUser: distanceFromUser ?? this.distanceFromUser,
    );
  }
}

/// Community photo information
class CommunityPhoto {
  final String imageUrl;
  final String? caption;
  final String? photographer;
  final DateTime? takenAt;

  const CommunityPhoto({
    required this.imageUrl,
    this.caption,
    this.photographer,
    this.takenAt,
  });
}

/// Single spot on the map with comprehensive details.
class Spot {
  final String id;
  final String name;
  final double rating;
  final int reviewCount;
  final int photoCount;
  final String coverUrl;
  final List<String> gallery;
  final List<String> tags;
  final Offset pinPos;      // 0-1 fractional pos in static map snapshot
  final LatLng latLng;
  
  // New fields for detailed view
  final PhotoSettings photoSettings;
  final LocationInfo locationInfo;
  final List<CommunityPhoto> communityPhotos;
  final bool isBookmarked;
  final DateTime createdAt;
  final String? description;
  final String? photographer;

  const Spot({
    required this.id,
    required this.name,
    required this.rating,
    required this.reviewCount,
    required this.photoCount,
    required this.coverUrl,
    required this.gallery,
    required this.tags,
    required this.pinPos,
    required this.latLng,
    required this.photoSettings,
    required this.locationInfo,
    required this.communityPhotos,
    this.isBookmarked = false,
    required this.createdAt,
    this.description,
    this.photographer,
  });

  /// Create a copy of this spot with some fields replaced
  Spot copyWith({
    String? id,
    String? name,
    double? rating,
    int? reviewCount,
    int? photoCount,
    String? coverUrl,
    List<String>? gallery,
    List<String>? tags,
    Offset? pinPos,
    LatLng? latLng,
    PhotoSettings? photoSettings,
    LocationInfo? locationInfo,
    List<CommunityPhoto>? communityPhotos,
    bool? isBookmarked,
    DateTime? createdAt,
    String? description,
    String? photographer,
  }) {
    return Spot(
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      photoCount: photoCount ?? this.photoCount,
      coverUrl: coverUrl ?? this.coverUrl,
      gallery: gallery ?? this.gallery,
      tags: tags ?? this.tags,
      pinPos: pinPos ?? this.pinPos,
      latLng: latLng ?? this.latLng,
      photoSettings: photoSettings ?? this.photoSettings,
      locationInfo: locationInfo ?? this.locationInfo,
      communityPhotos: communityPhotos ?? this.communityPhotos,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      photographer: photographer ?? this.photographer,
    );
  }

  /// Toggle bookmark status
  Spot toggleBookmark() {
    return copyWith(isBookmarked: !isBookmarked);
  }
}

/// Adapter so `google_maps_cluster_manager_2` can work with our [Spot] model.
class SpotItem with cm.ClusterItem {
  SpotItem(this.spot);
  final Spot spot;

  @override
  LatLng get location => spot.latLng;
}

// ───────────────────────────────────────────────────────────────── demo data ──

// Enhanced demo spot with all the new fields
final Spot mockSpot = Spot(
  id: '1',
  name: 'Sunset Cliff Point',
  rating: 4.8,
  reviewCount: 124,
  photoCount: 27,
  coverUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-099fb6a81286a4d85a88.png',
  gallery: [
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/d6533f3869-099fb6a81286a4d85a88.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/b4ccbf1e54-876e9e3db45ef0cc3405.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/bc27ad2a5e-610b138cf7bc5121683a.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/ae3b7e248c-13221c845176a3746817.png',
  ],
  tags: ['Landscape', 'Sunset', 'Seascape', 'Nature'],
  pinPos: Offset(0.45, 0.30),
  latLng: LatLng(32.7157, -117.1611), // San Diego, CA
  photoSettings: PhotoSettings(
    bestTime: '6:30 PM - 7:45 PM',
    bestSeason: 'Summer, Fall',
    cameraSettings: 'f/8, 1/125s, ISO 100',
    recommendedGear: 'Tripod, ND Filter',
  ),
  locationInfo: LocationInfo(
    fullName: 'Sunset Cliff Point, Ocean Beach',
    address: 'Sunset Cliffs Blvd',
    city: 'San Diego',
    state: 'CA',
    zipCode: '92107',
    distanceFromUser: '15 min from your location',
  ),
  communityPhotos: [
    CommunityPhoto(
      imageUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/b4ccbf1e54-876e9e3db45ef0cc3405.png',
      caption: 'Dramatic coastal sunset',
      photographer: 'John Doe',
    ),
    CommunityPhoto(
      imageUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/bc27ad2a5e-610b138cf7bc5121683a.png',
      caption: 'Silhouette at dusk',
      photographer: 'Jane Smith',
    ),
    CommunityPhoto(
      imageUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/ae3b7e248c-13221c845176a3746817.png',
      caption: 'Long exposure ocean',
      photographer: 'Mike Johnson',
    ),
  ],
  createdAt: DateTime(2024, 1, 1),
  description: 'A breathtaking coastal cliff offering spectacular sunset views over the Pacific Ocean. Perfect for landscape and seascape photography.',
);

// Second demo spot with enhanced details
final Spot riverBank = Spot(
  id: '2',
  name: 'River Bank Vista',
  rating: 4.6,
  reviewCount: 80,
  photoCount: 45,
  coverUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
  gallery: [
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/961b7e6051-8e95810ccd7b8e3e402e.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
    'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
  ],
  tags: ['River', 'Nature', 'Reflection', 'Golden Hour'],
  pinPos: Offset(0.55, 0.35),
  latLng: LatLng(51.05, -114.09),
  photoSettings: PhotoSettings(
    bestTime: '5:00 PM - 6:30 PM',
    bestSeason: 'Spring, Summer',
    cameraSettings: 'f/11, 1/60s, ISO 200',
    recommendedGear: 'Polarizing Filter, Wide Lens',
  ),
  locationInfo: LocationInfo(
    fullName: 'River Bank Vista, Bow River',
    address: 'Riverfront Park',
    city: 'Calgary',
    state: 'AB',
    zipCode: 'T2P 1J9',
    distanceFromUser: '8 min from your location',
  ),
  communityPhotos: [
    CommunityPhoto(
      imageUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/6640d4652c-6a810963b8c96c69501f.png',
      caption: 'River reflections',
      photographer: 'Sarah Wilson',
    ),
    CommunityPhoto(
      imageUrl: 'https://storage.googleapis.com/uxpilot-auth.appspot.com/3166949e97-78f34d6a95096130cd67.png',
      caption: 'Golden hour on the river',
      photographer: 'Alex Brown',
    ),
  ],
  createdAt: DateTime(2024, 1, 15),
  description: 'A serene riverbank location perfect for capturing water reflections and golden hour photography.',
);

// export list that can be passed straight to ClusterManager
final List<SpotItem> demoItems = [
  SpotItem(mockSpot),
  SpotItem(riverBank),
];
