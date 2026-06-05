// Generates the CardVault brand mark — a gradient "vault" shield (forming a
// subtle V) on the indigo→violet brand gradient. Port of the design-system
// VaultMark. Run: `dart run tool/gen_icon.dart`
//
// Brand-neutral (no franchise art), safe for Google Play.
import 'dart:io';

import 'package:image/image.dart' as img;

// Brand stops.
const _indigo = [0x42, 0x54, 0xFF];
const _violet = [0x7A, 0x3D, 0xFF];

void main() {
  // Full launcher icon: gradient field + white shield + indigo "V".
  _writeIcon('assets/icon/app_icon.png', size: 1024, withGradientBg: true);
  // Splash / adaptive foreground: white shield on transparent, no field.
  _writeIcon('assets/icon/splash_logo.png', size: 512, withGradientBg: false);
  stdout.writeln('Generated app_icon.png + splash_logo.png');
}

void _writeIcon(
  String path, {
  required int size,
  required bool withGradientBg,
}) {
  final image = img.Image(width: size, height: size, numChannels: 4);
  img.fill(image, color: img.ColorRgba8(0, 0, 0, 0));

  if (withGradientBg) {
    // Diagonal indigo→violet gradient over the whole tile.
    for (var y = 0; y < size; y++) {
      for (var x = 0; x < size; x++) {
        final t = (x + y) / (2 * size);
        image.setPixelRgba(
          x,
          y,
          _lerp(_indigo[0], _violet[0], t),
          _lerp(_indigo[1], _violet[1], t),
          _lerp(_indigo[2], _violet[2], t),
          255,
        );
      }
    }
  }

  final s = size / 100; // design space is a 100×100 viewBox
  num sx(num v) => v * s;

  // Shield silhouette (white on the gradient; the brand mark on splash).
  final shield = <img.Point>[
    img.Point(sx(32), sx(30)),
    img.Point(sx(34), sx(26)),
    img.Point(sx(38), sx(25)),
    img.Point(sx(62), sx(25)),
    img.Point(sx(66), sx(26)),
    img.Point(sx(68), sx(30)),
    img.Point(sx(68), sx(57)),
    img.Point(sx(64), sx(66)),
    img.Point(sx(52), sx(77)),
    img.Point(sx(50), sx(79)),
    img.Point(sx(48), sx(77)),
    img.Point(sx(36), sx(66)),
    img.Point(sx(32), sx(57)),
  ];
  img.fillPolygon(
    image,
    vertices: shield,
    color: img.ColorRgba8(255, 255, 255, 255),
  );

  // The "V" — brand indigo on the white shield.
  final stroke = img.ColorRgb8(_indigo[0], _indigo[1], _indigo[2]);
  final thick = (4.2 * s).round();
  img.drawLine(
    image,
    x1: sx(43).round(),
    y1: sx(44).round(),
    x2: sx(50).round(),
    y2: sx(58).round(),
    color: stroke,
    thickness: thick,
    antialias: true,
  );
  img.drawLine(
    image,
    x1: sx(50).round(),
    y1: sx(58).round(),
    x2: sx(57).round(),
    y2: sx(44).round(),
    color: stroke,
    thickness: thick,
    antialias: true,
  );

  File(path).createSync(recursive: true);
  File(path).writeAsBytesSync(img.encodePng(image));
}

int _lerp(int a, int b, double t) => (a + (b - a) * t).round().clamp(0, 255);
