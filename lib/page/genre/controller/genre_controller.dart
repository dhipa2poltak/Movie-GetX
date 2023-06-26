
import 'package:domain/domain.dart';
import 'package:get/get.dart';

import 'genre_state.dart';

class GenreController extends GetxController {

  GenreController(this.getMovieGenreUseCase);

  final GetMovieGenreUseCase getMovieGenreUseCase;

  final rxState = GenreState().obs;
  GenreState get state => rxState.value;

  void onGenrePageInitiated() async {
    rxState.value = state.copyWith(isLoading: true);

    final result = await getMovieGenreUseCase();
    result.fold((appError) {
      rxState.value = state.copyWith(errorMessage: appError.message);
      rxState.value = state.copyWith(errorMessage: '');
    }, (genreDomain) {
      if (genreDomain.genres.isNotEmpty) {
        final genres = genreDomain.genres;
        rxState.value = state.copyWith(genres: genres);
      }
    });

    rxState.value = state.copyWith(isLoading: false);
  }
}
