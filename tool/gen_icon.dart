// Generates the CardVault app icon (1024×1024) and a splash logo, written to
// assets/icon/. Run with: `dart run tool/gen_icon.dart`
//
// Intentionally simple & brand-neutral (no copyrighted franchise art) — an
// indigo field with a stylised stacked-card mark, safe for Google Play.
import 'dart:io';

import 'package:image/image.dart' as img;

void main() {
  _writeIcon('assets/icon/app_icon.png', size: 1024, withBackground: true);
  _writeIcon('assets/icon/splash_logo.png', size: 512, withBackground: false);
  stdout.writeln('Generated app_icon.png and splash_logo.png');
}

void _writeIcon(
  String path, {
  required int size,
  required bool withBackground,
}) {
  final image = img.Image(width: size, height: size, numChannels: 4);

  final indigo = img.ColorRgb8(0x3D, 0x5A, 0xFE);
  final white = img.ColorRgb8(0xFF, 0xFF, 0xFF);
  final accent = img.ColorRgb8(0x00, 0xBF, 0xA5);

  if (withBackground) {
    img.fill(image, color: indigo);
  } else {
    img.fill(image, color: img.ColorRgba8(0, 0, 0, 0));
  }

  // Two overlapping "cards" forming the vault mark.
  final w = (size * 0.34).round();
  final h = (size * 0.46).round();
  final cx = size ~/ 2;
  final cy = size ~/ 2;

  // Back card (accent, rotated feel via offset).
  _roundedCard(
    image,
    cx - (w * 0.42).round(),
    cy - (h * 0.40).round(),
    w,
    h,
    accent,
  );
  // Front card (white).
  _roundedCard(
    image,
    cx - (w * 0.10).round(),
    cy - (h * 0.55).round(),
    w,
    h,
    white,
  );

  File(path).createSync(recursive: true);
  File(path).writeAsBytesSync(img.encodePng(image));
}

void _roundedCard(img.Image image, int x, int y, int w, int h, img.Color c) {
  img.fillRect(
    image,
    x1: x,
    y1: y,
    x2: x + w,
    y2: y + h,
    color: c,
    radius: (w * 0.12).round(),
  );
}
