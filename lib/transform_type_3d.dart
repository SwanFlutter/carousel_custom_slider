export 'transform_type_3d.dart';

enum TransformType3d {
  identity,
  identity1,
  inverted,
  inverted1,
  inverted2,
  inverted3,
  inverted4,
  rotationY,
  rotationX,
}

/// The style/type of the 3D ring carousel.
///
/// - [standard] — Large cards in a fixed container, no shader mask.
/// - [alt]      — Compact cards with a closer camera, no shader mask.
/// - [shader]   — Large cards with a lateral [ShaderMask] fade at the edges.
enum Carousel3DType { standard, alt, shader }
