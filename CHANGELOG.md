



## 0.2.0

* **NEW** Add `WheelGallery` widget — scroll-driven circular gallery inspired by CSS scroll-driven animations.
  Cards are arranged in a full circle; scrolling rotates the wheel one step at a time.
  The focused card is shown in full color and sharp while others become grayscale, blurred,
  and transparent based on distance. Supports light/dark theme automatically.
  Exposed via `CarouselCustomSlider.wheelGallery(...)` static method.
  New model class: `WheelGalleryItem`.

* **NEW** Add `Carousel3D` widget — a 3D rotating ring carousel without shader mask.
  Cards are arranged in a cylinder ring with perspective transform and backface culling.
  Exposed via `CarouselCustomSlider.carousel3D(carousel3DType: Carousel3DType.standard)`.

* **NEW** Add `Carousel3DShader` widget — same as `Carousel3D` but with a lateral
  `ShaderMask` gradient fade at screen edges.
  Exposed via `CarouselCustomSlider.carousel3D(carousel3DType: Carousel3DType.shader)`.

* **NEW** Add `Carousel3DAlt` widget — compact variant of `Carousel3D` with smaller cards
  and a closer camera for a stronger depth effect.
  Exposed via `CarouselCustomSlider.carousel3D(carousel3DType: Carousel3DType.alt)`.

* Add `Carousel3DType` enum with values: `standard`, `alt`, `shader`.
* Add `CarouselConfig` class with presets: `CarouselConfig.standard`, `.alt`, `.shader`.
* Remove `CircularGallery` and `PrismCarousel` — replaced by `WheelGallery`.

---

## 0.1.0

* Edit Package.
* Update SDK Package.

---

## 0.0.9

* Fix pub point.
* Update package.

---
## 0.0.8
* Add `animatedBuilderSettings` feature to allow customization of animated builder types:
  ```dart
  animatedBuilderSettings: AnimatedBuilderSettings(
    animatedBuilderType: AnimatedBuilderType.normalScale,
    useAnimatedBuilder: true,
  )
  ```

---
## 0.0.7+3

* Fix bug.

---
## 0.0.7+2

* Fix bug.
* Edit property children (`List<Widget>`) converted to `childrenStackBuilder` (`Widget Function(int index)? childrenStackBuilder`)

---
## 0.0.7+1

* Fix bug.

---
## 0.0.7

* Add to new feature.

---
## 0.0.6

* Fix bug.
* Add new feature: Transformed3DCardSlider

---
## 0.0.5

* Fix pub point.

---
## 0.0.4

* Fix Bug hidden indicator.
* Add new feature

---
## 0.0.3

* Fix Bug.

---
## 0.0.2

* Fix Pub Point.

---
## 0.0.1

* Initial release.