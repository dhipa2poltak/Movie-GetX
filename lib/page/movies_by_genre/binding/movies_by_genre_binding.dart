

import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:movie_getx/page/movies_by_genre/controller/movies_by_genre_controller.dart';

class MoviesByGenreBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetMovieByGenreUseCase>(() => GetMovieByGenreUseCaseImpl(Get.find()));
    Get.lazyPut<MoviesByGenreController>(() => MoviesByGenreController(Get.find()));
  }
}
