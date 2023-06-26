import 'dart:async';

import 'package:domain/domain.dart';
import 'package:get/get.dart';

import 'movie_details_state.dart';

class MovieDetailsController extends GetxController {

  MovieDetailsController(this.getMovieDetailsUseCase);

  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  final rxState = MovieDetailsState().obs;
  MovieDetailsState get state => rxState.value;

  Future<void> onMovieDetailsPageInitiated(int movieId) async {
    rxState.value = state.copyWith(isLoading: true);

    final result = await getMovieDetailsUseCase(movieId);
    result.fold((appError) {
      rxState.value = state.copyWith(errorMessage: appError.message);
      rxState.value = state.copyWith(errorMessage: '');
    }, (movieDetailsDomain) {
      rxState.value = state.copyWith(
        movieId: movieId,
        title: movieDetailsDomain.title,
        description: movieDetailsDomain.overview
      );

      if (movieDetailsDomain.imageUrl.isNotEmpty) {
        rxState.value = state.copyWith(imageUrl: movieDetailsDomain.imageUrl);
      }
    });

    rxState.value = state.copyWith(isLoading: false);
  }
}
