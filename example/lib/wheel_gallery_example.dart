import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class WheelGalleryExample extends StatelessWidget {
  const WheelGalleryExample({super.key});

  static const _items = [
    WheelGalleryItem(
      src: 'https://picsum.photos/id/634/1200/1200',
      title: 'A misty Morning',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/228/1200/1200',
      title: 'Harvest',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/661/1200/1200',
      title: 'Waiting',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/380/1200/1200',
      title: 'Time for Everything',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/392/1200/1200',
      title: 'Cross over',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/238/1200/1200',
      title: 'In The City',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/469/1200/1200',
      title: 'A Boat Trip',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/311/1200/1200',
      title: 'Waiting',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/515/1200/1200',
      title: 'Stories to tell',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/521/1200/1200',
      title: 'A Perfect Day',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/549/1200/1200',
      title: 'Riding the Curve',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/178/1200/1200',
      title: 'Raindrops',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/637/1200/1200',
      title: 'Gone Sailing',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/641/1200/1200',
      title: 'The Watch Tower',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/669/1200/1200',
      title: 'Leaving',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/685/1200/1200',
      title: 'Above the Clouds',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/505/1200/1200',
      title: 'This is the title',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/699/1200/1200',
      title: 'This is the title',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/513/1200/1200',
      title: 'This is the title',
    ),
    WheelGalleryItem(
      src: 'https://picsum.photos/id/773/1200/1200',
      title: 'Contemplation!',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselCustomSlider.wheelGallery(
        items: _items,
        cardAspectRatio: 4 / 6,
        maxBlur: 7.0,
        showScrollHint: true,
        onFocusChanged: (i) {},
      ),
    );
  }
}
