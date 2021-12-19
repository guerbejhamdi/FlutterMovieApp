import 'package:movie_streaming/bloc/movie_detail.dart';
import 'package:movie_streaming/model/movie.dart';

class MovieDetailResponse{
  final MovieDetail movieDetail;
  final String error;

  MovieDetailResponse(this.movieDetail,this.error);

  MovieDetailResponse.fromJson(Map<String,dynamic> json)
  : movieDetail = MovieDetail.fromJson(json),
    error = "";

  MovieDetailResponse.withError(String errorValue)
  : movieDetail = MovieDetail(null, null, null, null, "", null),
  error = errorValue;
}