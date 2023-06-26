

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_getx/common/app_constants.dart';
import 'package:movie_getx/page/movie_reviews/controller/movie_reviews_controller.dart';

import '../../common/function/common_functions.dart';
import '../../common/widget/common_widget.dart';

class MovieReviewsPage extends GetView<MovieReviewsController> {

  final int movieId = Get.arguments[AppConstants.KEY_PARAM_MOVIE_ID] ?? -1;
  final String movieTitle = Get.arguments[AppConstants.KEY_PARAM_MOVIE_TITLE] ?? '';

  MovieReviewsPage({super.key}) {
    if (movieId > -1) {
      controller.onMovieReviewsPageInitiated(movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    ever(controller.rxState, (state) {
      if (state.errorMessage.isNotEmpty) {
        showSnackBar('error'.tr, state.errorMessage);
      }
    });

    return Scaffold(
      appBar: buildAppBar(),
      body: Obx(() {
        final state = controller.state;

        return Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  'review'.tr,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  movieTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                )
            ),
            const Divider(
              color: Colors.black,
              thickness: 1,
            ),
            Expanded(
                child: Stack(
                  children: <Widget>[
                    _buildNoReviewViewOrEmptyWidget(context, state.reviews.isEmpty && !state.isLoading),
                    _buildMovieListView(context, state.reviews),
                    buildLoadingIndicator(state.isLoading)
                  ],
                )
            )
          ],
        );
      })
    );
  }

  Widget _buildNoReviewViewOrEmptyWidget(BuildContext context, bool isNoReview) {
    if (isNoReview) {
      return Center(
        child: Text('no_review_available'.tr)
      );
    } else {
      return emptyWidget();
    }
  }

  Widget _buildMovieListView(BuildContext context, List<ReviewEntity> reviews) {
    return LazyLoadScrollView(
        onEndOfPage: () {
          controller.onMovieReviewsPageLoadMoreData();
        },
        child: ListView.builder(
            itemCount: reviews.length,
            itemBuilder: (_, index) {
              final review = reviews[index];
              var avatarPath = review.authorDetails?.avatarPath ?? '';

              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        review.content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 8,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: avatarPath.isNotEmpty ? Image.network(
                        avatarPath,
                        width: 50,
                        height: 50,
                      ) : const Icon(Icons.cancel),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Text(review.author,),
                    )
                  ],
                ),
              );
            }
        )
    );
  }
}
