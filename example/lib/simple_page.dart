import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

import 'constant.dart';

class SimplePage extends StatelessWidget {
  const SimplePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SimplePage')),
      body: Center(
        child: CarouselCustomSlider(
          sliderList: sliderListImage,
          effect: const WormEffect(),
          viewportFraction: 0.7,
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
