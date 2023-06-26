

import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:movie_getx/page/movie_details/controller/movie_details_controller.dart';


class MovieDetailsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetMovieDetailsUseCase>(() => GetMovieDetailsUseCaseImpl(Get.find()));
    Get.lazyPut<MovieDetailsController>(() => MovieDetailsController(Get.find()));
  }
}
