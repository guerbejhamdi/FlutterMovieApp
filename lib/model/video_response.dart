import 'package:movie_streaming/model/video.dart';

class VideoResponse{

  final List<Video> videos;
  final String error;

  VideoResponse(this.videos,this.error);

  VideoResponse.fromJson(Map<String,dynamic> json)
  : videos = (json["results"] as List).map((e) => new Video.fromJson(e)).toList(),
   error =  "";

   VideoResponse.withError(String errorValue):
   videos = List<Video>.empty(growable: true),
   error = errorValue;
}