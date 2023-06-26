

import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:movie_getx/page/movie_trailer/controller/movie_trailer_controller.dart';


class MovieTrailerBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetMovieTrailerUseCase>(() => GetMovieTrailerUseCaseImpl(Get.find()));
    Get.lazyPut<MovieTrailerController>(() => MovieTrailerController(Get.find()));
  }
}
