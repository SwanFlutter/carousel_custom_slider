import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'carousel_config.dart';

/// A 3D rotating carousel **without** a shader mask.
///
/// Cards are contained inside a fixed [SizedBox] (600 × 400 by default).
/// Use this when you want a self-contained widget that doesn't bleed
/// fade effects to the screen edges.
///
/// ## Usage
///
/// ```dart
/// // Default appearance
/// Carousel3D()
///
/// // Custom images and size
/// Carousel3D(
///   images: myUrls,
///   containerWidth: 500,
///   containerHeight: 350,
///   config: CarouselConfig(cardCount: 8),
/// )
/// ```
class Carousel3D extends StatefulWidget {
  /// List of full image URLs to display.
  /// Defaults to [kDefaultUnsplashIds] converted to Unsplash URLs when `null`.
  final List<String>? images;

  /// Carousel geometry and animation settings.
  /// Defaults to [CarouselConfig.standard].
  final CarouselConfig config;

  /// Width of the outer container that clips the carousel.
  final double containerWidth;

  /// Height of the outer container that clips the carousel.
  final double containerHeight;

  const Carousel3D({
    super.key,
    this.images,
    this.config = CarouselConfig.standard,
    this.containerWidth = 600,
    this.containerHeight = 400,
  });

  @override
  State<Carousel3D> createState() => _Carousel3DState();
}

class _Carousel3DState extends State<Carousel3D>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<String> _imageUrls;

  @override
  void initState() {
    super.initState();
    _imageUrls =
        widget.images ??
        kDefaultUnsplashIds
            .take(widget.config.cardCount)
            .map((id) => id.toUnsplashUrl(width: 280))
            .toList();

    _controller = AnimationController(
      vsync: this,
      duration: widget.config.animationDuration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cfg = widget.config;
    final baseAngle = 2 * math.pi / cfg.cardCount;
    final translateZ =
        (0.5 * cfg.cardWidth + cfg.gap) / math.tan(0.5 * baseAngle);

    return SizedBox(
      width: widget.containerWidth,
      height: widget.containerHeight,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..setEntry(3, 2, 1.0 / cfg.perspective),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => Stack(
            alignment: Alignment.center,
            children: [
              for (int i = 0; i < cfg.cardCount; i++)
                _buildCard(i, baseAngle, translateZ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(int index, double baseAngle, double translateZ) {
    final cfg = widget.config;
    final angle = _controller.value * 2 * math.pi + index * baseAngle;
    final normalized = angle % (2 * math.pi);

    // Backface culling
    if (normalized > math.pi / 2 && normalized < 3 * math.pi / 2) {
      return const SizedBox.shrink();
    }

    final cardHeight = cfg.cardWidth / cfg.aspectRatio;

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateY(angle)
        ..translateByDouble(0.0, 0.0, translateZ, 1.0),
      child: ClipRRect(
        borderRadius: cfg.borderRadius,
        child: Image.network(
          index < _imageUrls.length ? _imageUrls[index] : '',
          width: cfg.cardWidth,
          height: cardHeight,
          fit: BoxFit.cover,
          loadingBuilder: (_, child, progress) => progress == null
              ? child
              : buildCarousel3dPlaceholder(cfg.cardWidth, cardHeight),
          errorBuilder: (_, _, _) =>
              buildCarousel3dError(cfg.cardWidth, cardHeight),
        ),
      ),
    );
  }
}
