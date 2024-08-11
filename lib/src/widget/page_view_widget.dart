import 'dart:ui';

import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoom_hover_pinch_image/zoom_hover_pinch_image.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.widget,
    required this.index,
  });

  /// The Carousel widget to display on the page.
  final CarouselCustomSlider widget;

  /// The index of the page.
  final int index;

  @override
  Widget build(BuildContext context) {
    double blurValue = 0.0;
    return Stack(
      children: [
        Zoom.zoomOnTap(
          width: widget.width,
          height: widget.height,
          doubleTapZoom: widget.doubleTapZoom,
          oneTapZoom: true, // Change oneTapZoom to true
          clipBehavior: widget.clipBehaviorZoom,
          child: Image.network(
            widget.sliderList[index],
            width: widget.width,
            height: widget.height,
            fit: widget.fitPic,
            errorBuilder: (context, url, error) => Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
            ),
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress != null &&
                  loadingProgress.expectedTotalBytes != null) {
                double progress = (loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!) *
                    25; // Calculate percentage (0-100)
                // Calculate blur based on progress (higher progress = less blur)
                blurValue = 25 - progress;
              }
              return ImageFiltered(
                imageFilter:
                    ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
                child: Image.network(
                  widget.sliderList[index],
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: double.infinity,
                  fit: widget.fitPic,
                  errorBuilder: (context, error, stackTrace) => Center(
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        widget.childrenStackBuilder!(index),
      ],
    );
  }
}
