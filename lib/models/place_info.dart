import 'dart:ffi';

class PlaceInfo {
  String? type;
  String? id;
  double? score;
  double? dist;
  String? info;
  Poi? poi;
  List<RelatedPois>? relatedPois;
  Address? address;
  PositionModel? position;
  List<Mapcodes>? mapcodes;
  Viewport? viewport;
  List<EntryPoints>? entryPoints;
  ChargingPark? chargingPark;
  DataSources? dataSources;

  PlaceInfo(
      {this.type,
        this.id,
        this.score,
        this.dist,
        this.info,
        this.poi,
        this.relatedPois,
        this.address,
        this.position,
        this.mapcodes,
        this.viewport,
        this.entryPoints,
        this.chargingPark,
        this.dataSources});

  PlaceInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    id = json['id'];
    score = json['score'];
    dist = json['dist'];
    info = json['info'];
    poi = json['poi'] != null ? new Poi.fromJson(json['poi']) : null;
    if (json['relatedPois'] != null) {
      relatedPois = <RelatedPois>[];
      json['relatedPois'].forEach((v) {
        relatedPois!.add(new RelatedPois.fromJson(v));
      });
    }
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    position = json['position'] != null
        ? new PositionModel.fromJson(json['position'])
        : null;
    if (json['mapcodes'] != null) {
      mapcodes = <Mapcodes>[];
      json['mapcodes'].forEach((v) {
        mapcodes!.add(new Mapcodes.fromJson(v));
      });
    }
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
    if (json['entryPoints'] != null) {
      entryPoints = <EntryPoints>[];
      json['entryPoints'].forEach((v) {
        entryPoints!.add(new EntryPoints.fromJson(v));
      });
    }
    chargingPark = json['chargingPark'] != null
        ? new ChargingPark.fromJson(json['chargingPark'])
        : null;
    dataSources = json['dataSources'] != null
        ? new DataSources.fromJson(json['dataSources'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['id'] = this.id;
    data['score'] = this.score;
    data['dist'] = this.dist;
    data['info'] = this.info;
    if (this.poi != null) {
      data['poi'] = this.poi!.toJson();
    }
    if (this.relatedPois != null) {
      data['relatedPois'] = this.relatedPois!.map((v) => v.toJson()).toList();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    if (this.mapcodes != null) {
      data['mapcodes'] = this.mapcodes!.map((v) => v.toJson()).toList();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    if (this.entryPoints != null) {
      data['entryPoints'] = this.entryPoints!.map((v) => v.toJson()).toList();
    }
    if (this.chargingPark != null) {
      data['chargingPark'] = this.chargingPark!.toJson();
    }
    if (this.dataSources != null) {
      data['dataSources'] = this.dataSources!.toJson();
    }
    return data;
  }
}

class Poi {
  String? name;
  String? phone;
  String? url;
  List<Brands>? brands;
  List<CategorySet>? categorySet;
  List<String>? categories;
  OpeningHours? openingHours;
  List<Classifications>? classifications;
  TimeZone? timeZone;

  Poi(
      {this.name,
        this.phone,
        this.url,
        this.brands,
        this.categorySet,
        this.categories,
        this.openingHours,
        this.classifications,
        this.timeZone});

  Poi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    url = json['url'];
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
    if (json['categorySet'] != null) {
      categorySet = <CategorySet>[];
      json['categorySet'].forEach((v) {
        categorySet!.add(new CategorySet.fromJson(v));
      });
    }
    categories = json['categories'].cast<String>();
    openingHours = json['openingHours'] != null
        ? new OpeningHours.fromJson(json['openingHours'])
        : null;
    if (json['classifications'] != null) {
      classifications = <Classifications>[];
      json['classifications'].forEach((v) {
        classifications!.add(new Classifications.fromJson(v));
      });
    }
    timeZone = json['timeZone'] != null
        ? new TimeZone.fromJson(json['timeZone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['url'] = this.url;
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    if (this.categorySet != null) {
      data['categorySet'] = this.categorySet!.map((v) => v.toJson()).toList();
    }
    data['categories'] = this.categories;
    if (this.openingHours != null) {
      data['openingHours'] = this.openingHours!.toJson();
    }
    if (this.classifications != null) {
      data['classifications'] =
          this.classifications!.map((v) => v.toJson()).toList();
    }
    if (this.timeZone != null) {
      data['timeZone'] = this.timeZone!.toJson();
    }
    return data;
  }
}

class Brands {
  String? name;

  Brands({this.name});

  Brands.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class CategorySet {
  int? id;

  CategorySet({this.id});

  CategorySet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class OpeningHours {
  String? mode;
  List<TimeRanges>? timeRanges;

  OpeningHours({this.mode, this.timeRanges});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    if (json['timeRanges'] != null) {
      timeRanges = <TimeRanges>[];
      json['timeRanges'].forEach((v) {
        timeRanges!.add(new TimeRanges.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    if (this.timeRanges != null) {
      data['timeRanges'] = this.timeRanges!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeRanges {
  StartTime? startTime;
  StartTime? endTime;

  TimeRanges({this.startTime, this.endTime});

  TimeRanges.fromJson(Map<String, dynamic> json) {
    startTime = json['startTime'] != null
        ? new StartTime.fromJson(json['startTime'])
        : null;
    endTime = json['endTime'] != null
        ? new StartTime.fromJson(json['endTime'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.startTime != null) {
      data['startTime'] = this.startTime!.toJson();
    }
    if (this.endTime != null) {
      data['endTime'] = this.endTime!.toJson();
    }
    return data;
  }
}

class StartTime {
  String? date;
  int? hour;
  int? minute;

  StartTime({this.date, this.hour, this.minute});

  StartTime.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hour = json['hour'];
    minute = json['minute'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['hour'] = this.hour;
    data['minute'] = this.minute;
    return data;
  }
}

class Classifications {
  String? code;
  List<Names>? names;

  Classifications({this.code, this.names});

  Classifications.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names!.add(new Names.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.names != null) {
      data['names'] = this.names!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Names {
  String? nameLocale;
  String? name;

  Names({this.nameLocale, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    nameLocale = json['nameLocale'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nameLocale'] = this.nameLocale;
    data['name'] = this.name;
    return data;
  }
}

class TimeZone {
  String? ianaId;

  TimeZone({this.ianaId});

  TimeZone.fromJson(Map<String, dynamic> json) {
    ianaId = json['ianaId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ianaId'] = this.ianaId;
    return data;
  }
}

class RelatedPois {
  String? relationType;
  String? id;

  RelatedPois({this.relationType, this.id});

  RelatedPois.fromJson(Map<String, dynamic> json) {
    relationType = json['relationType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['relationType'] = this.relationType;
    data['id'] = this.id;
    return data;
  }
}

class Address {
  String? streetNumber;
  String? streetName;
  String? municipalitySubdivision;
  String? municipality;
  String? countrySecondarySubdivision;
  String? countryTertiarySubdivision;
  String? countrySubdivision;
  String? postalCode;
  String? extendedPostalCode;
  String? countryCode;
  String? country;
  String? countryCodeISO3;
  String? freeformAddress;
  String? countrySubdivisionName;
  String? localName;

  Address(
      {this.streetNumber,
        this.streetName,
        this.municipalitySubdivision,
        this.municipality,
        this.countrySecondarySubdivision,
        this.countryTertiarySubdivision,
        this.countrySubdivision,
        this.postalCode,
        this.extendedPostalCode,
        this.countryCode,
        this.country,
        this.countryCodeISO3,
        this.freeformAddress,
        this.countrySubdivisionName,
        this.localName});

  Address.fromJson(Map<String, dynamic> json) {
    streetNumber = json['streetNumber'];
    streetName = json['streetName'];
    municipalitySubdivision = json['municipalitySubdivision'];
    municipality = json['municipality'];
    countrySecondarySubdivision = json['countrySecondarySubdivision'];
    countryTertiarySubdivision = json['countryTertiarySubdivision'];
    countrySubdivision = json['countrySubdivision'];
    postalCode = json['postalCode'];
    extendedPostalCode = json['extendedPostalCode'];
    countryCode = json['countryCode'];
    country = json['country'];
    countryCodeISO3 = json['countryCodeISO3'];
    freeformAddress = json['freeformAddress'];
    countrySubdivisionName = json['countrySubdivisionName'];
    localName = json['localName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streetNumber'] = this.streetNumber;
    data['streetName'] = this.streetName;
    data['municipalitySubdivision'] = this.municipalitySubdivision;
    data['municipality'] = this.municipality;
    data['countrySecondarySubdivision'] = this.countrySecondarySubdivision;
    data['countryTertiarySubdivision'] = this.countryTertiarySubdivision;
    data['countrySubdivision'] = this.countrySubdivision;
    data['postalCode'] = this.postalCode;
    data['extendedPostalCode'] = this.extendedPostalCode;
    data['countryCode'] = this.countryCode;
    data['country'] = this.country;
    data['countryCodeISO3'] = this.countryCodeISO3;
    data['freeformAddress'] = this.freeformAddress;
    data['countrySubdivisionName'] = this.countrySubdivisionName;
    data['localName'] = this.localName;
    return data;
  }
}

class PositionModel {
  double? lat;
  double? lon;

  PositionModel({this.lat, this.lon});

  PositionModel.fromJson(Map<String, dynamic> json) {
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

class Mapcodes {
  String? type;
  String? fullMapcode;
  String? territory;
  String? code;

  Mapcodes({this.type, this.fullMapcode, this.territory, this.code});

  Mapcodes.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    fullMapcode = json['fullMapcode'];
    territory = json['territory'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['fullMapcode'] = this.fullMapcode;
    data['territory'] = this.territory;
    data['code'] = this.code;
    return data;
  }
}

class Viewport {
  PositionModel? topLeftPoint;
  PositionModel? btmRightPoint;

  Viewport({this.topLeftPoint, this.btmRightPoint});

  Viewport.fromJson(Map<String, dynamic> json) {
    topLeftPoint = json['topLeftPoint'] != null
        ? new PositionModel.fromJson(json['topLeftPoint'])
        : null;
    btmRightPoint = json['btmRightPoint'] != null
        ? new PositionModel.fromJson(json['btmRightPoint'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.topLeftPoint != null) {
      data['topLeftPoint'] = this.topLeftPoint!.toJson();
    }
    if (this.btmRightPoint != null) {
      data['btmRightPoint'] = this.btmRightPoint!.toJson();
    }
    return data;
  }
}

class EntryPoints {
  String? type;
  PositionModel? position;

  EntryPoints({this.type, this.position});

  EntryPoints.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    position = json['position'] != null
        ? new PositionModel.fromJson(json['position'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    if (this.position != null) {
      data['position'] = this.position!.toJson();
    }
    return data;
  }
}

class ChargingPark {
  List<Connectors>? connectors;

  ChargingPark({this.connectors});

  ChargingPark.fromJson(Map<String, dynamic> json) {
    if (json['connectors'] != null) {
      connectors = <Connectors>[];
      json['connectors'].forEach((v) {
        connectors!.add(new Connectors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.connectors != null) {
      data['connectors'] = this.connectors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Connectors {
  String? connectorType;
  double? ratedPowerKW;
  int? currentA;
  String? currentType;
  int? voltageV;

  Connectors(
      {this.connectorType,
        this.ratedPowerKW,
        this.currentA,
        this.currentType,
        this.voltageV});

  Connectors.fromJson(Map<String, dynamic> json) {
    connectorType = json['connectorType'];
    ratedPowerKW = json['ratedPowerKW'];
    currentA = json['currentA'];
    currentType = json['currentType'];
    voltageV = json['voltageV'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectorType'] = this.connectorType;
    data['ratedPowerKW'] = this.ratedPowerKW;
    data['currentA'] = this.currentA;
    data['currentType'] = this.currentType;
    data['voltageV'] = this.voltageV;
    return data;
  }
}

class DataSources {
  ChargingAvailability? chargingAvailability;
  ChargingAvailability? parkingAvailability;
  ChargingAvailability? fuelPrice;
  ChargingAvailability? geometry;

  DataSources(
      {this.chargingAvailability,
        this.parkingAvailability,
        this.fuelPrice,
        this.geometry});

  DataSources.fromJson(Map<String, dynamic> json) {
    chargingAvailability = json['chargingAvailability'] != null
        ? new ChargingAvailability.fromJson(json['chargingAvailability'])
        : null;
    parkingAvailability = json['parkingAvailability'] != null
        ? new ChargingAvailability.fromJson(json['parkingAvailability'])
        : null;
    fuelPrice = json['fuelPrice'] != null
        ? new ChargingAvailability.fromJson(json['fuelPrice'])
        : null;
    geometry = json['geometry'] != null
        ? new ChargingAvailability.fromJson(json['geometry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chargingAvailability != null) {
      data['chargingAvailability'] = this.chargingAvailability!.toJson();
    }
    if (this.parkingAvailability != null) {
      data['parkingAvailability'] = this.parkingAvailability!.toJson();
    }
    if (this.fuelPrice != null) {
      data['fuelPrice'] = this.fuelPrice!.toJson();
    }
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    return data;
  }
}

class ChargingAvailability {
  String? id;

  ChargingAvailability({this.id});

  ChargingAvailability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}
