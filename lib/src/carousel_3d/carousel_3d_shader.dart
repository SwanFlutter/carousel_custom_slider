import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'carousel_config.dart';

/// A 3D rotating carousel with a full-screen lateral fade applied via [ShaderMask].
///
/// The shader gradient spans the entire viewport width so cards smoothly
/// appear and disappear at screen edges.
///
/// ## Usage
///
/// ```dart
/// // Using default Unsplash demo images
/// Carousel3DShader()
///
/// // Providing your own image URLs
/// Carousel3DShader(
///   images: ['https://example.com/a.jpg', 'https://example.com/b.jpg'],
///   config: CarouselConfig(
///     cardCount: 8,
///     animationDuration: Duration(seconds: 20),
///   ),
/// )
/// ```
class Carousel3DShader extends StatefulWidget {
  /// List of full image URLs to display.
  /// Defaults to [kDefaultUnsplashIds] converted to Unsplash URLs when `null`.
  final List<String>? images;

  /// Carousel geometry and animation settings.
  /// Defaults to [CarouselConfig.shader].
  final CarouselConfig config;

  const Carousel3DShader({
    super.key,
    this.images,
    this.config = CarouselConfig.shader,
  });

  @override
  State<Carousel3DShader> createState() => _Carousel3DShaderState();
}

class _Carousel3DShaderState extends State<Carousel3DShader>
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

    return ShaderMask(
      shaderCallback: (rect) => const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.transparent,
          Colors.black,
          Colors.black,
          Colors.transparent,
        ],
        stops: [0.0, 0.2, 0.8, 1.0],
      ).createShader(rect),
      blendMode: BlendMode.dstIn,
      child: Center(
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
      ),
    );
  }

  Widget _buildCard(int index, double baseAngle, double translateZ) {
    final cfg = widget.config;
    final angle = _controller.value * 2 * math.pi + index * baseAngle;
    final normalized = angle % (2 * math.pi);

    // Backface culling: skip cards facing away from the camera.
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
