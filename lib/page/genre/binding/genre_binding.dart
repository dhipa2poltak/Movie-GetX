

import 'package:domain/domain.dart';
import 'package:get/get.dart';

import '../controller/genre_controller.dart';

class GenreBinding extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut<GetMovieGenreUseCase>(() => GetMovieGenreUseCaseImpl(Get.find()));
    Get.lazyPut<GenreController>(() => GenreController(Get.find()));
  }
}
