// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:carousel_custom_slider/transform_type.dart';
import 'package:flutter/material.dart';

/// Class to hold settings for the [AnimatedBuilder] widget.
///
/// This class is used to store settings for the [AnimatedBuilder] widget used in
/// the [CarouselCustomSlider].
///
/// The settings include the type of animation, whether to use the
/// [AnimatedBuilder] widget, whether to use gradual scaling, and the maximum
/// and minimum scale values.
///
/// The [AnimatedBuilder] widget is used to animate the cards in the slider.
/// The type of animation can be set to either [AnimatedBuilderType.normal] or
/// [AnimatedBuilderType.scale].
///
/// The [useAnimatedBuilder] property determines whether to use the
/// [AnimatedBuilder] widget or not. If set to `true`, the card will be
/// animated, otherwise it will not be animated.
///
/// The [useGradualScaling] property determines whether to use gradual scaling
/// or not. If set to `true`, the card will be scaled gradually, otherwise it
/// will be scaled immediately.
///
/// The [maxScale] property sets the maximum scale value for the card.
///
/// The [minScale] property sets the minimum scale value for the card.
///
/// The [maxElevation] property sets the maximum elevation value for the card.
class AnimatedBuilderSettings {
  /// The type of animation to use for the [AnimatedBuilder] widget.
  /// uses all type [AnimatedBuilderType].
  final AnimatedBuilderType? animatedBuilderType;

  /// Whether to use the [AnimatedBuilder] widget or not.
  /// /// uses for [AnimatedBuilderSettings].
  final bool useAnimatedBuilder;

  /// Whether to use gradual scaling or not.
  /// uses only type  [AnimatedBuilderType.zoomScale].
  final bool? useGradualScaling;

  /// The maximum scale value for the card.
  /// /// uses only type  [AnimatedBuilderType.zoomScale].
  final double? maxScale;

  /// The minimum scale value for the card.
  /// /// uses only type  [AnimatedBuilderType.zoomScale].
  final double? minScale;

  /// The maximum elevation value for the card.
  /// /// uses only type  [AnimatedBuilderType.zoomScale].
  final double? maxElevation;

  /// Constructor to create an instance of [AnimatedBuilderSettings].
  /// curve animated builder
  final Curve? curveForscale;

  AnimatedBuilderSettings({
    this.animatedBuilderType = AnimatedBuilderType.normalScale,
    this.useAnimatedBuilder = false,
    this.useGradualScaling = false,
    this.maxScale = 1.0,
    this.minScale = 1.0,
    this.maxElevation = 0.0,
    this.curveForscale = Curves.ease,
  });
}
