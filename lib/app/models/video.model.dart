import 'package:json_annotation/json_annotation.dart';
import 'package:smartfarm/repositories.dart';

@JsonSerializable()
class VideoModel {
  @JsonKey(name: 'videoID')
  final String? videoID;
  @JsonKey(name: 'videoUrl')
  final String? videoUrl;
  @JsonKey(name: 'videoName')
  final String? videoName;
  @JsonKey(name: 'videoFormat')
  final VideoFormat? videoFormat;

  VideoModel({
    this.videoID,
    this.videoUrl,
    this.videoName,
    this.videoFormat,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videoID: json['videoID'] as String?,
      videoUrl: json['videoUrl'] as String?,
      videoName: json['videoName'] as String?,
      videoFormat: json['videoFormat'] as VideoFormat?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'videoID': videoID,
      'videoUrl': videoUrl,
      'videoName': videoName,
      'videoFormat': videoFormat,
    };
  }
}
