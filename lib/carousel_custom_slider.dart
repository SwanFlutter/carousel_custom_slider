// ignore_for_file: must_be_immutable

library;

import 'dart:async';

import 'package:carousel_custom_slider/src/advanced_carousel_slider.dart';
import 'package:carousel_custom_slider/src/auto_scrolling_wheel.dart';
import 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_alt.dart';
import 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_shader.dart';
import 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_widget.dart';
import 'package:carousel_custom_slider/src/carousel_3d/carousel_config.dart';
import 'package:carousel_custom_slider/src/coverflow_carousel.dart';
import 'package:carousel_custom_slider/src/parallax.dart';
import 'package:carousel_custom_slider/src/reflection.dart';
import 'package:carousel_custom_slider/src/simple_page_widget.dart';
import 'package:carousel_custom_slider/src/tools/animated_builder_settings.dart';
import 'package:carousel_custom_slider/src/transformed_3d_card_slider.dart';
import 'package:carousel_custom_slider/src/transformed_card_slider.dart';
import 'package:carousel_custom_slider/src/wheel_gallery.dart';
import 'package:carousel_custom_slider/src/widget/page_view_widget.dart';
import 'package:carousel_custom_slider/transform_type.dart';
import 'package:carousel_custom_slider/transform_type_3d.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

export 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_alt.dart';
export 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_shader.dart';
export 'package:carousel_custom_slider/src/carousel_3d/carousel_3d_widget.dart';
export 'package:carousel_custom_slider/src/carousel_3d/carousel_config.dart';
export 'package:carousel_custom_slider/src/coverflow_carousel.dart';
export 'package:carousel_custom_slider/src/tools/animated_builder_settings.dart';
export 'package:carousel_custom_slider/src/wheel_gallery.dart';
export 'package:smooth_page_indicator/smooth_page_indicator.dart';

export 'transform_type.dart';
export 'transform_type_3d.dart';

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

  /// [initialPage]: The initial page of the carousel.
  final int initialPage;

  /// [autoPlay]: Whether to automatically play the carousel.
  final bool autoPlay;

  /// [autoplayDuration]: The interval between auto play animations.
  final Duration autoplayDuration;

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

  /// [alignmentVerticalPositionIndicator]: The alignment position of the vertical position indicator.
  final AlignmentGeometry alignmentVerticalPositionIndicator;

  /// [paddingVerticalPositionIndicator]: The padding around the vertical position indicator.
  final EdgeInsetsGeometry paddingVerticalPositionIndicator;

  /// [borderRadius]: The border radius of the carousel.
  final BorderRadiusGeometry borderRadius;

  /// [animatedBuilderSettings]: The settings for the animated builder.
  final AnimatedBuilderSettings? animatedBuilderSettings;

  /// A builder function that returns a widget to display on top of each slide.
  ///
  /// The function receives the index of the current slide and returns a widget.
  final Widget Function(int index)? childrenStackBuilder;

  const CarouselCustomSlider({
    super.key,
    required this.sliderList,
    this.viewportFractionPaddingHorizontal = 0,
    this.viewportFractionPaddingVertical = 0,
    this.height = 350,
    this.width = double.infinity,
    this.reverse = false,
    this.viewportFraction = 1.0,
    this.scrollDirection = Axis.horizontal,
    this.alignmentPositionIndicator = Alignment.bottomCenter,
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
    this.initialPage = 0,
    this.autoPlay = true,
    this.autoplayDuration = const Duration(seconds: 3),
    this.autoPlayAnimationDuration = const Duration(seconds: 1),
    this.autoPlayCurve = Curves.easeInSine,
    this.doubleTapZoom = false,
    this.clipBehaviorZoom = false,
    this.fitPic = BoxFit.cover,
    this.alignmentVerticalPositionIndicator = Alignment.centerLeft,
    this.paddingVerticalPositionIndicator = const EdgeInsets.symmetric(
      horizontal: 15.0,
    ),
    this.borderRadius = BorderRadius.zero,
    this.animatedBuilderSettings,
    this.effect = const SlideEffect(dotHeight: 8, dotWidth: 8),
    this.childrenStackBuilder = defaultChildrenStackBuilder,
  });

  /// [autoScrollingWheel]: A widget that automatically ListWheel scrolls to the next item in a list at a specified interval.
  ///

  ///Example:
  ///
  /// ```dart
  /// autoScrollingWheel(
  ///   autoPlay: false,
  ///   height: 150,
  ///   backgroundImageUrls: listImage,
  ///   children: children,
  ///   );
  /// ```
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

  ///Example:
  ///
  /// ```dart
  /// Parallax(
  ///
  ///   imageUrl: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showBackgroundImage: false,
  ///   viewportFraction: 0.7,
  ///   borderRadius: BorderRadius.circular(16.0),
  ///   elevation: 10,
  ///   valueScalingFactor: 0.3,
  ///   customCurve: Curves.easeInOutBack,
  ///   shadowColor: Colors.pink,
  ///   dynamicHeight: 400,
  ///   horizontalTransform: 250,
  ///   children: const [
  ///   Positioned(
  ///   left: 25,
  ///   bottom: 25.0,
  ///   child: Text(
  ///   "Parallax",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget parallax({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The title text displayed on the card.
    final String? title,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.ease,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilder,
  }) {
    return Parallax(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// SimplePageWidget(
  ///
  ///   imageUrl: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showBackgroundImage: false,
  ///   viewportFraction: 0.7,
  ///   borderRadius: BorderRadius.circular(16.0),
  ///   elevation: 10,
  ///   valueScalingFactor: 0.3,
  ///   customCurve: Curves.easeInOutBack,
  ///   shadowColor: Colors.pink,
  ///   dynamicHeight: 400,
  ///   horizontalTransform: 250,
  ///   children: const [
  ///   Positioned(
  ///   left: 25,
  ///   bottom: 25.0,
  ///   child: Text(
  ///   "Hello",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget customCardSimple({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.easeInOutCubic,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final List<Widget> Function(int index)? childrenStackBuilder,
  }) {
    return SimplePageWidget(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      fit: fit,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// TransformedCardSlider(
  ///   transformType: TransformType.skew1,
  ///   imageUrl: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showBackgroundImage: false,
  ///   viewportFraction: 0.7,
  ///   borderRadius: BorderRadius.circular(16.0),
  ///   elevation: 10,
  ///   valueScalingFactor: 0.3,
  ///   customCurve: Curves.easeInOutBack,
  ///   shadowColor: Colors.pink,
  ///   dynamicHeight: 400,
  ///   horizontalTransform: 250,
  ///   children: const [
  ///   Positioned(
  ///   left: 25,
  ///   bottom: 25.0,
  ///   child: Text(
  ///   "transformType: TransformType.skew1",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget transFormedCardSlider({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The elevation of the card, which creates a shadow effect. Defaults to 0.0.
    final double elevation = 0.0,

    /// The color of the shadow. Defaults to black.
    final Color? shadowColor = Colors.black,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.5.
    final double viewportFraction = 0.5,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The duration of the animation when transitioning between cards. Defaults to 700 microseconds.
    final Duration duration = const Duration(milliseconds: 700),

    /// The border radius of the card.
    final BorderRadiusGeometry? borderRadius = BorderRadius.zero,

    /// The border of the card.
    final BoxBorder? border,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white70,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 1200,

    /// The width of the cached image.
    final int? cacheWidth = 1200,

    /// The scaling factor for the image value. Defaults to 0.5.
    final double valueScalingFactor = 0.5,

    /// The dynamic height of the card. Defaults to 400.
    final int dynamicHeight = 400,

    /// The horizontal transform of the card. Defaults to 250.
    final int horizontalTransform = 250,

    /// The explicit height of the card.
    final double? height,

    /// The explicit width of the card.
    final double? width,

    /// The custom curve used for controlling the animation transition in the carousel.
    ///
    /// This curve defines the rate of change of an animation over time. The curve
    /// determines how the animation progresses from its initial state to its final
    /// state. By providing a custom curve, you can create unique animation effects
    /// with different rates of change.
    ///
    /// The [customCurve] can be any valid [Curve] instance from the Flutter framework,
    /// such as linear, easeIn, easeOut, cubic, etc.
    final Curve customCurve = Curves.easeInOutCubic,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The filter quality for widget images.
    final FilterQuality filterQuality = FilterQuality.low,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// The transform type of the card. Defaults to [TransformType.skew].
    final TransformType transformType = TransformType.skew,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final List<Widget> Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilders,
  }) {
    return TransformedCardSlider(
      imageUrl: imageUrl,
      elevation: elevation,
      shadowColor: shadowColor,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      duration: duration,
      borderRadius: borderRadius,
      border: border,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      valueScalingFactor: valueScalingFactor,
      dynamicHeight: dynamicHeight,
      horizontalTransform: horizontalTransform,
      height: height,
      width: width,
      customCurve: customCurve,
      directionality: directionality,
      filterQuality: filterQuality,
      fit: fit,
      transformType: transformType,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// transformed3DCardlider(
  ///   transformType: TransformType.identity,
  ///   imageUrl: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showBackgroundImage: false,
  ///   viewportFraction: 0.8,
  ///   borderRadius: BorderRadius.circular(16.0),
  ///   children: const [
  ///   Positioned(
  ///   left: 25,
  ///   bottom: 25.0,
  ///   child: Text(
  ///   "transformType: TransformType.skew1",
  ///   style: TextStyle(color: Colors.white, fontSize: 30.0),
  ///   ),
  ///   )
  ///   ],
  /// )
  /// ```

  static Widget transformed3DCardlider({
    /// The list of image URLs for the background image of each card.
    required final List<String> imageUrl,

    /// The text direction of the displayed widget.
    final TextDirection directionality = TextDirection.ltr,

    /// The initial page to be displayed in the card slider. Defaults to 1.
    final int initialPage = 1,

    /// The fraction of the viewport occupied by each card in the slider. Defaults to 0.8.
    final double viewportFraction = 0.8,

    /// The explicit height of the box.
    final double? height,

    /// The explicit width of the box.
    final double? width,

    /// The explicit height of the card. Defaults to 400.
    final double? heightCard = 400,

    /// The explicit width of the card.
    final double? widthCard,

    /// Callback function when the card is tapped.
    final void Function()? onTap,

    /// Callback function when the card is double-tapped.
    final void Function()? onDoubleTap,

    /// Callback function when the card is long-pressed.
    final void Function()? onLongPress,

    /// The background color of the card.
    final Color cardBackgroundColor = Colors.white,

    /// A builder function to customize the error widget.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// A builder function to customize the frame of the card.
    final Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,

    /// The height of the cached image.
    final int? cacheHeight = 300,

    /// The width of the cached image.
    final int? cacheWidth = 300,

    /// Determines whether to show the background image on the card. Defaults to true.
    final bool showBackgroundImage = true,

    /// The blur value for the background image. Defaults to 10.0.
    final double sigmaXBlurBackgroundImage = 10.0,

    /// The fit property of the image widget.
    final BoxFit? fit = BoxFit.fitHeight,

    /// The background color of the card. Defaults to white.
    final Color backgroundColor = Colors.white,

    /// The transform type of the card. Defaults to [TransformType.identity].
    final TransformType3d transformType3d = TransformType3d.identity,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget Function(int index)? childrenStackBuilder =
        defaultChildrenStackBuilder,
  }) {
    return Transformed3DCardlider(
      imageUrl: imageUrl,
      directionality: directionality,
      initialPage: initialPage,
      viewportFraction: viewportFraction,
      height: height,
      width: width,
      heightCard: heightCard,
      widthCard: widthCard,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      onLongPress: onLongPress,
      cardBackgroundColor: cardBackgroundColor,
      errorBuilder: errorBuilder,
      frameBuilder: frameBuilder,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      showBackgroundImage: showBackgroundImage,
      backgroundColor: backgroundColor,
      sigmaXBlurBackgroundImage: sigmaXBlurBackgroundImage,
      fit: fit,
      transformType3d: transformType3d,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  ///Example:
  ///
  /// ```dart
  /// CarouselCustomSlider.Reflection(
  ///   sliderList: [
  ///     'image1.jpg',
  ///     'image2.jpg',
  ///     'image3.jpg',
  ///   ],
  ///   showReflection: true,
  ///   height: 200,
  ///   fit: BoxFit.fill,
  ///   childrenStackBuilder : [],
  /// ```

  static Widget reflection({
    /// [sliderList]: The list of images to display.
    required final List sliderList,

    /// [width]: The width of the image.
    required final double width,

    /// [height]: The height of the image.
    required final double height,

    /// [autoPlay]: Whether to automatically play the carousel.
    final bool autoPlay = true,

    /// [autoPlayInterval]: The interval between auto play animations.
    final Duration autoPlayInterval = const Duration(seconds: 5),

    /// [autoPlayAnimationDuration]: The duration of auto play animations.
    final Duration autoPlayAnimationDuration = const Duration(seconds: 2),

    /// [autoPlayCurve]: The curve of auto play animations.
    final Curve autoPlayCurve = Curves.ease,

    /// [shadowColorStart]: The color of the shadow.
    final Color shadowColorStart = const Color.fromRGBO(0, 0, 0, 0.4),

    /// [shadowColorEnd]: The color of the shadow.
    final Color shadowColorEnd = const Color.fromRGBO(0, 0, 0, 0.9),

    /// [reflectionOpacity]: The opacity of the reflection. Defaults to 0.4. between 0.0 and 1.0
    final double reflectionOpacity = 0.4,

    /// [reflectionBlendMode]: The blend mode of the reflection . Defaults BlendMode.xor.
    final BlendMode reflectionBlendMode = BlendMode.dst,

    /// [cacheHeight]: The height of the cache.
    final int cacheHeight = 200,

    /// [cacheWidth]: The width of the cache.
    final int cacheWidth = 200,

    /// [fit]: The fit of the image.
    final BoxFit? fit = BoxFit.fill,

    /// [onTap]: The callback when the image is tapped.
    final void Function()? onTap,

    /// [errorBuilder]: The error builde ImageBuilder.
    final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,

    /// [borderColor]: The color of the border.
    final Color? borderColor,

    /// [showReflection]: Whether to show the reflection.
    final bool showReflection = true,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget? Function(int index)? childrenStackBuilder =
        AdvancedCarouselSlider.defaultChildrenStackBuilder,
  }) {
    return Reflection(
      sliderList: sliderList,
      width: width,
      height: height,
      reflectionOpacity: reflectionOpacity,
      reflectionBlendMode: reflectionBlendMode,
      shadowColorStart: shadowColorStart,
      shadowColorEnd: shadowColorEnd,
      autoPlay: autoPlay,
      autoPlayInterval: autoPlayInterval,
      autoPlayAnimationDuration: autoPlayAnimationDuration,
      autoPlayCurve: autoPlayCurve,
      cacheHeight: cacheHeight,
      cacheWidth: cacheHeight,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  /// Example usage:
  /// ```dart
  /// AdvancedCarouselSlider(
  ///   slides: [
  ///     'https://example.com/image1.jpg',
  ///     'https://example.com/image2.jpg',
  ///     // ...
  ///   ],
  ///   height: 200,
  ///   width: 300,
  ///   initialPage: 0,
  ///   viewportFraction: 0.9,
  ///   backgroundColor: Colors.white,
  ///   fit: BoxFit.cover,
  ///   effect: WormEffect(),
  ///   childrenStackBuilder: (index) {
  ///     return Text(
  ///       'Slide ${index + 1}',
  ///       style: TextStyle(color: Colors.white, fontSize: 24),
  ///     );
  ///   },
  /// ),
  /// ```
  /// [colorFilter] is the color filter of the carousel. Defaults to=>
  /// ```dart
  /// ColorFilter.mode(
  ///    Colors.black
  ///   .withOpacity(isCurrentPage ? 0.3 : 0.9),
  ///  BlendMode.xor,
  /// ),
  /// ```
  static Widget advancedCarouselSlider({
    /// [slides] is a list of images or other content that will be displayed in the carousel.
    required final List<String> slides,

    /// [height] The height of the carousel. Defaults to 100. between 0.0 and 100.0 percent
    final double height = 100,

    /// [width] The width of the carousel. Defaults to 100. between 0.0 and 100.0 percent.
    final double width = 100,

    /// [viewportFraction] is the fraction of the viewport that each card occupies.
    final double viewportFraction = 1.0,

    /// [directionality] is the text direction of the carousel.
    final TextDirection directionality = TextDirection.ltr,

    /// [initialPage] is the initial page to display. Defaults to 1.
    final int initialPage = 1,

    /// [backgroundColor] is the background color of the carousel.
    final Color backgroundColor = Colors.black,

    /// [fit] is the fit of the carousel.
    final BoxFit fit = BoxFit.cover,

    /// [colorFilter] is the color filter of the carousel. Defaults to=>
    /// ```dart
    /// ColorFilter.mode(
    ///    Colors.black
    ///   .withOpacity(isCurrentPage ? 0.3 : 0.9),
    ///  BlendMode.xor,
    /// ),
    /// ```
    final ColorFilter? colorFilter,

    /// The direction in which the carousel scrolls.
    final Axis scrollDirection = Axis.horizontal,

    /// The alignment position of the indicator.
    final AlignmentGeometry alignmentPositionIndicator = Alignment.bottomCenter,

    /// Whether to display the indicator.
    final bool isDisplayIndicator = true,

    /// The effect to apply to the carousel items.
    ///
    /// You can use various effects like:
    /// ```dart
    /// effect : WormEffect(),
    /// effect : JumpingDotEffect(),
    /// effect : ScaleEffect(),
    /// effect : ScrollingDotsEffect(),
    /// effect : SlideEffect(),
    /// effect : ExpandingDotsEffect(),
    /// effect : SwapEffect(
    ///   dotHeight: 12.0,
    ///   dotWidth: 12.0,
    ///   paintStyle: PaintingStyle.fill,
    ///   type: SwapType.yRotation,
    ///   activeDotColor: Theme.of(context).primaryColor,
    ///   dotColor: Theme.of(context).colorScheme.inversePrimary,
    /// ),
    /// ```
    final IndicatorEffect effect = const SlideEffect(dotHeight: 8, dotWidth: 8),

    /// The axis direction of the indicator.
    final Axis axisDirectionIndicator = Axis.horizontal,

    /// The text direction of the indicator.
    final TextDirection? textDirectionIndicator,

    /// Callback function called when a dot indicator is clicked.
    final void Function(int)? onDotClicked,

    /// The height of the cache image.
    final int? cacheHeigh = 300,

    /// The width of the cache image.
    final int? cacheWidth = 300,

    /// A builder function that returns a widget to display on top of each slide.
    ///
    /// The function receives the index of the current slide and returns a widget.
    final Widget? Function(int index) childrenStackBuilder =
        AdvancedCarouselSlider.defaultChildrenStackBuilder,
  }) {
    return AdvancedCarouselSlider(
      slides: slides,
      height: height,
      width: width,
      viewportFraction: viewportFraction,
      scrollDirection: scrollDirection,
      alignmentPositionIndicator: alignmentPositionIndicator,
      axisDirectionIndicator: scrollDirection,
      backgroundColor: backgroundColor,
      directionality: directionality,
      fit: fit,
      onDotClicked: onDotClicked,
      textDirectionIndicator: textDirectionIndicator,
      colorFilter: colorFilter,
      initialPage: initialPage,
      effect: effect,
      isDisplayIndicator: isDisplayIndicator,
      cacheHeigh: cacheHeigh,
      cacheWidth: cacheWidth,
      childrenStackBuilder: childrenStackBuilder,
    );
  }

  static Widget defaultChildrenStackBuilder(int index) =>
      const SizedBox.shrink();

  static List<Widget> defaultChildrenStackBuilders(int index) => [];

  /// A circular wheel gallery with scroll-driven animation.
  ///
  /// Cards are arranged around a circle. Scrolling the page rotates the wheel
  /// one card at a time. The top card is in full focus (sharp, colored) while
  /// others fade to grayscale and blur based on their distance from focus.
  ///
  /// Supports light/dark theme automatically.
  ///
  /// Example:
  /// ```dart
  /// CarouselCustomSlider.wheelGallery(
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
  ///   cardAspectRatio: 4 / 6,
  ///   onFocusChanged: (i) => print('focused: $i'),
  /// )
  /// ```
  static Widget wheelGallery({
    /// The list of items (image URL + title) to display.
    required final List<WheelGalleryItem> items,

    /// Card aspect ratio (width/height). Defaults to 4/6.
    final double cardAspectRatio = 4 / 6,

    /// Border radius of cards. Defaults to 14.
    final double cardBorderRadius = 14,

    /// Background color. If null, adapts to theme (light/dark).
    final Color? backgroundColor,

    /// Maximum blur for distant cards. Defaults to 7.0.
    final double maxBlur = 7.0,

    /// Scroll height multiplier — controls how much scrolling is needed.
    /// Defaults to 12 (gives a `1200vh` feel).
    final double scrollHeightMultiplier = 12,

    /// Whether to show mouse/scroll hint. Defaults to true.
    final bool showScrollHint = true,

    /// Callback fired when the focused card index changes.
    final void Function(int index)? onFocusChanged,

    /// Title text style.
    final TextStyle? titleStyle,

    /// Optional loading placeholder builder.
    final Widget Function(BuildContext context, double width, double height)?
    loadingBuilder,

    /// Optional error widget builder.
    final Widget Function(
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
      double width,
      double height,
    )?
    errorBuilder,
  }) {
    return WheelGallery(
      items: items,
      cardAspectRatio: cardAspectRatio,
      cardBorderRadius: cardBorderRadius,
      backgroundColor: backgroundColor,
      maxBlur: maxBlur,
      scrollHeightMultiplier: scrollHeightMultiplier,
      showScrollHint: showScrollHint,
      onFocusChanged: onFocusChanged,
      titleStyle: titleStyle,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
    );
  }

  /// A coverflow-style carousel that renders cards with a 3D perspective
  /// rotation (Cover Flow effect). Cards fan out on either side of the active
  /// card with a Y-axis rotation and a scale-down, giving a realistic depth feel.
  ///
  /// Tapping a non-active card navigates to it; arrow buttons and dot indicators
  /// are shown at the bottom by default.
  ///
  /// Example:
  /// ```dart
  /// CarouselCustomSlider.coverflowCarousel(
  ///   items: [
  ///     CoverflowItem(
  ///       src: 'https://images.unsplash.com/photo-1234?w=500',
  ///       title: 'urban exploration',
  ///     ),
  ///     CoverflowItem(
  ///       src: 'https://images.unsplash.com/photo-5678?w=500',
  ///       title: 'night scene',
  ///     ),
  ///   ],
  ///   initialIndex: 0,
  ///   cardWidth: 200,
  ///   cardAspectRatio: 3 / 4,
  ///   rotationDegrees: 60,
  ///   inactiveScale: 0.85,
  ///   overlapFactor: 0.55,
  ///   animationDuration: Duration(milliseconds: 700),
  ///   animationCurve: Curves.easeOutBack,
  ///   onIndexChanged: (i) => print('active: $i'),
  /// )
  /// ```
  static Widget coverflowCarousel({
    /// The list of items (image URL + title) to display.
    required final List<CoverflowItem> items,

    /// Width of each card in logical pixels. Defaults to 200.
    final double cardWidth = 200,

    /// Aspect ratio (width / height) of each card. Defaults to 3/4.
    final double cardAspectRatio = 3 / 4,

    /// Y-axis rotation angle in degrees per offset step. Defaults to 55.
    final double rotationDegrees = 55,

    /// Scale factor for non-active cards. Defaults to 0.82.
    final double inactiveScale = 0.82,

    /// Horizontal overlap as fraction of [cardWidth]. Defaults to 0.52.
    final double overlapFactor = 0.52,

    /// Animation duration. Defaults to 450 ms.
    final Duration animationDuration = const Duration(milliseconds: 450),

    /// Animation curve. Defaults to [Curves.easeOutCubic].
    final Curve animationCurve = Curves.easeOutCubic,

    /// Title fade duration. Defaults to 350 ms.
    final Duration titleFadeDuration = const Duration(milliseconds: 350),

    /// Text style for the title label below the active card.
    final TextStyle? titleStyle,

    /// Whether to display the arrow + dot navigation controls. Defaults to true.
    final bool showControls = true,

    /// Background color of the controls bar.
    final Color controlsBackgroundColor = const Color(0x80E5E5E5),

    /// Border color of the controls bar.
    final Color controlsBorderColor = const Color(0xCCE5E5E5),

    /// Color of arrow icons and the active indicator dot.
    final Color controlsActiveColor = const Color(0xFF404040),

    /// Color of inactive indicator dots.
    final Color controlsInactiveColor = const Color(0x4D404040),

    /// Width of the dots row section inside the controls bar. Defaults to 180.
    final double dotsRowWidth = 180,

    /// Height of a single indicator dot. Defaults to 8.
    final double dotHeight = 8,

    /// Width of the active indicator dot. Defaults to 28.
    final double activeDotWidth = 28,

    /// Width of an inactive indicator dot. Defaults to 8.
    final double inactiveDotWidth = 8,

    /// Horizontal margin between dots. Defaults to 3.
    final double dotHorizontalMargin = 3,

    /// Callback triggered whenever the active index changes.
    final void Function(int index)? onIndexChanged,

    /// Optional builder for a custom loading placeholder while images load.
    final Widget Function(BuildContext context, double width, double height)?
    loadingBuilder,

    /// Optional builder for a custom error widget when image loading fails.
    final Widget Function(
      BuildContext context,
      Object error,
      StackTrace? stackTrace,
      double width,
      double height,
    )?
    errorBuilder,
  }) {
    return CoverflowCarousel(
      items: items,
      cardWidth: cardWidth,
      cardAspectRatio: cardAspectRatio,
      rotationDegrees: rotationDegrees,
      inactiveScale: inactiveScale,
      overlapFactor: overlapFactor,
      animationDuration: animationDuration,
      animationCurve: animationCurve,
      titleFadeDuration: titleFadeDuration,
      titleStyle: titleStyle,
      showControls: showControls,
      controlsBackgroundColor: controlsBackgroundColor,
      controlsBorderColor: controlsBorderColor,
      controlsActiveColor: controlsActiveColor,
      controlsInactiveColor: controlsInactiveColor,
      dotsRowWidth: dotsRowWidth,
      dotHeight: dotHeight,
      activeDotWidth: activeDotWidth,
      inactiveDotWidth: inactiveDotWidth,
      dotHorizontalMargin: dotHorizontalMargin,
      onIndexChanged: onIndexChanged,
      loadingBuilder: loadingBuilder,
      errorBuilder: errorBuilder,
    );
  }

  /// A 3D rotating ring carousel.
  ///
  /// Use [carousel3DType] to select the style:
  /// - [Carousel3DType.standard] — Large cards in a fixed container, no shader mask.
  /// - [Carousel3DType.alt]      — Compact cards with a closer camera, no shader mask.
  /// - [Carousel3DType.shader]   — Large cards with a lateral [ShaderMask] fade at the edges.
  ///
  /// Each type has a matching [CarouselConfig] preset (`CarouselConfig.standard`,
  /// `CarouselConfig.alt`, `CarouselConfig.shader`) but you can pass any custom config.
  ///
  /// Example:
  /// ```dart
  /// // Standard — fixed container, no shader
  /// CarouselCustomSlider.carousel3D(
  ///   carousel3DType: Carousel3DType.standard,
  ///   images: myUrls,
  ///   containerWidth: 500,
  ///   containerHeight: 350,
  ///   config: CarouselConfig(cardCount: 8),
  /// )
  ///
  /// // Shader fade at edges
  /// CarouselCustomSlider.carousel3D(
  ///   carousel3DType: Carousel3DType.shader,
  ///   images: myUrls,
  /// )
  ///
  /// // Compact ring
  /// CarouselCustomSlider.carousel3D(
  ///   carousel3DType: Carousel3DType.alt,
  ///   config: CarouselConfig(cardWidth: 200, perspective: 400),
  /// )
  /// ```
  static Widget carousel3D({
    /// The visual style of the carousel.
    /// Defaults to [Carousel3DType.standard].
    final Carousel3DType carousel3DType = Carousel3DType.standard,

    /// List of full image URLs to display.
    /// Defaults to built-in Unsplash demo images when `null`.
    final List<String>? images,

    /// Carousel geometry and animation settings.
    /// When `null`, the matching preset for [carousel3DType] is used automatically.
    final CarouselConfig? config,

    /// Width of the outer container (ignored for [Carousel3DType.shader]).
    final double containerWidth = 600,

    /// Height of the outer container (ignored for [Carousel3DType.shader]).
    final double containerHeight = 400,
  }) {
    switch (carousel3DType) {
      case Carousel3DType.shader:
        return Carousel3DShader(
          images: images,
          config: config ?? CarouselConfig.shader,
        );
      case Carousel3DType.alt:
        return Carousel3DAlt(
          images: images,
          config: config ?? CarouselConfig.alt,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
        );
      case Carousel3DType.standard:
        return Carousel3D(
          images: images,
          config: config ?? CarouselConfig.standard,
          containerWidth: containerWidth,
          containerHeight: containerHeight,
        );
    }
  }

  @override
  State<CarouselCustomSlider> createState() => _CarouselCustomSliderState();
}

class _CarouselCustomSliderState extends State<CarouselCustomSlider>
    with SingleTickerProviderStateMixin {
  // ─────────────────────────────────────────────────────────────────────────────
  // Constants
  // ─────────────────────────────────────────────────────────────────────────────
  static const double _defaultDimension = 200.0;
  static const double _scaleReductionFactor = 0.3;
  static const double _minScale = 0.8;
  static const double _maxScaleBoost = 0.4;
  static const double _elevationFactor = 25.0;
  static const double _zoomTranslateFactor = 50.0;
  static const double _minOpacity = 0.5;
  static const int _defaultBorderRadius = 12;

  // ─────────────────────────────────────────────────────────────────────────────
  // State Variables
  // ─────────────────────────────────────────────────────────────────────────────
  late final List<Widget> _pageList;
  late final PageController _pageController;
  Timer? _autoPlayTimer;
  bool _isReversingDirection = false;
  int _currentPageIndex = 0;
  bool _isUserInteracting = false;

  // ─────────────────────────────────────────────────────────────────────────────
  // Getters for cleaner code
  // ─────────────────────────────────────────────────────────────────────────────
  int get _itemCount => widget.sliderList.length;
  bool get _hasItems => _itemCount > 0;
  bool get _isAutoPlayEnabled => widget.autoPlay && _hasItems;
  AnimatedBuilderType? get _animationType =>
      widget.animatedBuilderSettings?.animatedBuilderType;
  bool get _useAnimatedBuilder =>
      widget.animatedBuilderSettings?.useAnimatedBuilder ?? false;

  double get _safeHeight => widget.height.isNaN || widget.height <= 0
      ? _defaultDimension
      : widget.height;
  double get _safeWidth => widget.width.isNaN || widget.width <= 0
      ? _defaultDimension
      : widget.width;

  // ─────────────────────────────────────────────────────────────────────────────
  // Lifecycle Methods
  // ─────────────────────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _initializePageController();
    _initializePageList();
    _startAutoPlay();
  }

  @override
  void didUpdateWidget(covariant CarouselCustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle slider list changes
    if (oldWidget.sliderList.length != widget.sliderList.length) {
      _rebuildPageList();
    }

    // Handle autoplay changes
    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoplayDuration != widget.autoplayDuration) {
      _restartAutoPlay();
    }
  }

  @override
  void dispose() {
    _stopAutoPlay();
    _pageController.dispose();
    super.dispose();
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Initialization Methods
  // ─────────────────────────────────────────────────────────────────────────────
  void _initializePageController() {
    _pageController = PageController(
      initialPage: widget.initialPage.clamp(
        0,
        _itemCount > 0 ? _itemCount - 1 : 0,
      ),
      viewportFraction: widget.viewportFraction.clamp(0.1, 1.0),
    );
  }

  void _initializePageList() {
    _pageList = List.generate(
      _itemCount,
      (index) => PageViewWidget(widget: widget, index: index),
    );
  }

  void _rebuildPageList() {
    setState(() {
      _pageList.clear();
      _pageList.addAll(
        List.generate(
          _itemCount,
          (index) => PageViewWidget(widget: widget, index: index),
        ),
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Auto Play Management
  // ─────────────────────────────────────────────────────────────────────────────
  void _startAutoPlay() {
    if (!_isAutoPlayEnabled) return;

    final isBuildCustom = _animationType == AnimatedBuilderType.buildCustom;
    isBuildCustom ? _startBounceAutoPlay() : _startLoopAutoPlay();
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void _restartAutoPlay() {
    _stopAutoPlay();
    _startAutoPlay();
  }

  /// Bounce auto-play: goes forward then backward (ping-pong effect)
  void _startBounceAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoplayDuration, (_) {
      if (!_pageController.hasClients || _isUserInteracting) return;

      final currentPage = _pageController.page?.round() ?? 0;
      int nextPage = _isReversingDirection ? currentPage - 1 : currentPage + 1;

      // Boundary check with direction reversal
      if (nextPage >= _itemCount) {
        _isReversingDirection = true;
        nextPage = _itemCount - 2;
      } else if (nextPage < 0) {
        _isReversingDirection = false;
        nextPage = 1;
      }

      // Ensure valid page index
      nextPage = nextPage.clamp(0, _itemCount - 1);

      _animateToPage(nextPage);
    });
  }

  /// Loop auto-play: goes forward and loops back to start
  void _startLoopAutoPlay() {
    _autoPlayTimer = Timer.periodic(widget.autoplayDuration, (_) {
      if (!_pageController.hasClients || _isUserInteracting) return;

      final currentPage = _pageController.page?.round() ?? 0;
      final isLastPage = currentPage >= _itemCount - 1;

      if (isLastPage) {
        _animateToPage(0);
      } else {
        _pageController.nextPage(
          duration: widget.autoPlayAnimationDuration,
          curve: widget.autoPlayCurve,
        );
      }
    });
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: widget.autoPlayAnimationDuration,
      curve: widget.autoPlayCurve,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // User Interaction Handlers
  // ─────────────────────────────────────────────────────────────────────────────
  void _onUserInteractionStart() {
    _isUserInteracting = true;
    _stopAutoPlay();
  }

  void _onUserInteractionEnd() {
    _isUserInteracting = false;
    _startAutoPlay();
  }

  void _onPageChanged(int index) {
    if (_currentPageIndex != index) {
      setState(() => _currentPageIndex = index);
    }
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Animation Value Calculation
  // ─────────────────────────────────────────────────────────────────────────────
  double _calculateAnimationValue(
    int index, {
    double reductionFactor = _scaleReductionFactor,
  }) {
    if (!_pageController.position.haveDimensions) return 1.0;

    final currentPage = _pageController.page ?? _currentPageIndex.toDouble();
    final difference = (currentPage - index).abs();
    return (1 - (difference * reductionFactor)).clamp(0.0, 1.0);
  }

  double _calculateNormalizedValue(int index) {
    if (!_pageController.position.haveDimensions) return 0.0;

    final currentPage = _pageController.page ?? _currentPageIndex.toDouble();
    final difference = (currentPage - index).abs().clamp(0.0, 1.0);
    return (1 - difference).clamp(0.0, 1.0);
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Build Methods
  // ─────────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: widget.backgroundColor,
      child: Stack(
        children: [
          _buildPageView(),
          if (widget.isDisplayIndicator) _buildIndicator(),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          _onUserInteractionStart();
        } else if (notification is ScrollEndNotification) {
          _onUserInteractionEnd();
        }
        return false;
      },
      child: PageView.builder(
        controller: _pageController,
        itemCount: _itemCount,
        pageSnapping: widget.pageSnapping,
        allowImplicitScrolling: widget.allowImplicitScrolling,
        clipBehavior: widget.clipBehavior,
        dragStartBehavior: widget.dragStartBehavior,
        findChildIndexCallback: widget.findChildIndexCallback,
        padEnds: widget.padEnds,
        physics: widget.physics,
        restorationId: widget.restorationId,
        scrollBehavior: widget.scrollBehavior,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        onPageChanged: _onPageChanged,
        itemBuilder: _buildPageItem,
      ),
    );
  }

  Widget _buildPageItem(BuildContext context, int index) {
    if (!_useAnimatedBuilder) {
      return _buildDefaultPageItem(index);
    }

    return switch (_animationType) {
      AnimatedBuilderType.buildCustom => _buildCustomAnimation(index),
      AnimatedBuilderType.normalScale => _buildNormalScaleAnimation(index),
      AnimatedBuilderType.scale => _buildScaleAnimation(index),
      AnimatedBuilderType.zoomScale => _buildZoomScaleAnimation(index),
      _ => _buildDefaultPageItem(index),
    };
  }

  Widget _buildIndicator() {
    final indicator = SmoothPageIndicator(
      controller: _pageController,
      count: _itemCount,
      effect: widget.effect,
      axisDirection: widget.axisDirectionIndicator,
      textDirection: widget.textDirectionIndicator,
      onDotClicked: widget.onDotClicked,
    );

    if (widget.isVerticalIndicator) {
      return Padding(
        padding: widget.paddingVerticalPositionIndicator,
        child: Align(
          alignment: widget.alignmentVerticalPositionIndicator,
          child: RotatedBox(quarterTurns: 3, child: indicator),
        ),
      );
    }

    return Align(
      alignment: widget.alignmentPositionIndicator,
      child: Padding(padding: const EdgeInsets.all(15.0), child: indicator),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Page Item Builders
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildDefaultPageItem(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getSafePadding(widget.viewportFractionPaddingHorizontal),
        vertical: _getSafePadding(widget.viewportFractionPaddingVertical),
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: _pageList[index],
      ),
    );
  }

  Widget _buildNormalizedPageItem(int index) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: _getSafePadding(widget.viewportFractionPaddingHorizontal),
        vertical: _getSafePadding(widget.viewportFractionPaddingVertical),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_defaultBorderRadius.toDouble()),
        child: _pageList[index],
      ),
    );
  }

  double _getSafePadding(double value) => value.isNaN ? 0 : value;

  // ─────────────────────────────────────────────────────────────────────────────
  // Animation Builders
  // ─────────────────────────────────────────────────────────────────────────────
  Widget _buildCustomAnimation(int index) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          final value = _calculateAnimationValue(index);
          final transformedValue = Curves.easeInOut.transform(value);

          final height = transformedValue.isNaN
              ? _safeHeight
              : transformedValue * _safeHeight;
          final width = transformedValue.isNaN
              ? _safeWidth
              : transformedValue * _safeWidth;

          return Center(
            child: SizedBox(height: height, width: width, child: child),
          );
        },
        child: _buildNormalizedPageItem(index),
      ),
    );
  }

  Widget _buildScaleAnimation(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final value = _calculateAnimationValue(index);
        final curve =
            widget.animatedBuilderSettings?.curveForscale ?? Curves.linear;
        final scale = curve.transform(value);
        final elevation = (1 - value) * _elevationFactor;

        return Transform.scale(
          scale: scale,
          child: Transform.translate(
            offset: Offset(0, elevation),
            child: _buildDefaultPageItem(index),
          ),
        );
      },
    );
  }

  Widget _buildZoomScaleAnimation(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final value = _calculateNormalizedValue(index);
        final (scale, translate) = _calculateZoomScaleValues(value);

        return Transform.scale(
          scale: scale,
          child: Transform.translate(
            offset: Offset(0, -translate),
            child: Opacity(
              opacity: _minOpacity + value * _minOpacity,
              child: _buildDefaultPageItem(index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNormalScaleAnimation(int index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final value = _calculateNormalizedValue(index);
        final scale = _calculateNormalScale(value);

        return Transform.scale(
          scale: scale,
          child: _buildDefaultPageItem(index),
        );
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────────
  // Scale Calculation Helpers
  // ─────────────────────────────────────────────────────────────────────────────
  (double scale, double translate) _calculateZoomScaleValues(double value) {
    if (value > 0.5) {
      return (
        1 + (value - 0.5) * _maxScaleBoost,
        (value - 0.5) * _zoomTranslateFactor,
      );
    } else if (value > 0) {
      return (_minScale + value * _maxScaleBoost, 0.0);
    }
    return (_minScale, 0.0);
  }

  double _calculateNormalScale(double value) {
    if (value > 0.5) {
      return 1 + (value - 0.5) * _maxScaleBoost;
    } else if (value > 0) {
      return _minScale + value * _maxScaleBoost;
    }
    return _minScale;
  }
}

/**
              if (widget.useAnimatedBuilder) {
                return AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    double value = 0;
                    if (_pageController.position.haveDimensions) {
                      value = (_pageController.page! - index).abs();
                      value = (1 - (value.clamp(0.0, 1.0))).clamp(0.0, 1.0);
                    }
                    
                    double scale = widget.useGradualScaling
                        ? widget.minScale + (widget.maxScale - widget.minScale) * value
                        : (value == 1 ? widget.maxScale : 1.0);
                    
                    double elevation = value * widget.maxElevation;

                    return Transform.scale(
                      scale: scale,
                      child: Transform.translate(
                        offset: Offset(0, -elevation),
                        child: Opacity(
                          opacity: 0.5 + value * 0.5,
                          child: _buildPageItem(index),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return _buildPageItem(index);
              } */
