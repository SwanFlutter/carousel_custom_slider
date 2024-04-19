import 'package:flutter_test/flutter_test.dart';

import 'package:carousel_custom_slider/carousel_custom_slider.dart';

void main() {
  test('adds one to input values', () {
    final carousel = CarouselCustomSlider(sliderList: [],);
    expect(carousel.autoPlay, true);
    expect(carousel.doubleTapZoom, true);
    expect(carousel.initialPage, 1);
  });
}
