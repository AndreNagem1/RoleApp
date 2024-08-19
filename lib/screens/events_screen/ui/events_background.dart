import 'package:flutter/material.dart';

class VectorBackgroundPainter extends CustomPainter {
  final BuildContext context;

  const VectorBackgroundPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;

    // Create a gradient shader
    final Shader shader = LinearGradient(
      colors: [
        Theme.of(context).colorScheme.surfaceVariant,
        Theme.of(context).colorScheme.onSurfaceVariant,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    paint.shader = shader;

    // Apply a blur effect to the paint
    paint.maskFilter = const MaskFilter.blur(
        BlurStyle.normal, 40); // Adjust the blur radius as needed

    // Draw the wave at the top
    final Path topWavePath = Path();
    topWavePath.moveTo(0, size.height * 0.6); // Start the wave near the top
    topWavePath.quadraticBezierTo(
      size.width * 0.25, size.height * 0.01, // Control point
      size.width * 0.5, size.height * 0.4, // End point
    );
    topWavePath.quadraticBezierTo(
      size.width * 0.75, size.height * 0.1, // Control point
      size.width, size.height * 0.05, // End point at the right edge
    );
    topWavePath.lineTo(size.width, 0);
    topWavePath.lineTo(0, 0);
    topWavePath.close();

    // Draw the blurred wave at the top
    canvas.drawPath(topWavePath, paint);

    // Draw the wave at the bottom
    final Path bottomWavePath = Path();
    bottomWavePath.moveTo(
        0, size.height * 0.85); // Start the wave near the bottom
    bottomWavePath.quadraticBezierTo(
      size.width * 0.25, size.height * 1.2, // Control point
      size.width * 0.5, size.height * 0.75, // End point
    );
    bottomWavePath.quadraticBezierTo(
      size.width * 0.75, size.height * 0.9, // Control point
      size.width, size.height * 0.4, // End point at the right edge
    );
    bottomWavePath.lineTo(size.width, size.height);
    bottomWavePath.lineTo(0, size.height);
    bottomWavePath.close();

    // Draw the blurred wave at the bottom
    canvas.drawPath(bottomWavePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
