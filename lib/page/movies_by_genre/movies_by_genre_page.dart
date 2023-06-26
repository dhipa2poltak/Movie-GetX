

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:movie_getx/common/app_constants.dart';
import 'package:sprintf/sprintf.dart';

import '../../common/function/common_functions.dart';
import '../../common/widget/common_widget.dart';
import '../../framework/router/app_pages.dart';
import 'controller/movies_by_genre_controller.dart';

class MoviesByGenrePage extends GetView<MoviesByGenreController> {

  final int genreId = Get.arguments[AppConstants.KEY_PARAM_GENRE_ID] ?? -1;
  final String genreName = Get.arguments[AppConstants.KEY_PARAM_GENRE_NAME] ?? '';

  MoviesByGenrePage({super.key}) {
    if (genreId > -1) {
      controller.onMoviesByGenrePageInitiated(genreId);
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
        final title = sprintf('title_movies_in_genre'.tr, [genreName]);

        final state = controller.state;

        return Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  title,
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
                    _buildMovieListView(context, state.movies),
                    buildLoadingIndicator(state.isLoading)
                  ],
                )
            )
          ],
        );
      })
    );
  }

  Widget _buildMovieListView(BuildContext context, List<MovieEntity> movies) {
    return LazyLoadScrollView(
      onEndOfPage: () {
        controller.onMoviesByGenrePageLoadMoreData();
      },
      child: ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, index) {
            final movie = movies[index];

            return ListTile(
              title: Card(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: movie.imageUrl.isNotEmpty ? Image.network(
                        movie.imageUrl,
                        width: 100,
                        height: 100,
                      ) : emptyWidget(),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 10),
                            child: Text(
                              movie.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 10, right: 10, bottom: 10),
                            child: Text(
                              movie.overview,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            )
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.toNamed(AppRoutes.MOVIE_DETAILS_ROUTE, arguments: {
                  AppConstants.KEY_PARAM_MOVIE_ID: movie.id,
                });
              },
            );
          }
      )
    );
  }
}
