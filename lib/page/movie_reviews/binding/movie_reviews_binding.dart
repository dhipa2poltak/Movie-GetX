

import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:movie_getx/page/movie_reviews/controller/movie_reviews_controller.dart';


class MovieReviewsBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetMovieReviewUseCase>(() => GetMovieReviewUseCaseImpl(Get.find()));
    Get.lazyPut<MovieReviewsController>(() => MovieReviewsController(Get.find()));
  }
}
