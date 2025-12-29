// ignore_for_file: avoid_print
import 'dart:io';
import 'package:image/image.dart' as img;

/// Generates app icon PNG files for the Data Entry App
void main() async {
  print('🎨 Generating Data Entry App Icon...');

  // Create a 512x512 icon
  final image = img.Image(width: 512, height: 512);

  // Colors
  final primaryColor = img.ColorRgba8(92, 76, 219, 255); // #5C4CDB
  final primaryLight = img.ColorRgba8(123, 110, 231, 255); // #7B6EE7
  final white = img.ColorRgba8(255, 255, 255, 255);
  final lightGray = img.ColorRgba8(230, 230, 230, 255);
  final green = img.ColorRgba8(76, 175, 80, 255); // #4CAF50
  final textLineColor = img.ColorRgba8(92, 76, 219, 80); // Primary with opacity

  // Fill background with gradient-like color
  for (int y = 0; y < 512; y++) {
    for (int x = 0; x < 512; x++) {
      if (_isInsideRoundedRect(x, y, 0, 0, 512, 512, 80)) {
        final t = (x + y) / 1024.0;
        final r = (primaryLight.r * (1 - t) + primaryColor.r * t).round();
        final g = (primaryLight.g * (1 - t) + primaryColor.g * t).round();
        final b = (primaryLight.b * (1 - t) + primaryColor.b * t).round();
        image.setPixel(x, y, img.ColorRgba8(r, g, b, 255));
      }
    }
  }

  // Draw document shape - main body
  _drawRoundedRect(image, 130, 80, 252, 340, 16, white);

  // Draw folded corner effect
  for (int y = 80; y < 160; y++) {
    for (int x = 302; x < 382; x++) {
      if (x - 302 > y - 80) {
        if (x >= 0 && x < 512 && y >= 0 && y < 512) {
          image.setPixel(x, y, white);
        }
      }
    }
  }

  // Draw the fold shadow
  for (int y = 80; y < 160; y++) {
    for (int x = 302; x < 382; x++) {
      if ((x - 302) <= (y - 80) && (x - 302) >= (y - 80) - 20) {
        if (x >= 0 && x < 512 && y >= 0 && y < 512) {
          image.setPixel(x, y, lightGray);
        }
      }
    }
  }

  // Draw text lines (placeholders for form fields)
  _drawRoundedRect(image, 160, 190, 150, 16, 8, textLineColor);
  _drawRoundedRect(image, 160, 220, 192, 16, 8, textLineColor);
  _drawRoundedRect(image, 160, 250, 120, 16, 8, textLineColor);

  // Draw input field outline
  _drawRoundedRectOutline(image, 160, 300, 192, 50, 25, primaryColor, 4);

  // Draw cursor inside input
  _drawRoundedRect(image, 180, 315, 3, 20, 1, primaryColor);

  // Draw green checkmark circle
  _drawFilledCircle(image, 380, 380, 50, green);

  // Draw checkmark with better visibility
  _drawThickLine(image, 355, 380, 372, 400, white, 8);
  _drawThickLine(image, 372, 400, 405, 358, white, 8);

  // Ensure output directory exists
  final dir = Directory('assets/icon');
  if (!dir.existsSync()) {
    dir.createSync(recursive: true);
  }

  // Save main icon
  final pngBytes = img.encodePng(image);
  await File('assets/icon/app_icon.png').writeAsBytes(pngBytes);
  print('✅ Main icon saved to assets/icon/app_icon.png');

  // Create foreground icon for adaptive icons
  final foregroundImage = img.Image(width: 512, height: 512);
  img.fill(foregroundImage, color: img.ColorRgba8(0, 0, 0, 0));

  // Draw document on foreground
  _drawRoundedRect(foregroundImage, 110, 60, 252, 340, 16, white);

  // Folded corner
  for (int y = 60; y < 140; y++) {
    for (int x = 282; x < 362; x++) {
      if (x - 282 > y - 60) {
        if (x >= 0 && x < 512 && y >= 0 && y < 512) {
          foregroundImage.setPixel(x, y, white);
        }
      }
    }
  }

  for (int y = 60; y < 140; y++) {
    for (int x = 282; x < 362; x++) {
      if ((x - 282) <= (y - 60) && (x - 282) >= (y - 60) - 20) {
        if (x >= 0 && x < 512 && y >= 0 && y < 512) {
          foregroundImage.setPixel(x, y, lightGray);
        }
      }
    }
  }

  _drawRoundedRect(foregroundImage, 140, 170, 150, 16, 8, primaryColor);
  _drawRoundedRect(foregroundImage, 140, 200, 192, 16, 8, primaryColor);
  _drawRoundedRect(foregroundImage, 140, 230, 120, 16, 8, primaryColor);
  _drawRoundedRectOutline(
    foregroundImage,
    140,
    280,
    192,
    50,
    25,
    primaryColor,
    4,
  );
  _drawRoundedRect(foregroundImage, 160, 295, 3, 20, 1, primaryColor);
  _drawFilledCircle(foregroundImage, 360, 360, 50, green);
  _drawThickLine(foregroundImage, 335, 360, 352, 380, white, 8);
  _drawThickLine(foregroundImage, 352, 380, 385, 338, white, 8);

  final foregroundPng = img.encodePng(foregroundImage);
  await File('assets/icon/app_icon_foreground.png').writeAsBytes(foregroundPng);
  print('✅ Foreground icon saved to assets/icon/app_icon_foreground.png');

  print('🎉 Icon generation complete!');
  print('');
  print('Run: flutter pub run flutter_launcher_icons');
}

bool _isInsideRoundedRect(
  int x,
  int y,
  int rx,
  int ry,
  int rw,
  int rh,
  int radius,
) {
  if (x < rx || x >= rx + rw || y < ry || y >= ry + rh) return false;

  if (x < rx + radius && y < ry + radius) {
    return _isInsideCircle(x, y, rx + radius, ry + radius, radius);
  }
  if (x >= rx + rw - radius && y < ry + radius) {
    return _isInsideCircle(x, y, rx + rw - radius, ry + radius, radius);
  }
  if (x < rx + radius && y >= ry + rh - radius) {
    return _isInsideCircle(x, y, rx + radius, ry + rh - radius, radius);
  }
  if (x >= rx + rw - radius && y >= ry + rh - radius) {
    return _isInsideCircle(x, y, rx + rw - radius, ry + rh - radius, radius);
  }

  return true;
}

bool _isInsideCircle(int x, int y, int cx, int cy, int radius) {
  final dx = x - cx;
  final dy = y - cy;
  return dx * dx + dy * dy <= radius * radius;
}

void _drawRoundedRect(
  img.Image image,
  int x,
  int y,
  int w,
  int h,
  int radius,
  img.Color color,
) {
  for (int py = y; py < y + h; py++) {
    for (int px = x; px < x + w; px++) {
      if (_isInsideRoundedRect(px, py, x, y, w, h, radius)) {
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          image.setPixel(px, py, color);
        }
      }
    }
  }
}

void _drawRoundedRectOutline(
  img.Image image,
  int x,
  int y,
  int w,
  int h,
  int radius,
  img.Color color,
  int thickness,
) {
  for (int py = y - thickness; py < y + h + thickness; py++) {
    for (int px = x - thickness; px < x + w + thickness; px++) {
      final outer = _isInsideRoundedRect(
        px,
        py,
        x - thickness,
        y - thickness,
        w + thickness * 2,
        h + thickness * 2,
        radius + thickness,
      );
      final inner = _isInsideRoundedRect(px, py, x, y, w, h, radius);
      if (outer && !inner) {
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          image.setPixel(px, py, color);
        }
      }
    }
  }
}

void _drawFilledCircle(
  img.Image image,
  int cx,
  int cy,
  int radius,
  img.Color color,
) {
  for (int y = cy - radius; y <= cy + radius; y++) {
    for (int x = cx - radius; x <= cx + radius; x++) {
      if (_isInsideCircle(x, y, cx, cy, radius)) {
        if (x >= 0 && x < image.width && y >= 0 && y < image.height) {
          image.setPixel(x, y, color);
        }
      }
    }
  }
}

void _drawThickLine(
  img.Image image,
  int x1,
  int y1,
  int x2,
  int y2,
  img.Color color,
  int thickness,
) {
  final dx = (x2 - x1).abs();
  final dy = (y2 - y1).abs();
  final sx = x1 < x2 ? 1 : -1;
  final sy = y1 < y2 ? 1 : -1;
  var err = dx - dy;

  var x = x1;
  var y = y1;

  final halfThick = thickness ~/ 2;

  while (true) {
    for (int ty = -halfThick; ty <= halfThick; ty++) {
      for (int tx = -halfThick; tx <= halfThick; tx++) {
        final px = x + tx;
        final py = y + ty;
        if (px >= 0 && px < image.width && py >= 0 && py < image.height) {
          if (tx * tx + ty * ty <= halfThick * halfThick + halfThick) {
            image.setPixel(px, py, color);
          }
        }
      }
    }

    if (x == x2 && y == y2) break;
    final e2 = 2 * err;
    if (e2 > -dy) {
      err -= dy;
      x += sx;
    }
    if (e2 < dx) {
      err += dx;
      y += sy;
    }
  }
}
