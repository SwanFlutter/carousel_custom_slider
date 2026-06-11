import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// A single item in [WheelGallery].
class WheelGalleryItem {
  /// URL of the image to display.
  final String src;

  /// Title displayed below the focused card.
  final String title;

  const WheelGalleryItem({required this.src, this.title = ''});
}

/// A circular wheel gallery with scroll-driven animation.
///
/// Cards are arranged around a circle. Scrolling the page rotates the wheel
/// one card at a time (steps). The top card is in full focus (sharp, colored)
/// while others fade to grayscale and blur based on distance.
///
/// ## Usage
///
/// ```dart
/// WheelGallery(
///   items: [
///     WheelGalleryItem(
///       src: 'https://picsum.photos/id/634/1200/1200',
///       title: 'A Misty Morning',
///     ),
///     WheelGalleryItem(
///       src: 'https://picsum.photos/id/228/1200/1200',
///       title: 'Harvest',
///     ),
///   ],
/// )
/// ```
class WheelGallery extends StatefulWidget {
  /// List of items to display.
  final List<WheelGalleryItem> items;

  /// Card aspect ratio (width/height). Defaults to 4/6.
  final double cardAspectRatio;

  /// Border radius of cards. Defaults to 14.
  final double cardBorderRadius;

  /// Background color. Defaults to Color(0xFFF8F4EE) in light, Color(0xFF101828) in dark.
  final Color? backgroundColor;

  /// Maximum blur for distant cards. Defaults to 7.0.
  final double maxBlur;

  /// Scroll height multiplier — how many screen-heights to fill with scroll.
  /// Defaults to 12 (mimics `height: 1200svh`).
  final double scrollHeightMultiplier;

  /// Whether to show the mouse/scroll hint. Defaults to true.
  final bool showScrollHint;

  /// Callback when focused card changes.
  final void Function(int index)? onFocusChanged;

  /// Title text style.
  final TextStyle? titleStyle;

  /// Optional loading placeholder builder.
  final Widget Function(BuildContext context, double width, double height)?
  loadingBuilder;

  /// Optional error widget builder.
  final Widget Function(
    BuildContext context,
    Object error,
    StackTrace? stackTrace,
    double width,
    double height,
  )?
  errorBuilder;

  const WheelGallery({
    super.key,
    required this.items,
    this.cardAspectRatio = 4 / 6,
    this.cardBorderRadius = 14,
    this.backgroundColor,
    this.maxBlur = 7.0,
    this.scrollHeightMultiplier = 12,
    this.showScrollHint = true,
    this.onFocusChanged,
    this.titleStyle,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  State<WheelGallery> createState() => _WheelGalleryState();
}

class _WheelGalleryState extends State<WheelGallery>
    with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _mouseController;

  double _progress = 0.0;
  int _lastFocusIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _mouseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    final maxScroll = position.maxScrollExtent;
    final next = maxScroll <= 0
        ? 0.0
        : (position.pixels / maxScroll).clamp(0.0, 1.0).toDouble();

    if ((next - _progress).abs() > 0.0005) {
      setState(() => _progress = next);
      _checkFocusChange();
    }
  }

  void _checkFocusChange() {
    final count = widget.items.length;
    if (count == 0) return;
    final idx = (_progress * (count - 1)).round().clamp(0, count - 1);
    if (idx != _lastFocusIndex) {
      _lastFocusIndex = idx;
      widget.onFocusChanged?.call(idx);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _mouseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        widget.backgroundColor ??
        (isDark ? const Color(0xFF101828) : const Color(0xFFF8F4EE));

    return ColoredBox(
      color: bgColor,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final pageHeight =
              constraints.maxHeight * widget.scrollHeightMultiplier;
          return Stack(
            children: [
              // Scroll driver — invisible, just provides scroll position
              SingleChildScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: pageHeight,
                ),
              ),

              // Wheel — ignores pointer so scroll still works
              Positioned.fill(
                child: IgnorePointer(
                  child: _WheelRenderer(
                    items: widget.items,
                    progress: _progress,
                    cardAspectRatio: widget.cardAspectRatio,
                    cardBorderRadius: widget.cardBorderRadius,
                    maxBlur: widget.maxBlur,
                    titleStyle: widget.titleStyle,
                    loadingBuilder: widget.loadingBuilder,
                    errorBuilder: widget.errorBuilder,
                  ),
                ),
              ),

              // Scroll hint
              if (widget.showScrollHint)
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 18,
                  child: IgnorePointer(
                    child: _MouseHint(
                      progress: _progress,
                      controller: _mouseController,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Wheel renderer
// ─────────────────────────────────────────────────────────────────────────────

class _WheelRenderer extends StatelessWidget {
  final List<WheelGalleryItem> items;
  final double progress;
  final double cardAspectRatio;
  final double cardBorderRadius;
  final double maxBlur;
  final TextStyle? titleStyle;
  final Widget Function(BuildContext, double, double)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?, double, double)?
  errorBuilder;

  const _WheelRenderer({
    required this.items,
    required this.progress,
    required this.cardAspectRatio,
    required this.cardBorderRadius,
    required this.maxBlur,
    this.titleStyle,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final count = items.length;
        if (count == 0) return const SizedBox.shrink();

        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;

        final cardWidth = math.max(150.0, screenWidth * 0.20);
        final cardHeight = cardWidth / cardAspectRatio;

        final radius = cardWidth * count / (2 * math.pi);

        // Anchor the active card to ~58% screen height
        final activeAnchorY = math.min(
          screenHeight - 56.0,
          math.max(cardHeight + 48.0, screenHeight * 0.58),
        );
        final center = Offset(screenWidth / 2, activeAnchorY + radius);

        // Steps like CSS `animation-timing-function: steps(count)`
        final targetStep = (progress * (count - 1)).round();
        final targetRotation = -targetStep * 2 * math.pi / count;

        final isDark = Theme.of(context).brightness == Brightness.dark;
        final textColor = isDark
            ? const Color(0xFFF5F5F5)
            : const Color(0xFF0A0A0A);

        return TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: targetRotation),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          builder: (context, rotation, _) {
            final layouts = <_CardLayout>[];

            for (int i = 0; i < count; i++) {
              final baseAngle = -math.pi / 2 + 2 * math.pi * i / count;
              final angle = baseAngle + rotation;
              final anchor = Offset(
                center.dx + math.cos(angle) * radius,
                center.dy + math.sin(angle) * radius,
              );

              final distance =
                  (_normalizeAngle(angle + math.pi / 2).abs() / (2 * math.pi))
                      .clamp(0.0, 0.5)
                      .toDouble();

              final opacity = (1 - distance / 0.15).clamp(0.0, 1.0).toDouble();
              final grayscale = (distance * count).clamp(0.0, 1.0).toDouble();

              const focusRange = 0.10;
              final blur =
                  math.min(distance, focusRange) / focusRange * maxBlur;

              final captionOpacity = (1 - distance / 0.025)
                  .clamp(0.0, 1.0)
                  .toDouble();

              layouts.add(
                _CardLayout(
                  index: i,
                  anchor: anchor,
                  cardAngle: angle + math.pi / 2,
                  distance: distance,
                  opacity: opacity,
                  grayscale: grayscale,
                  blur: blur,
                  captionOpacity: captionOpacity,
                ),
              );
            }

            // Draw distant cards first so focused card is on top
            layouts.sort((a, b) => b.distance.compareTo(a.distance));

            return Stack(
              clipBehavior: Clip.none,
              children: [
                for (final layout in layouts)
                  _WheelCard(
                    item: items[layout.index],
                    anchor: layout.anchor,
                    width: cardWidth,
                    height: cardHeight,
                    rotation: layout.cardAngle,
                    opacity: layout.opacity,
                    grayscale: layout.grayscale,
                    blur: layout.blur,
                    captionOpacity: layout.captionOpacity,
                    captionColor: textColor,
                    borderRadius: cardBorderRadius,
                    titleStyle: titleStyle,
                    loadingBuilder: loadingBuilder,
                    errorBuilder: errorBuilder,
                  ),
              ],
            );
          },
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Single card
// ─────────────────────────────────────────────────────────────────────────────

class _WheelCard extends StatelessWidget {
  final WheelGalleryItem item;
  final Offset anchor;
  final double width;
  final double height;
  final double rotation;
  final double opacity;
  final double grayscale;
  final double blur;
  final double captionOpacity;
  final Color captionColor;
  final double borderRadius;
  final TextStyle? titleStyle;
  final Widget Function(BuildContext, double, double)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?, double, double)?
  errorBuilder;

  const _WheelCard({
    required this.item,
    required this.anchor,
    required this.width,
    required this.height,
    required this.rotation,
    required this.opacity,
    required this.grayscale,
    required this.blur,
    required this.captionOpacity,
    required this.captionColor,
    required this.borderRadius,
    this.titleStyle,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: anchor.dx - width / 2,
      top: anchor.dy - height,
      width: width,
      height: height,
      child: Transform.rotate(
        angle: rotation,
        alignment: Alignment.bottomCenter,
        child: Opacity(
          opacity: opacity,
          child: SizedBox(
            width: width,
            height: height,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Card image
                Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.18),
                        blurRadius: 22,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: ImageFiltered(
                      imageFilter: ui.ImageFilter.blur(
                        sigmaX: blur,
                        sigmaY: blur,
                      ),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.matrix(
                          _grayscaleMatrix(grayscale),
                        ),
                        child: Image.network(
                          item.src,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          loadingBuilder: (ctx, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            if (loadingBuilder != null) {
                              return loadingBuilder!(ctx, width, height);
                            }
                            return _defaultPlaceholder(
                              ctx,
                              loadingProgress,
                              width,
                              height,
                            );
                          },
                          errorBuilder: (ctx, err, stack) {
                            if (errorBuilder != null) {
                              return errorBuilder!(
                                ctx,
                                err,
                                stack,
                                width,
                                height,
                              );
                            }
                            return _defaultError(width, height);
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // Caption
                if (item.title.isNotEmpty)
                  Positioned(
                    top: height + 12,
                    left: 16,
                    width: width * 1.45,
                    child: Opacity(
                      opacity: captionOpacity,
                      child: Transform.translate(
                        offset: Offset(0, -80 * (1 - captionOpacity)),
                        child: Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.visible,
                          style:
                              titleStyle ??
                              TextStyle(
                                color: captionColor,
                                fontSize: (width * 0.13)
                                    .clamp(18.0, 32.0)
                                    .toDouble(),
                                height: 1.0,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.2,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withValues(alpha: 0.10),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _defaultPlaceholder(
    BuildContext ctx,
    ImageChunkEvent loadingProgress,
    double w,
    double h,
  ) {
    final expected = loadingProgress.expectedTotalBytes;
    return Container(
      width: w,
      height: h,
      color: Colors.black.withValues(alpha: 0.07),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          value: expected == null
              ? null
              : loadingProgress.cumulativeBytesLoaded / expected,
        ),
      ),
    );
  }

  Widget _defaultError(double w, double h) => Container(
    width: w,
    height: h,
    color: Colors.black.withValues(alpha: 0.08),
    alignment: Alignment.center,
    child: const Icon(Icons.broken_image_outlined, size: 34),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Mouse / scroll hint
// ─────────────────────────────────────────────────────────────────────────────

class _MouseHint extends StatelessWidget {
  final double progress;
  final AnimationController controller;

  const _MouseHint({required this.progress, required this.controller});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? const Color(0xFFF5F5F5) : const Color(0xFF0A0A0A);
    final opacity = (1 - progress / 0.12).clamp(0.0, 1.0).toDouble();

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 250),
      opacity: opacity,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          final dy = 4 * math.sin(controller.value * math.pi);
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.mouse_outlined,
                size: 40,
                color: color.withValues(alpha: 0.9),
              ),
              Transform.translate(
                offset: Offset(0, -8 + dy),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 30,
                  color: color.withValues(alpha: 0.9),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────────────────────────────────────

class _CardLayout {
  final int index;
  final Offset anchor;
  final double cardAngle;
  final double distance;
  final double opacity;
  final double grayscale;
  final double blur;
  final double captionOpacity;

  const _CardLayout({
    required this.index,
    required this.anchor,
    required this.cardAngle,
    required this.distance,
    required this.opacity,
    required this.grayscale,
    required this.blur,
    required this.captionOpacity,
  });
}

double _normalizeAngle(double angle) {
  var a = angle;
  while (a <= -math.pi) {
    a += 2 * math.pi;
  }
  while (a > math.pi) {
    a -= 2 * math.pi;
  }
  return a;
}

List<double> _grayscaleMatrix(double amount) {
  final a = amount.clamp(0.0, 1.0).toDouble();
  const r = 0.2126;
  const g = 0.7152;
  const b = 0.0722;
  return [
    r * a + 1 - a,
    g * a,
    b * a,
    0,
    0,
    r * a,
    g * a + 1 - a,
    b * a,
    0,
    0,
    r * a,
    g * a,
    b * a + 1 - a,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
}
