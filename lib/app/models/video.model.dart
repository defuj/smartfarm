import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class VideoModel {
  @JsonKey(name: 'videoID')
  final String? videoID;
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @JsonKey(name: 'videoName')
  final String? videoName;

  VideoModel({
    this.videoID,
    this.videoUrl,
    this.videoName,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoID: json['videoID'] as String?,
      videoUrl: json['videoUrl'] as String?,
      videoName: json['videoName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoID': videoID,
      'videoUrl': videoUrl,
      'videoName': videoName,
    };
  }
}
