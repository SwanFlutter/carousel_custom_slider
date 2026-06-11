// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

/// A coverflow-style carousel with a real 3-D Y-axis rotation effect.
///
/// Cards fan out on either side of the active card. Tapping a side card
/// navigates to it. Arrow buttons and dot indicators are shown by default.
/// Drag / fling horizontally for smooth controlled navigation.
///
/// Example:
/// ```dart
/// CoverflowCarousel(
///   items: [
///     CoverflowItem(src: 'https://i.pravatar.cc/300?img=1', title: 'Card 1'),
///     CoverflowItem(src: 'https://i.pravatar.cc/300?img=2', title: 'Card 2'),
///   ],
///   cardWidth: 200,
///   cardAspectRatio: 3 / 4,
/// )
/// ```
class CoverflowCarousel extends StatefulWidget {
  final List<CoverflowItem> items;

  /// Width of each card. Defaults to 200.
  final double cardWidth;

  /// Aspect ratio (width/height). Defaults to 3/4.
  final double cardAspectRatio;

  /// Y-axis rotation in degrees per offset step. Defaults to 55.
  final double rotationDegrees;

  /// Scale of non-active cards (0–1). Defaults to 0.82.
  final double inactiveScale;

  /// Horizontal spread between cards as fraction of [cardWidth]. Defaults to 0.52.
  final double overlapFactor;

  /// Animation duration when navigating programmatically. Defaults to 450 ms.
  final Duration animationDuration;

  /// Animation curve. Defaults to [Curves.easeOutCubic].
  final Curve animationCurve;

  /// Title fade duration. Defaults to 350 ms.
  final Duration titleFadeDuration;

  /// Text style for the title. Defaults to 14sp dark.
  final TextStyle? titleStyle;

  /// Show arrow + dot controls. Defaults to true.
  final bool showControls;

  final Color controlsBackgroundColor;
  final Color controlsBorderColor;
  final Color controlsActiveColor;
  final Color controlsInactiveColor;

  /// Width of dot row inside controls. Defaults to 180.
  final double dotsRowWidth;
  final double dotHeight;
  final double activeDotWidth;
  final double inactiveDotWidth;
  final double dotHorizontalMargin;

  /// Callback when active index changes.
  final void Function(int index)? onIndexChanged;

  final Widget Function(BuildContext, double w, double h)? loadingBuilder;
  final Widget Function(BuildContext, Object, StackTrace?, double w, double h)?
  errorBuilder;

  const CoverflowCarousel({
    super.key,
    required this.items,
    this.cardWidth = 200,
    this.cardAspectRatio = 3 / 4,
    this.rotationDegrees = 55,
    this.inactiveScale = 0.82,
    this.overlapFactor = 0.52,
    this.animationDuration = const Duration(milliseconds: 450),
    this.animationCurve = Curves.easeOutCubic,
    this.titleFadeDuration = const Duration(milliseconds: 350),
    this.titleStyle,
    this.showControls = true,
    this.controlsBackgroundColor = const Color(0x80E5E5E5),
    this.controlsBorderColor = const Color(0xCCE5E5E5),
    this.controlsActiveColor = const Color(0xFF404040),
    this.controlsInactiveColor = const Color(0x4D404040),
    this.dotsRowWidth = 180,
    this.dotHeight = 8,
    this.activeDotWidth = 28,
    this.inactiveDotWidth = 8,
    this.dotHorizontalMargin = 3,
    this.onIndexChanged,
    this.loadingBuilder,
    this.errorBuilder,
  });

  @override
  State<CoverflowCarousel> createState() => _CoverflowCarouselState();
}

class _CoverflowCarouselState extends State<CoverflowCarousel>
    with SingleTickerProviderStateMixin {
  // ── Animated index (fractional, 0 = first card) ─────────────────────────────
  late final AnimationController _ctrl;
  late Animation<double> _indexAnim;

  double _currentIndex = 0; // target (snapped)
  double _animatedIndex = 0; // live value driving visuals

  // ── Drag state ───────────────────────────────────────────────────────────────
  double _dragStart = 0;
  double _dragBaseIndex = 0;

  int get _count => widget.items.length;
  double get _cardH => widget.cardWidth / widget.cardAspectRatio;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _indexAnim = AlwaysStoppedAnimation(0);
    _ctrl.addListener(() {
      setState(() => _animatedIndex = _indexAnim.value);
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  // ── Animate to a snapped index ───────────────────────────────────────────────
  void _animateTo(double target) {
    target = target.clamp(0, _count - 1.0);
    final from = _animatedIndex;
    _indexAnim = Tween<double>(
      begin: from,
      end: target,
    ).animate(CurvedAnimation(parent: _ctrl, curve: widget.animationCurve));
    _ctrl
      ..value = 0
      ..forward();
    _currentIndex = target;
    widget.onIndexChanged?.call(target.round());
  }

  void _goTo(int idx) => _animateTo(idx.clamp(0, _count - 1).toDouble());
  void _prev() => _goTo(_currentIndex.round() - 1);
  void _next() => _goTo(_currentIndex.round() + 1);

  // ── Drag handlers ────────────────────────────────────────────────────────────
  void _onDragStart(DragStartDetails d) {
    _ctrl.stop();
    _dragStart = d.globalPosition.dx;
    _dragBaseIndex = _animatedIndex;
  }

  void _onDragUpdate(DragUpdateDetails d) {
    // 1 card width of drag = 1 index step
    final delta = (_dragStart - d.globalPosition.dx) / widget.cardWidth;
    setState(() {
      _animatedIndex = (_dragBaseIndex + delta).clamp(0, _count - 1.0);
    });
  }

  void _onDragEnd(DragEndDetails d) {
    // Snap: use fling velocity to decide direction, otherwise snap nearest
    final vel = d.velocity.pixelsPerSecond.dx;
    double target;
    if (vel.abs() > 300) {
      target = vel < 0
          ? (_animatedIndex + 1).floorToDouble()
          : (_animatedIndex - 1).ceilToDouble();
    } else {
      target = _animatedIndex.roundToDouble();
    }
    _animateTo(target);
  }

  // ── Render order: farthest first, active on top ──────────────────────────────
  List<int> _renderOrder() {
    final indices = List<int>.generate(_count, (i) => i);
    indices.sort((a, b) {
      final da = (a - _animatedIndex).abs();
      final db = (b - _animatedIndex).abs();
      return db.compareTo(da);
    });
    return indices;
  }

  // ── Card ─────────────────────────────────────────────────────────────────────
  Widget _buildCard(int i) {
    final offset = _animatedIndex - i;
    final bool isActive = offset.abs() < 0.5;

    const pi = 3.1415926535;
    final rotY = offset * widget.rotationDegrees * pi / 180;
    final scale =
        1.0 -
        (offset.abs() * (1 - widget.inactiveScale)).clamp(
          0.0,
          1 - widget.inactiveScale,
        );
    final translateX = -offset * widget.cardWidth * widget.overlapFactor;

    return Positioned(
      left: translateX,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(rotY)
          ..multiply(Matrix4.diagonal3Values(scale, scale, scale)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Image ────────────────────────────────────────────────────
            GestureDetector(
              onTap: () => _goTo(i),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.items[i].src,
                  width: widget.cardWidth,
                  height: _cardH,
                  fit: BoxFit.cover,
                  loadingBuilder: (ctx, child, prog) {
                    if (prog == null) return child;
                    return widget.loadingBuilder?.call(
                          ctx,
                          widget.cardWidth,
                          _cardH,
                        ) ??
                        Container(
                          width: widget.cardWidth,
                          height: _cardH,
                          color: Colors.grey.shade300,
                          child: const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                  },
                  errorBuilder: (ctx, err, st) =>
                      widget.errorBuilder?.call(
                        ctx,
                        err,
                        st,
                        widget.cardWidth,
                        _cardH,
                      ) ??
                      Container(
                        width: widget.cardWidth,
                        height: _cardH,
                        color: Colors.grey.shade300,
                        child: const Center(child: Icon(Icons.broken_image)),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // ── Title ────────────────────────────────────────────────────
            AnimatedOpacity(
              duration: widget.titleFadeDuration,
              opacity: isActive ? 1.0 : 0.0,
              child: Text(
                widget.items[i].title,
                style:
                    widget.titleStyle ??
                    const TextStyle(fontSize: 14, color: Color(0xFF262626)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Controls ─────────────────────────────────────────────────────────────────
  Widget _buildControls() {
    final active = _currentIndex.round();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.controlsBackgroundColor,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: widget.controlsBorderColor),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _prev,
            icon: const Icon(Icons.chevron_left),
            color: widget.controlsActiveColor,
          ),
          SizedBox(
            width: widget.dotsRowWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _count; i++)
                  GestureDetector(
                    onTap: () => _goTo(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(
                        horizontal: widget.dotHorizontalMargin,
                      ),
                      height: widget.dotHeight,
                      width: active == i
                          ? widget.activeDotWidth
                          : widget.inactiveDotWidth,
                      decoration: BoxDecoration(
                        color: active == i
                            ? widget.controlsActiveColor
                            : widget.controlsInactiveColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            onPressed: _next,
            icon: const Icon(Icons.chevron_right),
            color: widget.controlsActiveColor,
          ),
        ],
      ),
    );
  }

  // ── Build ─────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: Stack(
        children: [
          Center(
            child: SizedBox(
              width: widget.cardWidth,
              height: _cardH + 40,
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [for (final i in _renderOrder()) _buildCard(i)],
              ),
            ),
          ),
          if (widget.showControls)
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(child: _buildControls()),
            ),
        ],
      ),
    );
  }
}

// ─── Data model ────────────────────────────────────────────────────────────────

/// Holds the data for a single coverflow carousel card.
class CoverflowItem {
  final String src;
  final String title;
  const CoverflowItem({required this.src, required this.title});
}
