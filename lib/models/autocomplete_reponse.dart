// To parse this JSON data, do
//
//     final autoCompleteResponse = autoCompleteResponseFromJson(jsonString);

import 'dart:convert';

List<AutoCompleteResponse> autoCompleteResponseFromJson(String str) => List<AutoCompleteResponse>.from(json.decode(str).map((x) => AutoCompleteResponse.fromJson(x)));

String autoCompleteResponseToJson(List<AutoCompleteResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AutoCompleteResponse {
  int id;
  String name;
  String region;
  String country;
  double lat;
  double lon;
  String url;

  AutoCompleteResponse({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  factory AutoCompleteResponse.fromJson(Map<String, dynamic> json) => AutoCompleteResponse(
    id: json["id"],
    name: json["name"],
    region: json["region"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "region": region,
    "country": country,
    "lat": lat,
    "lon": lon,
    "url": url,
  };
}
