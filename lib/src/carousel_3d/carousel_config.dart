import 'package:flutter/material.dart';

/// Configuration shared across all carousel 3D variants.
class CarouselConfig {
  /// Number of visible cards in the ring.
  final int cardCount;

  /// Width of each card in logical pixels.
  final double cardWidth;

  /// Gap between cards in logical pixels.
  final double gap;

  /// Width-to-height aspect ratio of each card (e.g. `7/10`).
  final double aspectRatio;

  /// Perspective distance used for the [Matrix4] projection.
  final double perspective;

  /// Duration of one full rotation.
  final Duration animationDuration;

  /// Border radius applied to each card.
  final BorderRadius borderRadius;

  /// Background color behind the carousel.
  final Color backgroundColor;

  const CarouselConfig({
    this.cardCount = 12,
    this.cardWidth = 280.0,
    this.gap = 8.0,
    this.aspectRatio = 7 / 10,
    this.perspective = 560.0,
    this.animationDuration = const Duration(seconds: 32),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.backgroundColor = const Color(0xFFFFF3ED),
  });

  /// Preset matching the original shader variant (large cards, far camera).
  static const CarouselConfig shader = CarouselConfig(
    cardWidth: 600.0,
    gap: 16.0,
    perspective: 1400.0,
  );

  /// Preset matching the standard no-shader variant (large cards).
  static const CarouselConfig standard = CarouselConfig(
    cardWidth: 600.0,
    gap: 16.0,
    perspective: 1400.0,
  );

  /// Preset matching the compact alternate variant (small cards, close camera).
  static const CarouselConfig alt = CarouselConfig(
    cardWidth: 280.0,
    gap: 8.0,
    perspective: 560.0,
  );
}

/// Convenience extension for building a network URL from an Unsplash photo ID.
extension UnsplashUrl on String {
  /// Returns a full Unsplash URL for the given photo ID segment.
  String toUnsplashUrl({int width = 280}) =>
      'https://images.unsplash.com/photo-$this?w=$width';
}

/// Default Unsplash photo IDs bundled with the package for demo/example use.
const List<String> kDefaultUnsplashIds = [
  '1540968221243-29f5d70540bf',
  '1596135187959-562c650d98bc',
  '1628944682084-831f35256163',
  '1590013330451-3946e83e0392',
  '1590421959604-741d0eec0a2e',
  '1572613000712-eadc57acbecd',
  '1570097192570-4b49a6736f9f',
  '1620789550663-2b10e0080354',
  '1617775623669-20bff4ffaa5c',
  '1548600916-dc8492f8e845',
  '1573824969595-a76d4365a2e6',
  '1633936929709-59991b5fdd72',
];

/// Builds the loading placeholder widget used by every carousel variant.
Widget buildCarousel3dPlaceholder(double width, double height) => Container(
  width: width,
  height: height,
  color: Colors.grey.shade300,
  alignment: Alignment.center,
  child: const SizedBox(
    width: 24,
    height: 24,
    child: CircularProgressIndicator(strokeWidth: 2),
  ),
);

/// Builds the error widget used by every carousel variant.
Widget buildCarousel3dError(double width, double height) => Container(
  width: width,
  height: height,
  color: Colors.grey.shade300,
  alignment: Alignment.center,
  child: const Icon(Icons.broken_image, color: Colors.grey),
);
