import 'dart:async';

import 'package:domain/domain.dart';
import 'package:get/get.dart';

import 'movie_trailer_state.dart';

class MovieTrailerController extends GetxController {

  MovieTrailerController(this.getMovieTrailerUseCase);

  final GetMovieTrailerUseCase getMovieTrailerUseCase;

  final rxState = MovieTrailerState().obs;
  MovieTrailerState get state => rxState.value;

  Future<void> onMovieTrailerPageInitiated(int movieId) async {
    rxState.value = state.copyWith(isLoading: true);

    final result = await getMovieTrailerUseCase(movieId);
    result.fold((appError) {
      rxState.value = state.copyWith(errorMessage: appError.message);
      rxState.value = state.copyWith(errorMessage: '');
    }, (trailerDomain) {
      final youtubeEntity = _getYoutubeTrailer(trailerDomain.results);
      if (youtubeEntity != null) {
        rxState.value = state.copyWith(
          id: youtubeEntity.id,
          name: youtubeEntity.name,
          key: youtubeEntity.key,
          movieId: movieId
        );
      }
    });

    rxState.value = state.copyWith(isLoading: false);
  }

  TrailerEntity? _getYoutubeTrailer(List<TrailerEntity> trailerEntities) {
    for (TrailerEntity trailer in trailerEntities) {
      if (trailer.site.toLowerCase().trim() == "youtube") {
        return trailer;
      }
    }

    return null;
  }
}
