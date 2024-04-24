
This is a simple slider package, you can put the position of the indicator and text on it and personalize it.

## Features


✔️ Ability to zoom with double tab.
✔️ The possibility of choosing several effects for the indicator.
✔️ Display text for title and body and specify its position.
✔️ Select the position of the slider indicator.
✔️ Download images in blur.

![20240418_081900](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/e8d7b540-7e35-45b7-880b-1116255b6347)

![20240418_081732](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/46e38714-27f2-4813-b542-ce0a07062e79)

![20240422_115507](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/a12ed375-8278-43b8-b33a-323be33e801f)

![20240419_094517](https://github.com/SwanFlutter/carousel_custom_slider/assets/151648897/e3267854-06ff-4b93-b871-d572cda09a4c)




## Getting started

```yaml
dependencies:
  carousel: ^0.0.1
```

## How to use

```dart

import 'package:carousel_custom_slider/carousel_custom_slider.dart';

```

## Uses
```dart

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

```

## example

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

