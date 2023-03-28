class PlaceDetailsResponse {
  Result? result;
  String? status;

  PlaceDetailsResponse({this.result, this.status});

  PlaceDetailsResponse.fromJson(Map<String, dynamic> json) {
    if (json['html_attributions'] != null) {
      json['html_attributions'].forEach((v) {
        //  htmlAttributions!.add(new Null.fromJson(v));
      });
    }
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Result {
  String? formattedPhoneNumber;
  OpeningHours? openingHours;
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;
  String? vicinity;
  String? website;

  Result(
      {this.formattedPhoneNumber,
      this.openingHours,
      this.addressComponents,
      this.adrAddress,
      this.formattedAddress,
      this.geometry,
      this.icon,
      this.iconBackgroundColor,
      this.iconMaskBaseUri,
      this.name,
      this.photos,
      this.placeId,
      this.reference,
      this.types,
      this.url,
      this.utcOffset,
      this.vicinity,
      this.website});

  Result.fromJson(Map<String, dynamic> json) {
    formattedPhoneNumber = json['formatted_phone_number'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_phone_number'] = formattedPhoneNumber;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['website'] = website;
    return data;
  }
}

class OpeningHours {
  List<String>? weekdayText;

  OpeningHours({this.weekdayText});

  OpeningHours.fromJson(Map<String, dynamic> json) {
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weekday_text'] = weekdayText;
    return data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast =
        json['northeast'] != null ? Location.fromJson(json['northeast']) : null;
    southwest =
        json['southwest'] != null ? Location.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['html_attributions'] = htmlAttributions;
    data['photo_reference'] = photoReference;
    data['width'] = width;
    return data;
  }
}
