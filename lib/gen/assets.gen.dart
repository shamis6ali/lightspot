// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsPinsGen {
  const $AssetsPinsGen();

  /// Directory path: assets/pins/2.0x
  $AssetsPins20xGen get a2 => const $AssetsPins20xGen();

  /// Directory path: assets/pins/3.0x
  $AssetsPins30xGen get a3 => const $AssetsPins30xGen();

  /// File path: assets/pins/location-pin.png
  AssetGenImage get locationPin =>
      const AssetGenImage('assets/pins/location-pin.png');

  /// List of all assets
  List<AssetGenImage> get values => [locationPin];
}

class $AssetsPins20xGen {
  const $AssetsPins20xGen();

  /// File path: assets/pins/2.0x/location-pin.png
  AssetGenImage get locationPin =>
      const AssetGenImage('assets/pins/2.0x/location-pin.png');

  /// List of all assets
  List<AssetGenImage> get values => [locationPin];
}

class $AssetsPins30xGen {
  const $AssetsPins30xGen();

  /// File path: assets/pins/3.0x/location-pin.png
  AssetGenImage get locationPin =>
      const AssetGenImage('assets/pins/3.0x/location-pin.png');

  /// List of all assets
  List<AssetGenImage> get values => [locationPin];
}

class Assets {
  const Assets._();

  static const $AssetsPinsGen pins = $AssetsPinsGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
