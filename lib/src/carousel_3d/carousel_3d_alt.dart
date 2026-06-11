import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'carousel_config.dart';

/// An alternate 3D rotating carousel with **smaller cards** and a **closer camera**.
///
/// Compared to [Carousel3D], the ring is more compact (cardWidth ≈ 280 px,
/// perspective ≈ 560), making individual cards appear more distinct and
/// the overall depth effect stronger.
///
/// No [ShaderMask] is applied, so this works well as an inline widget
/// embedded inside a larger layout.
///
/// ## Usage
///
/// ```dart
/// // Default compact style
/// Carousel3DAlt()
///
/// // With custom config
/// Carousel3DAlt(
///   images: myUrls,
///   config: CarouselConfig(
///     cardWidth: 200,
///     perspective: 400,
///     cardCount: 8,
///     animationDuration: Duration(seconds: 16),
///   ),
/// )
/// ```
class Carousel3DAlt extends StatefulWidget {
  /// List of full image URLs to display.
  /// Defaults to [kDefaultUnsplashIds] converted to Unsplash URLs when `null`.
  final List<String>? images;

  /// Carousel geometry and animation settings.
  /// Defaults to [CarouselConfig.alt].
  final CarouselConfig config;

  /// Width of the outer container.
  final double containerWidth;

  /// Height of the outer container.
  final double containerHeight;

  const Carousel3DAlt({
    super.key,
    this.images,
    this.config = CarouselConfig.alt,
    this.containerWidth = 600,
    this.containerHeight = 400,
  });

  @override
  State<Carousel3DAlt> createState() => _Carousel3DAltState();
}

class _Carousel3DAltState extends State<Carousel3DAlt>
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
