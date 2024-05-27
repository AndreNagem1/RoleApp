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

String getRating(num rating) {
  var ratingResource = 'assets/images/avaliations0.png';

  if (rating <= 5.0) {
    ratingResource = 'assets/images/avaliations10.png';
  }
  if (rating <= 4.5) {
    ratingResource = 'assets/images/avaliations9.png';
  }
  if (rating <= 4.0) {
    ratingResource = 'assets/images/avaliations8.png';
  }

  if (rating <= 3.5) {
    ratingResource = 'assets/images/avaliations7.png';
  }
  if (rating <= 3.0) {
    ratingResource = 'assets/images/avaliations6.png';
  }
  if (rating <= 2.5) {
    ratingResource = 'assets/images/avaliations5.png';
  }
  if (rating <= 2.0) {
    ratingResource = 'assets/images/avaliations4.png';
  }
  if (rating <= 1.5) {
    ratingResource = 'assets/images/avaliations3.png';
  }
  if (rating <= 1.0) {
    ratingResource = 'assets/images/avaliations2.png';
  }
  if (rating <= 0.5) {
    ratingResource = 'assets/images/avaliations1.png';
  }
  if (rating == 0.0) {
    ratingResource = 'assets/images/avaliations0.png';
  }
  return ratingResource;
}