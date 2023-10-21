class EventsList {
  String? status;
  List<Events>? events;

  EventsList({this.status, this.events});

  EventsList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String? eventId;
  String? name;
  String? location;
  String? startDate;
  String? endDate;
  String? description;
  String? url;

  Events(
      {this.eventId,
        this.name,
        this.location,
        this.startDate,
        this.endDate,
        this.description,
        this.url});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    name = json['name'];
    location = json['location'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    description = json['description'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['event_id'] = eventId;
    data['name'] = name;
    data['location'] = location;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['description'] = description;
    data['url'] = url;
    return data;
  }
}
