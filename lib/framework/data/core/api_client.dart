

import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

import '../../../app_config.dart';
import 'auth_interceptor.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: '')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  static ApiClient create(PrettyDioLogger loggger, AuthInterceptor authInterceptor) {
    final dio = Dio();

    if (AppConfig.appFlavor == Flavor.Dev) {
      dio.interceptors.add(loggger);
    }
    dio.interceptors.add(authInterceptor);

    return ApiClient(dio, baseUrl: AppConfig.baseUrl);
  }

  @GET('3/genre/movie/list')
  Future<GenreResponse> getMovieGenre();

  @GET("3/discover/movie")
  Future<DiscoverMovieByGenreResponse> getMoviesByGenre(
    @Query("with_genres") String genreId,
    @Query("page") int page
  );

  @GET("3/movie/{movie_id}")
  Future<MovieDetailsResponse> getMovieDetail(
    @Path("movie_id") int movieId
  );

  @GET("3/movie/{movie_id}/reviews")
  Future<ReviewResponse> getMovieReviews(
    @Path("movie_id") int movieId,
    @Query("page") int page,
    @Query("language") @Default('"en-US"') String language
  );

  @GET("3/movie/{movie_id}/videos")
  Future<TrailerResponse> getMovieTrailers(
    @Path("movie_id") int movieId,
    @Query("language") @Default('en-US') String language
  );
}
