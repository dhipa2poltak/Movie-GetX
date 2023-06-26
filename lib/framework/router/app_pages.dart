import 'package:get/get.dart';
import 'package:movie_getx/page/genre/genre_page.dart';
import 'package:movie_getx/page/movie_details/movie_details_page.dart';
import 'package:movie_getx/page/movie_reviews/movie_reviews_page.dart';
import 'package:movie_getx/page/movie_trailer/movie_trailer_page.dart';
import 'package:movie_getx/page/movies_by_genre/movies_by_genre_page.dart';
import 'package:movie_getx/page/splash/splash_page.dart';

import '../../page/genre/binding/genre_binding.dart';
import '../../page/movie_details/binding/movie_details_binding.dart';
import '../../page/movie_reviews/binding/movie_reviews_binding.dart';
import '../../page/movie_trailer/binding/movie_trailer_binding.dart';
import '../../page/movies_by_genre/binding/movies_by_genre_binding.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL_ROUTE = AppRoutes.SPLASH_ROUTE;

  static final getPages = [
    GetPage(
      name: AppRoutes.SPLASH_ROUTE,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.GENRE_ROUTE,
      page: () => GenrePage(),
      binding: GenreBinding()
    ),
    GetPage(
      name: AppRoutes.MOVIES_BY_GENRE_ROUTE,
      page: () => MoviesByGenrePage(),
      binding: MoviesByGenreBinding()
    ),
    GetPage(
      name: AppRoutes.MOVIE_DETAILS_ROUTE,
      page: () => MovieDetailsPage(),
      binding: MovieDetailsBinding()
    ),
    GetPage(
      name: AppRoutes.MOVIE_REVIEWS_ROUTE,
      page: () => MovieReviewsPage(),
      binding: MovieReviewsBinding()
    ),
    GetPage(
      name: AppRoutes.MOVIE_TRAILER_ROUTE,
      page: () => MovieTrailerPage(),
      binding: MovieTrailerBinding()
    )
  ];
}
