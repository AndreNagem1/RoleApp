import 'package:flutter/cupertino.dart';
import 'package:rolesp/screens/events_screen/ui/events_background.dart';

String getPriceLevel(String priceLevel) {
  var priceLevelResource = 'assets/images/priceLevel0.png';

  if (priceLevel.contains('FREE')) {
    priceLevelResource = 'assets/images/priceLevel0.png';
  }
  if (priceLevel.contains('INEXPENSIVE')) {
    priceLevelResource = 'assets/images/priceLevel1.png';
  }

  if (priceLevel.contains('MODERATE')) {
    priceLevelResource = 'assets/images/priceLevel2.png';
  }

  if (priceLevel.contains('PRICE_LEVEL_EXPENSIVE')) {
    priceLevelResource = 'assets/images/priceLevel3.png';
  }

  if (priceLevel.contains('PRICE_LEVEL_VERY_EXPENSIVE	')) {
    priceLevelResource = 'assets/images/priceLevel4.png';
  }

  return priceLevelResource;
}

Widget getRating(num rating, BuildContext context) {
  if (rating <= 5.0) {}
  if (rating <= 4.5) {}
  if (rating <= 4.0) {}

  if (rating <= 3.5) {}
  if (rating <= 3.0) {}
  if (rating <= 2.5) {}
  if (rating <= 2.0) {}
  if (rating <= 1.5) {}
  if (rating <= 1.0) {}
  if (rating <= 0.5) {}
  if (rating == 0.0) {}

  return CustomPaint(
    painter: VectorBackgroundPainter(context),
  );
}
