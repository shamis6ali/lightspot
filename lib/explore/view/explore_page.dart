// explore_page.dart
// -----------------------------------------------------------------------------
// “Explore” screen for the Photography‑Spots app
// -----------------------------------------------------------------------------
//  Flutter SDK ≥ 3.19  (Material 3)
//
//  pubspec.yaml (add):
//    dependencies:
//      flutter:
//        sdk: flutter
//      font_awesome_flutter: ^10.7.0
//      google_fonts:           ^6.1.0
//      google_maps_flutter:    ^2.12.0      # latest map plugin
//      google_maps_cluster_manager_2: ^3.2.0 # fork w/ clash‑fix
// -----------------------------------------------------------------------------
//  Drop this file in lib/ and set `home: ExplorePage()` in your MaterialApp.
// -----------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// Hide the map‑plugin’s experimental clustering symbols so they don’t collide
// with the external package we actually use.
import 'package:google_maps_flutter/google_maps_flutter.dart'
    hide ClusterManager, Cluster;
import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart'
    as cm;
import 'package:lightspot_v1/explore/widgets/search_bar.dart' as cst_src;
import 'package:lightspot_v1/explore/widgets/tag_filter_row.dart';
import 'package:lightspot_v1/explore/widgets/map_controls.dart';
import 'package:lightspot_v1/explore/widgets/bottom_nav.dart';
import 'package:lightspot_v1/explore/models/spot.dart' show Spot, SpotItem, demoItems, mockSpot, riverBank;
import 'package:lightspot_v1/explore/widgets/spot_details_modal.dart';

// ─────────────────────────────────────────────────────────────────────────────
//  Theme
// ─────────────────────────────────────────────────────────────────────────────
class AppColors {
  static const primary = Color(0xFF003366);
  static const accent = Color(0xFFFF3333);
  static const dark = Color(0xFF121212);
  static const darkGray = Color(0xFF1E1E1E);
  static const lightGray = Color(0xFF333333);
}

final _textTheme = GoogleFonts.interTextTheme().apply(
  bodyColor: Colors.white,
  displayColor: Colors.white,
);

const double _kSearchBarHeight = 56.0;

// ─────────────────────────────────────────────────────────────────────────────
//  Explore Page
// ─────────────────────────────────────────────────────────────────────────────
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  Spot? _selectedSpot;
  int _activeChipIndex = 0;

  late BitmapDescriptor _pinIcon;
  late BitmapDescriptor _clusterIcon;

  final double _sheetHeight = 280;
  GoogleMapController? _mapController;

  late final cm.ClusterManager<SpotItem> _clusterMgr;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _loadIcons();
    _clusterMgr = cm.ClusterManager<SpotItem>(
      demoItems,
      _updateMarkers,
      markerBuilder: _buildMarker,
      stopClusteringZoom: 15,
    );
  }

  Future<void> _loadIcons() async {
    _pinIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(30, 30)),
      'assets/pins/location-pin.png',
    );
  }

  // Build marker for each cluster/spot
  Future<Marker> _buildMarker(dynamic c) async {
    final cm.Cluster<SpotItem> cluster = c as cm.Cluster<SpotItem>;
    final spot = cluster.items.first.spot;
    return Marker(
      markerId: MarkerId(spot.name),
      position: spot.latLng,
      icon: _pinIcon,
      anchor: const Offset(0.5, 1),
        onTap: () => _showSpotDetails(spot),
    );
  }

  void _updateMarkers(Set<Marker> markers) =>
      setState(() => _markers = markers);

  // ───────────────────────────────────────────────────────── Map & Layout ───

  // Mock Filters
  final chipData = [
    (FontAwesomeIcons.mountain, 'Landscape'),
    (FontAwesomeIcons.city, 'Urban'),
    (FontAwesomeIcons.water, 'Waterfront'),
    (FontAwesomeIcons.tree, 'Forest'),
    (FontAwesomeIcons.personHiking, 'Trail'),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).padding.bottom;
    const kNavBarHeight = 70.0;
    const kGapAboveNav = 14.0;
    int bottomIndex = 0;

    return Scaffold(
      backgroundColor: AppColors.dark,
      extendBody: true,
      body: DefaultTextStyle.merge(
        style: const TextStyle(fontSize: 14),
        child: Stack(
          children: [
            _buildMap(),
            const cst_src.SearchBar(),
            BottomNav(
              currentIndex: 0,      // Explore tab
              onTap: (i) {
                switch (i) {
                  case 0: break;                       // already here
                  case 1: Navigator.pushNamed(context, '/saved');  // Saved
                /* handle other tabs later */
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: kNavBarHeight + kGapAboveNav + bottomInset,
        ),
        child: _buildFab(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildMap() {
    final topInset = MediaQuery.of(context).padding.top;
    return Positioned(
      top: topInset,
      left: 0,
      right: 0,
      bottom: 70,
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: mockSpot.latLng,
              zoom: 11,
            ),
            markers: _markers,
            onMapCreated: (ctrl) {
              _mapController = ctrl;
              _clusterMgr.setMapId(ctrl.mapId);
            },
            onCameraIdle: _clusterMgr.updateMap,
            onCameraMove: _clusterMgr.onCameraMove,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            compassEnabled: false,
            mapToolbarEnabled: false,
          ),
          TagFilterRow(
            tags: chipData,
            activeIndex: _activeChipIndex,
            onSelected: (i) => setState(() => _activeChipIndex = i),
          ),
          MapControls(
            onZoomIn:   () => _mapController
                ?.animateCamera(CameraUpdate.zoomBy(1)),      // “+” icon
            onZoomOut:  () => _mapController
                ?.animateCamera(CameraUpdate.zoomBy(-1)),     // “–” icon
            onRecenter: () => _mapController
                ?.animateCamera(CameraUpdate.newLatLng(mockSpot.latLng)), // target
          ),
        ],
      ),
    );
  }


  FloatingActionButton _buildFab() => FloatingActionButton(
    backgroundColor: AppColors.accent,
    shape: const CircleBorder(),
    onPressed: () {},
    child: const Icon(FontAwesomeIcons.plus),
  );

  // ──────────────────────────────────────────────────────────────────────────
  //  Helpers
  // ──────────────────────────────────────────────────────────────────────────
  Widget _circleIcon(IconData icon) => Container(
    width: 40,
    height: 40,
    decoration: const BoxDecoration(
      color: AppColors.darkGray,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(color: Colors.black54, blurRadius: 4, offset: Offset(0, 2)),
      ],
    ),
    child: Center(child: Icon(icon, size: 16, color: Colors.white)),
  );

  Widget _tagIcon(String tag) {
    final map = {
      'Golden Hour': FontAwesomeIcons.solidSun,
      'Landscape': FontAwesomeIcons.mountain,
      'Scenic': FontAwesomeIcons.eye,
    };
    return Icon(
      map[tag] ?? FontAwesomeIcons.circle,
      size: 12,
      color: Colors.white,
    );
  }

  // explore_page.dart  (add near the bottom of _ExplorePageState)
  void _showSpotDetails(Spot spot) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,   // so we keep the curved corners
      builder: (_) => SpotDetailsModal(spot: spot),
    );
  }

}

// ─────────────────────────────────────────────────────────────────────────────
//  Tiny demo app to launch the page directly  (run «flutter run» to test)
// ─────────────────────────────────────────────────────────────────────────────
// void main() => runApp(const _DemoApp());
//
// class _DemoApp extends StatelessWidget {
//   const _DemoApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Photography Spots',
//       theme: ThemeData.dark(useMaterial3: true).copyWith(
//         textTheme: _textTheme,
//         scaffoldBackgroundColor: AppColors.dark,
//         colorScheme: ColorScheme.fromSeed(
//           brightness: Brightness.dark,
//           seedColor: AppColors.primary,
//           primary: AppColors.primary,
//           secondary: AppColors.accent,
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const ExplorePage(),
//     );
//   }
// }

// -----------------------------------------------------------------------------
//  END
// -----------------------------------------------------------------------------
