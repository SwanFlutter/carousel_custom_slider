import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

const List<CoverflowItem> _coverflowAssets = [
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=1',
    title: 'urban exploration',
  ),
  CoverflowItem(src: 'https://i.pravatar.cc/300?img=2', title: 'night scene'),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=3',
    title: 'yellow wildflowers',
  ),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=4',
    title: 'street with mount fuji',
  ),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=5',
    title: 'bridgestone bicycle shop',
  ),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=6',
    title: 'train window view',
  ),
  CoverflowItem(src: 'https://i.pravatar.cc/300?img=7', title: 'train tracks'),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=8',
    title: 'lawson convenience store',
  ),
  CoverflowItem(src: 'https://i.pravatar.cc/300?img=9', title: 'street scene'),
  CoverflowItem(
    src: 'https://i.pravatar.cc/300?img=10',
    title: 'japanese culture',
  ),
];

class CoverflowExample extends StatelessWidget {
  const CoverflowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: AppBar(title: const Text('Coverflow Carousel')),
      body: CarouselCustomSlider.coverflowCarousel(
        items: _coverflowAssets,
        cardWidth: 200,
        cardAspectRatio: 3 / 4,
        rotationDegrees: 55,
        inactiveScale: 0.82,
        overlapFactor: 0.52,
        animationDuration: const Duration(milliseconds: 450),
        animationCurve: Curves.easeOutCubic,
        onIndexChanged: (i) => debugPrint('active: $i'),
      ),
    );
  }
}
