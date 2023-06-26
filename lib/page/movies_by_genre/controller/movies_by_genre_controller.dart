import 'dart:async';

import 'package:domain/domain.dart';
import 'package:get/get.dart';

import 'movies_by_genre_state.dart';

class MoviesByGenreController extends GetxController {

  MoviesByGenreController(this.getMovieByGenreUseCase);

  final GetMovieByGenreUseCase getMovieByGenreUseCase;

  final rxState = MoviesByGenreState().obs;
  MoviesByGenreState get state => rxState.value;

  void onMoviesByGenrePageInitiated(int genreId) async {
    await _loadData(genreId, state.page + 1);
  }

  void onMoviesByGenrePageLoadMoreData() async {
    if (!state.isLoading) {
      await _loadData(state.genreId, state.page + 1);
    }
  }

  Future<void> _loadData(int genreId, int page) async {
    if (state.isLastPage) return;

    rxState.value = state.copyWith(isLoading: true);

    final result = await getMovieByGenreUseCase('$genreId', page);
    result.fold((appError) {
      rxState.value = state.copyWith(errorMessage: appError.message);
      rxState.value = state.copyWith(errorMessage: '');
    }, (movieByGenreDomain) {
        final movies = movieByGenreDomain.results;

        if (movies.isNotEmpty) {
          final existingMovies = state.movies;
          final newMovies = <MovieEntity>[];
          newMovies.addAll(existingMovies);
          newMovies.addAll(movies);

          rxState.value = state.copyWith(
            genreId: genreId,
            page: page,
            movies: newMovies
          );
        } else {
          rxState.value = state.copyWith(isLastPage: true);
        }
    });

    rxState.value = state.copyWith(isLoading: false);
  }
}
