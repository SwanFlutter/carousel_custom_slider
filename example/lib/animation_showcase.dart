import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

/// نمونه مثال برای نمایش انواع انیمیشن‌های کاروسل
class AnimationShowcase extends StatelessWidget {
  const AnimationShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection('Zoom Scale Animation', _buildZoomScaleCarousel()),
          _buildSection('Normal Scale Animation', _buildNormalScaleCarousel()),
          _buildSection('Scale Animation', _buildScaleCarousel()),
          _buildSection('Custom Build Animation', _buildCustomCarousel()),
          _buildSection('Parallax Effect', _buildParallaxCarousel()),
          _buildSection('Advanced Carousel', _buildAdvancedCarousel(context)),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        child,
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }

  /// Zoom Scale - آیتم فعال بزرگتر با افکت opacity
  Widget _buildZoomScaleCarousel() {
    return CarouselCustomSlider(
      sliderList: sliderListImage.take(6).toList(),
      height: 220,
      viewportFraction: 0.6,
      autoPlay: true,
      autoplayDuration: const Duration(seconds: 4),
      autoPlayCurve: Curves.easeInOut,
      borderRadius: BorderRadius.circular(16),
      animatedBuilderSettings: AnimatedBuilderSettings(
        animatedBuilderType: AnimatedBuilderType.zoomScale,
        useAnimatedBuilder: true,
      ),
      effect: const ExpandingDotsEffect(
        dotHeight: 8,
        dotWidth: 8,
        activeDotColor: Colors.deepPurple,
        dotColor: Colors.grey,
      ),
    );
  }

  /// Normal Scale - مقیاس ساده بدون elevation
  Widget _buildNormalScaleCarousel() {
    return CarouselCustomSlider(
      sliderList: listImage,
      height: 200,
      viewportFraction: 0.7,
      autoPlay: true,
      backgroundColor: Colors.black12,
      borderRadius: BorderRadius.circular(12),
      animatedBuilderSettings: AnimatedBuilderSettings(
        animatedBuilderType: AnimatedBuilderType.normalScale,
        useAnimatedBuilder: true,
      ),
      effect: const WormEffect(
        dotHeight: 10,
        dotWidth: 10,
        type: WormType.thin,
        activeDotColor: Colors.teal,
      ),
    );
  }

  /// Scale Animation - مقیاس با elevation
  Widget _buildScaleCarousel() {
    return CarouselCustomSlider(
      sliderList: sliderListImage.take(5).toList(),
      height: 180,
      viewportFraction: 0.5,
      autoPlay: true,
      borderRadius: BorderRadius.circular(20),
      animatedBuilderSettings: AnimatedBuilderSettings(
        animatedBuilderType: AnimatedBuilderType.scale,
        useAnimatedBuilder: true,
        curveForscale: Curves.easeOutBack,
      ),
      effect: const JumpingDotEffect(
        dotHeight: 10,
        dotWidth: 10,
        jumpScale: 1.5,
        activeDotColor: Colors.orange,
      ),
    );
  }

  /// Custom Build - انیمیشن سفارشی با تغییر سایز
  Widget _buildCustomCarousel() {
    return CarouselCustomSlider(
      sliderList: listImage,
      height: 250,
      viewportFraction: 0.4,
      autoPlay: true,
      autoplayDuration: const Duration(seconds: 3),
      backgroundColor: Colors.grey.shade200,
      animatedBuilderSettings: AnimatedBuilderSettings(
        animatedBuilderType: AnimatedBuilderType.buildCustom,
        useAnimatedBuilder: true,
      ),
      effect: const SwapEffect(
        dotHeight: 12,
        dotWidth: 12,
        type: SwapType.yRotation,
        activeDotColor: Colors.indigo,
      ),
    );
  }

  /// Parallax Effect
  Widget _buildParallaxCarousel() {
    return SizedBox(
      height: 280,
      child: CarouselCustomSlider.parallax(
        imageUrl: sliderListImage.take(5).toList(),
        viewportFraction: 0.75,
        elevation: 8,
        shadowColor: Colors.black45,
        borderRadius: BorderRadius.circular(16),
        valueScalingFactor: 0.4,
        dynamicHeight: 220,
        customCurve: Curves.easeInOutCubic,
      ),
    );
  }

  /// Advanced Carousel با ColorFilter
  Widget _buildAdvancedCarousel(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: CarouselCustomSlider.advancedCarouselSlider(
        slides: sliderListImage.take(6).toList(),
        height: 100,
        width: 100,
        viewportFraction: 0.85,
        backgroundColor: Colors.black87,
        effect: const ScrollingDotsEffect(
          dotHeight: 8,
          dotWidth: 8,
          activeDotColor: Colors.white,
          dotColor: Colors.white38,
        ),
      ),
    );
  }
}
