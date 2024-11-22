import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewWidget'),
      ),
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
            const SizedBox(
              height: 20,
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
