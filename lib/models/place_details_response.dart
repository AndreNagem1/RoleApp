import 'package:rolesp/models/places_nearby_response.dart';

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
  List<Reviews>? reviews;

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
      this.website,
      this.reviews});

  Result.fromJson(Map<String, dynamic> json) {
    formattedPhoneNumber = json['formatted_phone_number'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
    website = json['website'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
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
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  Reviews(
      {this.authorName,
        this.authorUrl,
        this.language,
        this.originalLanguage,
        this.profilePhotoUrl,
        this.rating,
        this.relativeTimeDescription,
        this.text,
        this.time,
        this.translated});

  Reviews.fromJson(Map<String, dynamic> json) {
    authorName = json['author_name'];
    authorUrl = json['author_url'];
    language = json['language'];
    originalLanguage = json['original_language'];
    profilePhotoUrl = json['profile_photo_url'];
    rating = json['rating'];
    relativeTimeDescription = json['relative_time_description'];
    text = json['text'];
    time = json['time'];
    translated = json['translated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['author_name'] = authorName;
    data['author_url'] = authorUrl;
    data['language'] = language;
    data['original_language'] = originalLanguage;
    data['profile_photo_url'] = profilePhotoUrl;
    data['rating'] = rating;
    data['relative_time_description'] = relativeTimeDescription;
    data['text'] = text;
    data['time'] = time;
    data['translated'] = translated;
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

