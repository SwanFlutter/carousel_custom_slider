import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

import 'carousel_3d_example.dart';
import 'coverflow_example.dart';
import 'wheel_gallery_example.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: const Text('NewWidget')),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselCustomSlider(
              animatedBuilderSettings: AnimatedBuilderSettings(
                animatedBuilderType: AnimatedBuilderType.zoomScale,
                useAnimatedBuilder: true,
              ),
              backgroundColor: Colors.blueAccent.shade100,
              doubleTapZoom: true,
              clipBehaviorZoom: true,
              autoPlay: true,
              height: 350,
              viewportFraction: 0.25,
              initialPage: 3,
              sliderList: img,
              viewportFractionPaddingHorizontal: 5,
              viewportFractionPaddingVertical: 5,
              autoPlayCurve: Curves.ease,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.view_carousel),
              label: const Text('Coverflow Carousel'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CoverflowExample()),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.album),
              label: const Text('Wheel Gallery'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WheelGalleryExample()),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.threed_rotation),
              label: const Text('Carousel 3D Ring'),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Carousel3DExample()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const List<String> img = [
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
  'https://picsum.photos/200/300',
];
