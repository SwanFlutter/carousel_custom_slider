
This is a simple slider package, you can put the position of the indicator and text on it and personalize it.

## Features


✔️ Ability to zoom with double tab.
✔️ The possibility of choosing several effects for the indicator.
✔️ Display text for title and body and specify its position.
✔️ Select the position of the slider indicator.
✔️ Download images in blur.





![20240418_081900](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/e8d7b540-7e35-45b7-880b-1116255b6347)![20240418_081732](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/46e38714-27f2-4813-b542-ce0a07062e79)

![20240419_094517](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/e3267854-06ff-4b93-b871-d572cda09a4c)

```dart
CarouselCustomSlider(
autoPlay: true,
isVerticalIndicator: false,
dragStartBehavior: DragStartBehavior.down,
scrollDirection: Axis.vertical,
alignmentPositionIndicator: Alignment.bottomCenter,
viewportFraction: 1,
viewportFractionPadingvertical: 0,
sliderList: sliderListImage,
sliderTitlePost: sliderTitlePost,
sliderBodyPost: sliderTitlePost,
effect: SwapEffect(
dotHeight: 12.0,
dotWidth: 12.0,
paintStyle: PaintingStyle.fill,
 type: SwapType.yRotation,
activeDotColor: Theme.of(context).primaryColor,
dotColor: Theme.of(context).colorScheme.inversePrimary,
 ),
  ),
```


![20240422_115507](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/a12ed375-8278-43b8-b33a-323be33e801f)

```dart
 CarouselCustomSlider.autoScrollingWheel(
        autoPlay: false,
        height: 150,
        backgroundImageUrls: listImage,
        children: children,
      ),

```

![20240512_074358](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/4fe2e438-893a-4fc8-86a0-c7986e4730f3)


```dart

CarouselCustomSlider.parallax(
          imageUrl: sliderListImage,
          // height: 400,
          showBackgroundImage: true,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white, width: 5.0),
          customCurve: Curves.easeInOutBack,
          shadowColor: Colors.pink,
          horizontalTransform: 250,

          ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
          valueScalingFactor: 0.4,
          viewportFraction: 0.8,
          dynamicHeight: 600,
          children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'Parallax',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
        ),

```
![TransformType skew](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/7a6a6edc-d2f6-43d6-915a-b5629d792a40)
```dart
 CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.skew,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.4, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.skew',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),
        
```

![TransformType skew1](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/58926dce-de9b-417f-8a4b-01a555cf567e)

```dart
CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.skew1,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.4, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.skew1',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),

```

![TransformType skew2](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/45c9ecc0-86a0-453b-9fa3-bd7b39cc69e9)

```dart

CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.skew2,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.skew2',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),

```

![TransformType rotation](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/25bc933c-3fcf-46f0-b657-b7773fb98178)


```dart

CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.rotation,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.rotation',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),

```

![TransformType tryInvert](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/0b3b2db6-4b17-4707-8de4-8ce08723ead9)

```dart

CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.tryInvert,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.tryInvert',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),

```

![TransformType diagonal3Values](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/0ce14c26-7635-499a-9d6a-eeaf09491480)

```dart

CarouselCustomSlider.transFormedCardSlider(
            transformType: TransformType.diagonal3Values,
            imageUrl: sliderListImage,
             ///You may sometimes get container box error, you need to change [viewportFraction] , [valueScalingFactor] , [horizontalTransform] , [dynamicHeight] value to match with one another,
          /// most of the time the problem is solved by changing these two [viewportFraction] , [valueScalingFactor] .
            valueScalingFactor: 0.3, //BorderSide.strokeAlignCenter
            viewportFraction: 0.7,
            customCurve: Curves.bounceInOut,
           children: [
            const Positioned(
              left: 25,
              bottom: 25.0,
              child: Text(
                'TransformType.diagonal3Values',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
          ],
          ),

```




## Getting started

```yaml
dependencies:
  carousel_custom_slider: ^0.0.5
```

## How to use

```dart

import 'package:carousel_custom_slider/carousel_custom_slider.dart';

```

## Uses
```dart

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

```


You can use these indicators in the effect.
```dart
effect : WormEffect(),
effect : JumpingDotEffect(),
effect : ScaleEffect(),
effect : ScrollingDotsEffect(),
effect : SlideEffect(),
effect : ExpandingDotsEffect(),
effect : SwapEffect(),
```


## Additional information

If you have any issues, questions, or suggestions related to this package, please feel free to contact us at [swan.dev1993@gmail.com](mailto:swan.dev1993@gmail.com). We welcome your feedback and will do our best to address any problems or provide assistance.
For more information about this package, you can also visit our [GitHub repository](https://github.com/SwanFlutter/carousel_custom_slider) where you can find additional resources, contribute to the package's development, and file issues or bug reports. We appreciate your contributions and feedback, and we aim to make this package as useful as possible for our users.
Thank you for using our package, and we look forward to hearing from you!

