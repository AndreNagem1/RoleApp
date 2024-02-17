
class NearbyPlacesResponse {
  List<Places>? places;

  NearbyPlacesResponse({this.places});

  NearbyPlacesResponse.fromJson(Map<String, dynamic> json) {
    if (json['places'] != null) {
      places = <Places>[];
      json['places'].forEach((v) {
        places!.add(new Places.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.places != null) {
      data['places'] = this.places!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Places {
  String? name;
  String? id;
  String? nationalPhoneNumber;
  String? internationalPhoneNumber;
  String? formattedAddress;
  PlusCode? plusCode;
  Location? location;
  double? rating;
  String? googleMapsUri;
  String? websiteUri;
  RegularOpeningHours? regularOpeningHours;
  String? adrFormatAddress;
  String? businessStatus;
  String? priceLevel;
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
  PaymentOptions? paymentOptions;
  ParkingOptions? parkingOptions;
  AccessibilityOptions? accessibilityOptions;

  Places(
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
        this.paymentOptions,
        this.parkingOptions,
        this.accessibilityOptions});

  Places.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    nationalPhoneNumber = json['nationalPhoneNumber'];
    internationalPhoneNumber = json['internationalPhoneNumber'];
    formattedAddress = json['formattedAddress'];
    plusCode = json['plusCode'] != null
        ? new PlusCode.fromJson(json['plusCode'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    rating = json['rating'];
    googleMapsUri = json['googleMapsUri'];
    websiteUri = json['websiteUri'];
    regularOpeningHours = json['regularOpeningHours'] != null
        ? new RegularOpeningHours.fromJson(json['regularOpeningHours'])
        : null;
    adrFormatAddress = json['adrFormatAddress'];
    businessStatus = json['businessStatus'];
    priceLevel = json['priceLevel'];
    userRatingCount = json['userRatingCount'];
    iconMaskBaseUri = json['iconMaskBaseUri'];
    iconBackgroundColor = json['iconBackgroundColor'];
    displayName = json['displayName'] != null
        ? new DisplayName.fromJson(json['displayName'])
        : null;
    primaryTypeDisplayName = json['primaryTypeDisplayName'] != null
        ? new DisplayName.fromJson(json['primaryTypeDisplayName'])
        : null;
    delivery = json['delivery'];
    dineIn = json['dineIn'];
    curbsidePickup = json['curbsidePickup'];
    reservable = json['reservable'];
    currentOpeningHours = json['currentOpeningHours'] != null
        ? new RegularOpeningHours.fromJson(json['currentOpeningHours'])
        : null;
    if (json['currentSecondaryOpeningHours'] != null) {
      currentSecondaryOpeningHours = <CurrentSecondaryOpeningHours>[];
      json['currentSecondaryOpeningHours'].forEach((v) {
        currentSecondaryOpeningHours!
            .add(new CurrentSecondaryOpeningHours.fromJson(v));
      });
    }
    primaryType = json['primaryType'];
    shortFormattedAddress = json['shortFormattedAddress'];
    editorialSummary = json['editorialSummary'] != null
        ? new DisplayName.fromJson(json['editorialSummary'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    outdoorSeating = json['outdoorSeating'];
    liveMusic = json['liveMusic'];
    menuForChildren = json['menuForChildren'];
    goodForChildren = json['goodForChildren'];
    allowsDogs = json['allowsDogs'];
    goodForGroups = json['goodForGroups'];
    goodForWatchingSports = json['goodForWatchingSports'];
    paymentOptions = json['paymentOptions'] != null
        ? new PaymentOptions.fromJson(json['paymentOptions'])
        : null;
    parkingOptions = json['parkingOptions'] != null
        ? new ParkingOptions.fromJson(json['parkingOptions'])
        : null;
    accessibilityOptions = json['accessibilityOptions'] != null
        ? new AccessibilityOptions.fromJson(json['accessibilityOptions'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['nationalPhoneNumber'] = this.nationalPhoneNumber;
    data['internationalPhoneNumber'] = this.internationalPhoneNumber;
    data['formattedAddress'] = this.formattedAddress;
    if (this.plusCode != null) {
      data['plusCode'] = this.plusCode!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['rating'] = this.rating;
    data['googleMapsUri'] = this.googleMapsUri;
    data['websiteUri'] = this.websiteUri;
    if (this.regularOpeningHours != null) {
      data['regularOpeningHours'] = this.regularOpeningHours!.toJson();
    }
    data['adrFormatAddress'] = this.adrFormatAddress;
    data['businessStatus'] = this.businessStatus;
    data['priceLevel'] = this.priceLevel;
    data['userRatingCount'] = this.userRatingCount;
    data['iconMaskBaseUri'] = this.iconMaskBaseUri;
    data['iconBackgroundColor'] = this.iconBackgroundColor;
    if (this.displayName != null) {
      data['displayName'] = this.displayName!.toJson();
    }
    if (this.primaryTypeDisplayName != null) {
      data['primaryTypeDisplayName'] = this.primaryTypeDisplayName!.toJson();
    }
    data['delivery'] = this.delivery;
    data['dineIn'] = this.dineIn;
    data['curbsidePickup'] = this.curbsidePickup;
    data['reservable'] = this.reservable;
    if (this.currentOpeningHours != null) {
      data['currentOpeningHours'] = this.currentOpeningHours!.toJson();
    }
    if (this.currentSecondaryOpeningHours != null) {
      data['currentSecondaryOpeningHours'] =
          this.currentSecondaryOpeningHours!.map((v) => v.toJson()).toList();
    }
    data['primaryType'] = this.primaryType;
    data['shortFormattedAddress'] = this.shortFormattedAddress;
    if (this.editorialSummary != null) {
      data['editorialSummary'] = this.editorialSummary!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['outdoorSeating'] = this.outdoorSeating;
    data['liveMusic'] = this.liveMusic;
    data['menuForChildren'] = this.menuForChildren;
    data['goodForChildren'] = this.goodForChildren;
    data['allowsDogs'] = this.allowsDogs;
    data['goodForGroups'] = this.goodForGroups;
    data['goodForWatchingSports'] = this.goodForWatchingSports;
    if (this.paymentOptions != null) {
      data['paymentOptions'] = this.paymentOptions!.toJson();
    }
    if (this.parkingOptions != null) {
      data['parkingOptions'] = this.parkingOptions!.toJson();
    }
    if (this.accessibilityOptions != null) {
      data['accessibilityOptions'] = this.accessibilityOptions!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['globalCode'] = this.globalCode;
    data['compoundCode'] = this.compoundCode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
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
        periods!.add(new Periods.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openNow'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = this.weekdayDescriptions;
    return data;
  }
}

class Periods {
  Open? open;
  Open? close;

  Periods({this.open, this.close});

  Periods.fromJson(Map<String, dynamic> json) {
    open = json['open'] != null ? new Open.fromJson(json['open']) : null;
    close = json['close'] != null ? new Open.fromJson(json['close']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    if (this.close != null) {
      data['close'] = this.close!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['languageCode'] = this.languageCode;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['month'] = this.month;
    data['day'] = this.day;
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
        periods!.add(new Periods.fromJson(v));
      });
    }
    weekdayDescriptions = json['weekdayDescriptions'].cast<String>();
    secondaryHoursType = json['secondaryHoursType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openNow'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekdayDescriptions'] = this.weekdayDescriptions;
    data['secondaryHoursType'] = this.secondaryHoursType;
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
        authorAttributions!.add(new AuthorAttributions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['widthPx'] = this.widthPx;
    data['heightPx'] = this.heightPx;
    if (this.authorAttributions != null) {
      data['authorAttributions'] =
          this.authorAttributions!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['uri'] = this.uri;
    data['photoUri'] = this.photoUri;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['acceptsDebitCards'] = this.acceptsDebitCards;
    data['acceptsCashOnly'] = this.acceptsCashOnly;
    data['acceptsNfc'] = this.acceptsNfc;
    data['acceptsCreditCards'] = this.acceptsCreditCards;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paidParkingLot'] = this.paidParkingLot;
    data['freeStreetParking'] = this.freeStreetParking;
    data['paidStreetParking'] = this.paidStreetParking;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wheelchairAccessibleParking'] = this.wheelchairAccessibleParking;
    data['wheelchairAccessibleEntrance'] = this.wheelchairAccessibleEntrance;
    data['wheelchairAccessibleRestroom'] = this.wheelchairAccessibleRestroom;
    data['wheelchairAccessibleSeating'] = this.wheelchairAccessibleSeating;
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
        json['geoBias'] != null ? new GeoBias.fromJson(json['geoBias']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['queryType'] = this.queryType;
    data['queryTime'] = this.queryTime;
    data['numResults'] = this.numResults;
    data['offset'] = this.offset;
    data['totalResults'] = this.totalResults;
    data['fuzzyLevel'] = this.fuzzyLevel;
    if (this.geoBias != null) {
      data['geoBias'] = this.geoBias!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    return data;
  }
}
