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

  Result({this.formattedPhoneNumber, this.openingHours});

  Result.fromJson(Map<String, dynamic> json) {
    formattedPhoneNumber = json['formatted_phone_number'];
    openingHours = json['opening_hours'] != null
        ? OpeningHours.fromJson(json['opening_hours'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['formatted_phone_number'] = formattedPhoneNumber;
    if (openingHours != null) {
      data['opening_hours'] = openingHours!.toJson();
    }
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
