import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarPainter extends CustomPainter {
  const StarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;

    final Path path = Path();

    // Define the number of points for the star
    const int points = 5;
    final double outerRadius = size.width / 2;
    final double innerRadius = outerRadius / 2.5;
    const double angle = (2 * pi) / points;

    // Calculate the coordinates for the star's points
    for (int i = 0; i < points; i++) {
      double x = size.width / 2 + outerRadius * cos(i * angle);
      double y = size.height / 2 - outerRadius * sin(i * angle);
      path.lineTo(x, y);

      x = size.width / 2 + innerRadius * cos((i + 0.5) * angle);
      y = size.height / 2 - innerRadius * sin((i + 0.5) * angle);
      path.lineTo(x, y);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
