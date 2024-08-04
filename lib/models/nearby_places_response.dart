class NearbyPlacesResponse {
  List<PlaceInfo>? places;

  NearbyPlacesResponse({this.places});

  NearbyPlacesResponse.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <PlaceInfo>[];
      json['places'].forEach((v) {
        places!.add(PlaceInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (places != null) {
      data['places'] = places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class PlaceInfo {
  String? name;
  String? id;
  String? nationalPhoneNumber;
  String? internationalPhoneNumber;
  String? formattedAddress;
  PlusCode? plusCode;
  Location? location;
  num? rating;
  String? googleMapsUri;
  String? websiteUri;
  RegularOpeningHours? regularOpeningHours;
  String? adrFormatAddress;
  String? businessStatus;
  String? priceLevel;
  String? phoneNumber;
  int? userRatingCount;
  String? iconMaskBaseUri;
  String? iconBackgroundColor;
  DisplayName? displayName;
  DisplayName? primaryTypeDisplayName;
  bool? delivery;
  bool? dineIn;
  bool? curbsidePickup;
  bool? reservable;
  RegularOpeningHours? currentOpeningHours;
  List<CurrentSecondaryOpeningHours>? currentSecondaryOpeningHours;
  String? primaryType;
  String? shortFormattedAddress;
  DisplayName? editorialSummary;
  List<Photos>? photos;
  bool? outdoorSeating;
  bool? liveMusic;
  bool? menuForChildren;
  bool? goodForChildren;
  bool? allowsDogs;
  bool? goodForGroups;
  bool? goodForWatchingSports;
  bool? servesVegetarianFood;
  PaymentOptions? paymentOptions;
  ParkingOptions? parkingOptions;
  AccessibilityOptions? accessibilityOptions;
  List<AddressComponents>? addressComponents;

  PlaceInfo(
      {this.name,
      this.id,
      this.nationalPhoneNumber,
      this.internationalPhoneNumber,
      this.formattedAddress,
      this.plusCode,
      this.location,
      this.rating,
      this.googleMapsUri,
      this.websiteUri,
      this.regularOpeningHours,
      this.adrFormatAddress,
      this.businessStatus,
      this.phoneNumber,
      this.priceLevel,
      this.userRatingCount,
      this.iconMaskBaseUri,
      this.iconBackgroundColor,
      this.displayName,
      this.primaryTypeDisplayName,
      this.delivery,
      this.dineIn,
      this.curbsidePickup,
      this.reservable,
      this.currentOpeningHours,
      this.currentSecondaryOpeningHours,
      this.primaryType,
      this.shortFormattedAddress,
      this.editorialSummary,
      this.photos,
      this.outdoorSeating,
      this.liveMusic,
      this.menuForChildren,
      this.goodForChildren,
      this.allowsDogs,
      this.goodForGroups,
      this.goodForWatchingSports,
      this.servesVegetarianFood,
      this.paymentOptions,
      this.parkingOptions,
      this.accessibilityOptions,
      this.addressComponents});

  PlaceInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    nationalPhoneNumber = json['nationalPhoneNumber'];
    internationalPhoneNumber = json['internationalPhoneNumber'];
    formattedAddress = json['formattedAddress'];
    plusCode =
        json['plusCode'] != null ? PlusCode.fromJson(json['plusCode']) : null;
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    rating = json['rating'];
    googleMapsUri = json['googleMapsUri'];
    websiteUri = json['websiteUri'];
    regularOpeningHours = json['regularOpeningHours'] != null
        ? RegularOpeningHours.fromJson(json['regularOpeningHours'])
        : null;
    adrFormatAddress = json['adrFormatAddress'];
    businessStatus = json['businessStatus'];
    priceLevel = json['priceLevel'];
    phoneNumber = json['nationalPhoneNumber'];
    userRatingCount = json['userRatingCount'];
    iconMaskBaseUri = json['iconMaskBaseUri'];
    iconBackgroundColor = json['iconBackgroundColor'];
    displayName = json['displayName'] != null
        ? DisplayName.fromJson(json['displayName'])
        : null;
    primaryTypeDisplayName = json['primaryTypeDisplayName'] != null
        ? DisplayName.fromJson(json['primaryTypeDisplayName'])
        : null;
    delivery = json['delivery'];
    dineIn = json['dineIn'];
    curbsidePickup = json['curbsidePickup'];
    reservable = json['reservable'];
    currentOpeningHours = json['currentOpeningHours'] != null
        ? RegularOpeningHours.fromJson(json['currentOpeningHours'])
        : null;
    if (json['currentSecondaryOpeningHours'] != null) {
      currentSecondaryOpeningHours = <CurrentSecondaryOpeningHours>[];
      json['currentSecondaryOpeningHours'].forEach((v) {
        currentSecondaryOpeningHours!
            .add(CurrentSecondaryOpeningHours.fromJson(v));
      });
    }
    primaryType = json['primaryType'];
    shortFormattedAddress = json['shortFormattedAddress'];
    editorialSummary = json['editorialSummary'] != null
        ? DisplayName.fromJson(json['editorialSummary'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    outdoorSeating = json['outdoorSeating'];
    liveMusic = json['liveMusic'];
    menuForChildren = json['menuForChildren'];
    goodForChildren = json['goodForChildren'];
    allowsDogs = json['allowsDogs'];
    goodForGroups = json['goodForGroups'];
    goodForWatchingSports = json['goodForWatchingSports'];
    servesVegetarianFood = json['servesVegetarianFood'];
    paymentOptions = json['paymentOptions'] != null
        ? PaymentOptions.fromJson(json['paymentOptions'])
        : null;
    parkingOptions = json['parkingOptions'] != null
        ? ParkingOptions.fromJson(json['parkingOptions'])
        : null;
    accessibilityOptions = json['accessibilityOptions'] != null
        ? AccessibilityOptions.fromJson(json['accessibilityOptions'])
        : null;
    if (json['addressComponents'] != null) {
      addressComponents = <AddressComponents>[];
      json['addressComponents'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['nationalPhoneNumber'] = nationalPhoneNumber;
    data['internationalPhoneNumber'] = internationalPhoneNumber;
    data['formattedAddress'] = formattedAddress;
    if (plusCode != null) {
      data['plusCode'] = plusCode!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['rating'] = rating;
    data['googleMapsUri'] = googleMapsUri;
    data['websiteUri'] = websiteUri;
    if (regularOpeningHours != null) {
      data['regularOpeningHours'] = regularOpeningHours!.toJson();
    }
    data['adrFormatAddress'] = adrFormatAddress;
    data['businessStatus'] = businessStatus;
    data['priceLevel'] = priceLevel;
    data['nationalPhoneNumber'] = phoneNumber;
    data['userRatingCount'] = userRatingCount;
    data['iconMaskBaseUri'] = iconMaskBaseUri;
    data['iconBackgroundColor'] = iconBackgroundColor;
    if (displayName != null) {
      data['displayName'] = displayName!.toJson();
    }
    if (primaryTypeDisplayName != null) {
      data['primaryTypeDisplayName'] = primaryTypeDisplayName!.toJson();
    }
    data['delivery'] = delivery;
    data['dineIn'] = dineIn;
    data['curbsidePickup'] = curbsidePickup;
    data['reservable'] = reservable;
    if (currentOpeningHours != null) {
      data['currentOpeningHours'] = currentOpeningHours!.toJson();
    }
    if (currentSecondaryOpeningHours != null) {
      data['currentSecondaryOpeningHours'] =
          currentSecondaryOpeningHours!.map((v) => v.toJson()).toList();
    }
    data['primaryType'] = primaryType;
    data['shortFormattedAddress'] = shortFormattedAddress;
    if (editorialSummary != null) {
      data['editorialSummary'] = editorialSummary!.toJson();
    }
    if (photos != null) {
      data['photos'] = photos!.map((v) => v.toJson()).toList();
    }
    data['outdoorSeating'] = outdoorSeating;
    data['liveMusic'] = liveMusic;
    data['menuForChildren'] = menuForChildren;
    data['goodForChildren'] = goodForChildren;
    data['allowsDogs'] = allowsDogs;
    data['goodForGroups'] = goodForGroups;
    data['goodForWatchingSports'] = goodForWatchingSports;
    data['servesVegetarianFood'] = servesVegetarianFood;
    if (paymentOptions != null) {
      data['paymentOptions'] = paymentOptions!.toJson();
    }
    if (parkingOptions != null) {
      data['parkingOptions'] = parkingOptions!.toJson();
    }
    if (accessibilityOptions != null) {
      data['accessibilityOptions'] = accessibilityOptions!.toJson();
    }
    if (addressComponents != null) {
      data['addressComponents'] =
          addressComponents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlusCode {
  String? globalCode;
  String? compoundCode;

  PlusCode({this.globalCode, this.compoundCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    globalCode = json['globalCode'];
    compoundCode = json['compoundCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['globalCode'] = globalCode;
    data['compoundCode'] = compoundCode;
    return data;
  }
}

class Location {
  double? latitude;
  double? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class RegularOpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayDescriptions;

  RegularOpeningHours({this.openNow, this.periods, this.weekdayDescriptions});

  RegularOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['openNow'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(Periods.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['openNow'] = openNow;
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = weekdayDescriptions;
    return data;
  }
}

class Periods {
  Open? open;
  Open? close;

  Periods({this.open, this.close});

  Periods.fromJson(Map<String, dynamic> json) {
    open = json['open'] != null ? Open.fromJson(json['open']) : null;
    close = json['close'] != null ? Open.fromJson(json['close']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (open != null) {
      data['open'] = open!.toJson();
    }
    if (close != null) {
      data['close'] = close!.toJson();
    }
    return data;
  }
}

class Open {
  int? day;
  int? hour;
  int? minute;

  Open({this.day, this.hour, this.minute});

  Open.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['day'] = day;
    data['hour'] = hour;
    data['minute'] = minute;
    return data;
  }
}

class DisplayName {
  String? text;
  String? languageCode;

  DisplayName({this.text, this.languageCode});

  DisplayName.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['languageCode'] = languageCode;
    return data;
  }
}

class Date {
  int? year;
  int? month;
  int? day;

  Date({this.year, this.month, this.day});

  Date.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    day = json['day'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['day'] = day;
    return data;
  }
}

class CurrentSecondaryOpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayDescriptions;
  String? secondaryHoursType;

  CurrentSecondaryOpeningHours(
      {this.openNow,
      this.periods,
      this.weekdayDescriptions,
      this.secondaryHoursType});

  CurrentSecondaryOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['openNow'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(Periods.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
    secondaryHoursType = json['secondaryHoursType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['openNow'] = openNow;
    if (periods != null) {
      data['periods'] = periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = weekdayDescriptions;
    data['secondaryHoursType'] = secondaryHoursType;
    return data;
  }
}

class Photos {
  String? name;
  int? widthPx;
  int? heightPx;
  List<AuthorAttributions>? authorAttributions;

  Photos({this.name, this.widthPx, this.heightPx, this.authorAttributions});

  Photos.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    widthPx = json['widthPx'];
    heightPx = json['heightPx'];
    if (json['authorAttributions'] != null) {
      authorAttributions = <AuthorAttributions>[];
      json['authorAttributions'].forEach((v) {
        authorAttributions!.add(AuthorAttributions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['widthPx'] = widthPx;
    data['heightPx'] = heightPx;
    if (authorAttributions != null) {
      data['authorAttributions'] =
          authorAttributions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AuthorAttributions {
  String? displayName;
  String? uri;
  String? photoUri;

  AuthorAttributions({this.displayName, this.uri, this.photoUri});

  AuthorAttributions.fromJson(Map<String, dynamic> json) {
    displayName = json['displayName'];
    uri = json['uri'];
    photoUri = json['photoUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['uri'] = uri;
    data['photoUri'] = photoUri;
    return data;
  }
}

class PaymentOptions {
  bool? acceptsDebitCards;
  bool? acceptsCashOnly;
  bool? acceptsNfc;
  bool? acceptsCreditCards;

  PaymentOptions(
      {this.acceptsDebitCards,
      this.acceptsCashOnly,
      this.acceptsNfc,
      this.acceptsCreditCards});

  PaymentOptions.fromJson(Map<String, dynamic> json) {
    acceptsDebitCards = json['acceptsDebitCards'];
    acceptsCashOnly = json['acceptsCashOnly'];
    acceptsNfc = json['acceptsNfc'];
    acceptsCreditCards = json['acceptsCreditCards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['acceptsDebitCards'] = acceptsDebitCards;
    data['acceptsCashOnly'] = acceptsCashOnly;
    data['acceptsNfc'] = acceptsNfc;
    data['acceptsCreditCards'] = acceptsCreditCards;
    return data;
  }
}

class ParkingOptions {
  bool? paidParkingLot;
  bool? freeStreetParking;
  bool? paidStreetParking;

  ParkingOptions(
      {this.paidParkingLot, this.freeStreetParking, this.paidStreetParking});

  ParkingOptions.fromJson(Map<String, dynamic> json) {
    paidParkingLot = json['paidParkingLot'];
    freeStreetParking = json['freeStreetParking'];
    paidStreetParking = json['paidStreetParking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paidParkingLot'] = paidParkingLot;
    data['freeStreetParking'] = freeStreetParking;
    data['paidStreetParking'] = paidStreetParking;
    return data;
  }
}

class AccessibilityOptions {
  bool? wheelchairAccessibleParking;
  bool? wheelchairAccessibleEntrance;
  bool? wheelchairAccessibleRestroom;
  bool? wheelchairAccessibleSeating;

  AccessibilityOptions(
      {this.wheelchairAccessibleParking,
      this.wheelchairAccessibleEntrance,
      this.wheelchairAccessibleRestroom,
      this.wheelchairAccessibleSeating});

  AccessibilityOptions.fromJson(Map<String, dynamic> json) {
    wheelchairAccessibleParking = json['wheelchairAccessibleParking'];
    wheelchairAccessibleEntrance = json['wheelchairAccessibleEntrance'];
    wheelchairAccessibleRestroom = json['wheelchairAccessibleRestroom'];
    wheelchairAccessibleSeating = json['wheelchairAccessibleSeating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wheelchairAccessibleParking'] = wheelchairAccessibleParking;
    data['wheelchairAccessibleEntrance'] = wheelchairAccessibleEntrance;
    data['wheelchairAccessibleRestroom'] = wheelchairAccessibleRestroom;
    data['wheelchairAccessibleSeating'] = wheelchairAccessibleSeating;
    return data;
  }
}

class Summary {
  String? queryType;
  int? queryTime;
  int? numResults;
  int? offset;
  int? totalResults;
  int? fuzzyLevel;
  GeoBias? geoBias;

  Summary(
      {this.queryType,
      this.queryTime,
      this.numResults,
      this.offset,
      this.totalResults,
      this.fuzzyLevel,
      this.geoBias});

  Summary.fromJson(Map<String, dynamic> json) {
    queryType = json['queryType'];
    queryTime = json['queryTime'];
    numResults = json['numResults'];
    offset = json['offset'];
    totalResults = json['totalResults'];
    fuzzyLevel = json['fuzzyLevel'];
    geoBias =
        json['geoBias'] != null ? GeoBias.fromJson(json['geoBias']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queryType'] = queryType;
    data['queryTime'] = queryTime;
    data['numResults'] = numResults;
    data['offset'] = offset;
    data['totalResults'] = totalResults;
    data['fuzzyLevel'] = fuzzyLevel;
    if (geoBias != null) {
      data['geoBias'] = geoBias!.toJson();
    }
    return data;
  }
}

class GeoBias {
  double? lat;
  double? lon;

  GeoBias({this.lat, this.lon});

  GeoBias.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lon = json['lon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lon'] = lon;
    return data;
  }
}


class AddressComponents {
  String? longText;
  String? shortText;
  List<String>? types;
  String? languageCode;

  AddressComponents(
      {this.longText, this.shortText, this.types, this.languageCode});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longText = json['longText'];
    shortText = json['shortText'];
    types = json['types'].cast<String>();
    languageCode = json['languageCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longText'] = longText;
    data['shortText'] = shortText;
    data['types'] = types;
    data['languageCode'] = languageCode;
    return data;
  }
}