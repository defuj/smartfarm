import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LocationModel {
  @JsonKey(name: 'locationID')
  final String? locationID;
  @JsonKey(name: 'locationName')
  final String? locationName;

  LocationModel({
    this.locationID,
    this.locationName,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locationID: json['locationID'] as String?,
      locationName: json['locationName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locationID': locationID,
      'locationName': locationName,
    };
  }
}
