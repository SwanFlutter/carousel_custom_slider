import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class Carousel3DExample extends StatefulWidget {
  const Carousel3DExample({super.key});

  @override
  State<Carousel3DExample> createState() => _Carousel3DExampleState();
}

class _Carousel3DExampleState extends State<Carousel3DExample> {
  int _selectedIndex = 0;

  static const _titles = ['Carousel3DShader', 'Carousel3D', 'Carousel3DAlt'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3ED),
      appBar: AppBar(title: Text(_titles[_selectedIndex]), centerTitle: true),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          // 1. Shader fade variant
          Center(
            child: CarouselCustomSlider.carousel3D(
              carousel3DType: Carousel3DType.shader,
            ),
          ),

          // 2. Standard no-shader variant
          Center(
            child: CarouselCustomSlider.carousel3D(
              carousel3DType: Carousel3DType.standard,
              containerWidth: 600,
              containerHeight: 400,
            ),
          ),

          // 3. Compact alternate variant
          Center(
            child: CarouselCustomSlider.carousel3D(
              carousel3DType: Carousel3DType.alt,
              containerWidth: 600,
              containerHeight: 400,
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.blur_on), label: 'Shader'),
          NavigationDestination(
            icon: Icon(Icons.view_carousel),
            label: 'Standard',
          ),
          NavigationDestination(icon: Icon(Icons.auto_awesome), label: 'Alt'),
        ],
      ),
    );
  }
}
