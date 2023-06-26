import 'dart:async';

import 'package:domain/domain.dart';
import 'package:get/get.dart';

import 'movie_reviews_state.dart';

class MovieReviewsController extends GetxController {

  MovieReviewsController(this.getMovieReviewUseCase);

  final GetMovieReviewUseCase getMovieReviewUseCase;

  final rxState = MovieReviewsState().obs;
  MovieReviewsState get state => rxState.value;

  void onMovieReviewsPageInitiated(int movieId) async {
    await loadData(movieId, state.page + 1);
  }

  void onMovieReviewsPageLoadMoreData() async {
    if (!state.isLoading) {
      await loadData(state.movieId, state.page + 1);
    }
  }

  Future<void> loadData(int movieId, int page) async {
    if (state.isLastPage) return;

    rxState.value = state.copyWith(isLoading: true);

    final result = await getMovieReviewUseCase(movieId, page);
    result.fold((appError) {
      rxState.value = state.copyWith(errorMessage: appError.message);
      rxState.value = state.copyWith(errorMessage: '');
    }, (reviewDomain) {
      final reviews = reviewDomain.results;

      if (reviews.isNotEmpty) {
        final existingReviews = state.reviews;
        final newReviews = <ReviewEntity>[];
        newReviews.addAll(existingReviews);
        newReviews.addAll(reviews);

        rxState.value = state.copyWith(
          movieId: movieId,
          page: page,
          reviews: newReviews
        );
      } else {
        rxState.value = state.copyWith(isLastPage: true);
      }
    });

    rxState.value = state.copyWith(isLoading: false);
  }
}
