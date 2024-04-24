// ignore_for_file: must_be_immutable

library carousel_custom_slider;

import 'dart:async';

import 'package:carousel_custom_slider/src/auto_scrolling_wheel.dart';
import 'package:carousel_custom_slider/src/page_view_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

/// A customizable carousel widget that displays a list of images or other content
/// in a horizontally or vertically scrolling list.
///
///Example:
///
/// ```dart
/// CarouselCustomSlider(
///   sliderList: [
///     'image1.jpg',
///     'image2.jpg',
///     'image3.jpg',
///   ],
///   viewportFraction: 0.8,
///   height: 200,
///   reverse: true,
///   effect: DepthEffect(),
///   onDotClicked: (index) {
///     print('Clicked on dot $index');
///   },
/// )
/// ```
class CarouselCustomSlider extends StatefulWidget {
  /// [sliderList]: The list of images to display in the carousel.
  final List<String> sliderList;

  /// [sliderTitlePost]: Optional list of titles corresponding to each image.
  final List<String>? sliderTitlePost;

  /// [sliderBodyPost]: Optional list of body text corresponding to each image.
  final List<String>? sliderBodyPost;

  /// [viewportFraction]: The fraction of the viewport that each item in the carousel occupies.
  final double viewportFraction;

  /// [width]: The width of the carousel.
  final double width;

  /// [height]: The height of the carousel.
  final double height;

  /// [reverse]: Whether to reverse the order of the items in the carousel.
  final bool reverse;

  /// [scrollDirection]: The direction in which the carousel scrolls.
  final Axis scrollDirection;

  /// [alignmentPositionIndicator]: The alignment position of the indicator.
  final AlignmentGeometry alignmentPositionIndicator;

  /// [alignmentPositionTitleText]: The alignment position of the title text.
  final AlignmentGeometry alignmentPositionTitleText;

  /// [alignmentPositionBodyText]: The alignment position of the body text.
  AlignmentGeometry alignmentPositionBodyText;

  /// [titleStyle]: The style of the title text.
  final TextStyle titleStyle;

  /// [bodyStyle]: The style of the body text.
  final TextStyle bodyStyle;

  /// [effect]: The effect to apply to the carousel items.
  /// You can use these indicators in the effect.
  /// ```dart
  /// effect : WormEffect(),
  /// effect : JumpingDotEffect(),
  /// effect : ScaleEffect(),
  /// effect : ScrollingDotsEffect(),
  /// effect : SlideEffect(),
  /// effect : ExpandingDotsEffect(),
  /// effect : SwapEffect(
  /// dotHeight: 12.0,
  ///  dotWidth: 12.0,
  ///  paintStyle: PaintingStyle.fill,
  ///  type: SwapType.yRotation,
  ///  activeDotColor: Theme.of(context).primaryColor,
  /// dotColor: Theme.of(context).colorScheme.inversePrimary,
  /// ),
  ///```

  final IndicatorEffect effect;

  /// [axisDirectionIndicator]: The axis direction of the indicator.
  final Axis axisDirectionIndicator;

  /// [textDirectionIndicator]: The text direction of the indicator.
  final TextDirection? textDirectionIndicator;

  /// [onDotClicked]: Callback function called when a dot indicator is clicked.
  final void Function(int)? onDotClicked;

  /// [viewportFractionPaddingHorizontal]: The horizontal padding between items in the carousel.
  final double viewportFractionPaddingHorizontal;

  /// [viewportFractionPaddingVertical]: The vertical padding between items in the carousel.
  final double viewportFractionPaddingVertical;

  /// [pageSnapping]: Whether to snap to each item in the carousel when scrolling.
  final bool pageSnapping;

  /// [allowImplicitScrolling]: Whether to allow implicit scrolling.
  final bool allowImplicitScrolling;

  /// [clipBehavior]: The clip behavior of the carousel.
  final Clip clipBehavior;

  /// [dragStartBehavior]: The drag start behavior of the carousel.
  final DragStartBehavior dragStartBehavior;

  /// [findChildIndexCallback]: Callback function to find the index of a child item.
  final int? Function(Key)? findChildIndexCallback;

  /// [padEnds]: Whether to pad the ends of the carousel.
  final bool padEnds;

  /// [physics]: The scroll physics of the carousel.
  final ScrollPhysics? physics;

  /// [restorationId]: The restoration ID of the carousel.
  final String? restorationId;

  /// [scrollBehavior]: The scroll behavior of the carousel.
  final ScrollBehavior? scrollBehavior;

  /// [backgroundColor]: The background color of the carousel.
  final Color backgroundColor;

  /// [isVerticalIndicator]: Whether the indicator is vertical.

  final bool isVerticalIndicator;

  /// [paddingBodyText]: The padding around the body text.
  final EdgeInsetsGeometry paddingBodyText;

  /// [paddingTitleText]: The padding around the title text.
  final EdgeInsetsGeometry paddingTitleText;

  /// [initialPage]: The initial page of the carousel.
  final int initialPage;

  /// [autoPlay]: Whether to automatically play the carousel.
  final bool autoPlay;

  /// [autoPlayInterval]: The interval between auto play animations.
  final Duration autoPlayInterval;

  /// [autoPlayAnimationDuration]: The duration of auto play animations.
  final Duration autoPlayAnimationDuration;

  /// [autoPlayCurve]: The curve of auto play animations.
  final Curve autoPlayCurve;

  /// [doubleTapZoom]: Whether to enable double tap zoom.
  final bool doubleTapZoom;

  /// [clipBehaviorZoom]: The clip behavior of zoom.
  final bool clipBehaviorZoom;

  /// [fitPic]: The fit of the picture.
  final BoxFit? fitPic;

  /// [isdisplayIndicator]: Whether to display the indicator.
  final bool isDisplayIndicator;

  final AlignmentGeometry alignmentVerticalPositionIndicator;

  final EdgeInsetsGeometry paddingVerticalPositionIndicator;
  CarouselCustomSlider({
    super.key,
    required this.sliderList,
    this.sliderTitlePost,
    this.sliderBodyPost,
    this.viewportFractionPaddingHorizontal = 0,
    this.viewportFractionPaddingVertical = 0,
    this.height = 350,
    this.width = double.infinity,
    this.reverse = false,
    this.viewportFraction = 1.0,
    this.scrollDirection = Axis.horizontal,
    this.alignmentPositionIndicator = Alignment.bottomCenter,
    this.alignmentPositionTitleText = Alignment.topLeft,
    this.alignmentPositionBodyText = Alignment.topLeft,
    this.onDotClicked,
    this.axisDirectionIndicator = Axis.horizontal,
    this.textDirectionIndicator = TextDirection.ltr,
    this.pageSnapping = true,
    this.allowImplicitScrolling = false,
    this.clipBehavior = Clip.hardEdge,
    this.dragStartBehavior = DragStartBehavior.start,
    this.findChildIndexCallback,
    this.padEnds = true,
    this.isDisplayIndicator = true,
    this.physics,
    this.restorationId,
    this.scrollBehavior,
    this.backgroundColor = Colors.white,
    this.isVerticalIndicator = false,
    this.paddingBodyText =
        const EdgeInsets.only(top: 70.0, bottom: 70, right: 25.0, left: 25.0),
    this.paddingTitleText = const EdgeInsets.all(25.0),
    this.initialPage = 0,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(seconds: 1),
    this.autoPlayCurve = Curves.easeInSine,
    this.doubleTapZoom = false,
    this.clipBehaviorZoom = false,
    this.fitPic = BoxFit.cover,
    this.alignmentVerticalPositionIndicator = Alignment.centerLeft,
    this.paddingVerticalPositionIndicator =
        const EdgeInsets.symmetric(horizontal: 15.0),
    this.titleStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.bodyStyle = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    this.effect = const SlideEffect(
      dotHeight: 8,
      dotWidth: 8,
    ),
  });

  static Widget autoScrollingWheel({
    required final List<Widget> children,
    final Duration duration = const Duration(seconds: 3),
    final Curve curve = Curves.ease,
    final List<String>? backgroundImageUrls,
    final Color? backgroundColor,
    final double height = 200,
    final ScrollPhysics? physics,
    final double diameterRatio = RenderListWheelViewport.defaultDiameterRatio,
    final double perspective = RenderListWheelViewport.defaultPerspective,
    final double offAxisFraction = 0.0,
    final bool useMagnifier = false,
    final double magnification = 1.0,
    final double overAndUnderCenterOpacity = 1.0,
    final double squeeze = 1.0,
    final ValueChanged<int>? onSelectedItemChanged,
    final bool renderChildrenOutsideViewport = false,
    final Clip clipBehavior = Clip.hardEdge,
    final String? restorationId,
    final ScrollBehavior? scrollBehavior,
    final bool autoPlay = true,
    final Widget Function(BuildContext, Object, StackTrace?)?
        errorBuilderBackgroundImage,
  }) {
    return AutoScrollingWheel(
      autoPlay: autoPlay,
      duration: duration,
      curve: curve,
      backgroundColor: backgroundColor,
      backgroundImageUrls: backgroundImageUrls,
      clipBehavior: clipBehavior,
      diameterRatio: diameterRatio,
      height: height,
      magnification: magnification,
      offAxisFraction: offAxisFraction,
      onSelectedItemChanged: onSelectedItemChanged,
      overAndUnderCenterOpacity: overAndUnderCenterOpacity,
      perspective: perspective,
      physics: physics,
      renderChildrenOutsideViewport: renderChildrenOutsideViewport,
      restorationId: restorationId,
      scrollBehavior: scrollBehavior,
      squeeze: squeeze,
      useMagnifier: useMagnifier,
      errorBuilderBackgroundImage: errorBuilderBackgroundImage,
      children: children,
    );
  }

  @override
  State<CarouselCustomSlider> createState() => _CarouselCustomSliderState();
}

class _CarouselCustomSliderState extends State<CarouselCustomSlider> {
  /// PageView
  late List<Widget> _pageList;

  int currentPageIndex = 0;

  /// PageController
  late final PageController _pageController = PageController(
    initialPage: widget.initialPage,
    viewportFraction: widget.viewportFraction,
  );

  /// Timer for auto play
  Timer? _timer;

  /// Start timer
  void startTimer() {
    if (widget.autoPlay) {
      // Only start timer if autoplay is enabled
      _timer = Timer.periodic(widget.autoPlayInterval, (timer) {
        if (_pageController.page == widget.sliderList.length - 1) {
          _pageController.animateToPage(
            0,
            duration: widget.autoPlayAnimationDuration,
            curve: widget.autoPlayCurve,
          );
        } else {
          _pageController.nextPage(
            duration: widget.autoPlayAnimationDuration,
            curve: widget.autoPlayCurve,
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _pageList = List.generate(
      widget.sliderList.length,
      (index) => PageViewWidget(
          widget: widget, index: index, controller: _pageController),
    );
    startTimer();
  }

  /// Dispose timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          PageView.builder(
            pageSnapping: widget.pageSnapping,
            allowImplicitScrolling: widget.allowImplicitScrolling,
            clipBehavior: widget.clipBehavior,
            dragStartBehavior: widget.dragStartBehavior,
            findChildIndexCallback: widget.findChildIndexCallback,
            padEnds: widget.padEnds,
            physics: widget.physics,
            restorationId: widget.restorationId,
            scrollBehavior: widget.scrollBehavior,
            controller: _pageController, // Use PageController
            itemCount: widget.sliderList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: widget.viewportFractionPaddingHorizontal,
                  vertical: widget.viewportFractionPaddingVertical,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: _pageList[index],
                ),
              );
            },
            onPageChanged: (value) {
              setState(() {
                currentPageIndex = value;
              });
            }, // Update current page on change
            reverse: widget.reverse,
            scrollDirection: widget.scrollDirection,
          ),
          widget.isVerticalIndicator
              ? Padding(
                  padding: widget.paddingVerticalPositionIndicator,
                  child: Align(
                    alignment: widget.alignmentVerticalPositionIndicator,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.sliderList.length,
                        effect: widget.effect,
                        axisDirection: widget.axisDirectionIndicator,
                        textDirection: widget.textDirectionIndicator,
                        onDotClicked: widget.onDotClicked,
                      ),
                    ),
                  ),
                )
              : Align(
                  alignment: widget.alignmentPositionIndicator,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.sliderList.length,
                      effect: widget.effect,
                      axisDirection: widget.axisDirectionIndicator,
                      textDirection: widget.textDirectionIndicator,
                      onDotClicked: widget.onDotClicked,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}



/**Align(
                  alignment: Alignment.centerLeft,
                  child: Transform.rotate(
                    filterQuality: FilterQuality.medium,
                    angle: pi / 360 * 180,
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: widget.sliderList.length,
                      effect: widget.effect,
                      axisDirection: widget.axisDirectionIndicator,
                      textDirection: widget.textDirectionIndicator,
                      onDotClicked: widget.onDotClicked,
                    ),
                  ),
                ) */