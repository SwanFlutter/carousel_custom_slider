import 'dart:ui';


import 'package:carousel_custom_slider/carousel_custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:zoom_hover_pinch_image/zoom_hover_pinch_image.dart';

class PageViewWidget extends StatelessWidget {
  const PageViewWidget({
    super.key,
    required this.widget,
    required this.index,
    required this.controller,
  });

  /// The Carousel widget to display on the page.
  final CarouselCustomSlider widget;

  /// The PageController managing this page.
  final PageController controller;

  /// The index of the page.
  final int index;

  @override
  Widget build(BuildContext context) {
    double blurValue = 0.0;
    return Stack(
      children: [
        Zoom.zoomOnTap(
          width: double.infinity,
          height: double.infinity,
          doubleTapZoom: widget.doubleTapZoom,
          oneTapZoom: true, // Change oneTapZoom to true
          clipBehavior: widget.clipBehaviorZoom,
          child: Image.network(
            widget.sliderList[index],
            width: double.infinity,
            height: double.infinity,
            fit: widget.fitPic,
            errorBuilder: (context, url, error) => Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
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
                  width: double.infinity,
                  height: double.infinity,
                  fit: widget.fitPic,
                ),
              );
            },
          ),
        ),
        if (widget.sliderTitlePost != null)
          widget.sliderTitlePost != null
              ? Align(
                  alignment: widget.alignmentPositionTitleText,
                  child: Padding(
                    padding: widget.paddingTitleText,
                    child: Text(
                      widget.sliderTitlePost![index],
                      style: widget.titleStyle,
                    ),
                  ),
                )
              : const SizedBox(),
        if (widget.sliderBodyPost != null)
          Align(
            alignment: widget.alignmentPositionBodyText,
            child: Padding(
              padding: widget.paddingBodyText,
              child: Text(
                widget.sliderBodyPost![index],
                style: widget.bodyStyle,
              ),
            ),
          ),
      ],
    );
  }
}
