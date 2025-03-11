class Location {
  String name;
  String country;
  String state;
  double latitude;
  double longitude;

  Location({
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.country,
    required this.state,
  });

  Location.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        state = json['admin1'] ?? "",
        country = json['country'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
      'admin1': state,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
