
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/app_constants.dart';

import '../../common/function/common_functions.dart';
import '../../common/widget/common_widget.dart';
import '../../framework/router/app_pages.dart';
import 'controller/movie_details_controller.dart';
import 'controller/movie_details_state.dart';

class MovieDetailsPage extends GetView<MovieDetailsController> {

  final int movieId = Get.arguments[AppConstants.KEY_PARAM_MOVIE_ID] ?? -1;

  MovieDetailsPage({super.key}) {
    if (movieId > -1) {
      controller.onMovieDetailsPageInitiated(movieId);
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

        return Stack(
          children: <Widget>[
            _buildMainView(context, state),
            buildLoadingIndicator(state.isLoading)
          ],
        );
      })
    );
  }

  Widget _buildMainView(BuildContext context, MovieDetailsState state) {
    return SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 10),
                child: Text(
                  state.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: state.imageUrl.isNotEmpty ? Image.network(
                  state.imageUrl,
                  width: 200,
                  height: 200,
                ) : emptyWidget(),
              ),
              Container(
                margin: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
                child: Text(state.description),
              ),
              TextButton(
                child: Text('show_review'.tr),
                onPressed: () {
                  Get.toNamed(AppRoutes.MOVIE_REVIEWS_ROUTE, arguments: {
                    AppConstants.KEY_PARAM_MOVIE_ID: movieId,
                    AppConstants.KEY_PARAM_MOVIE_TITLE: state.title
                  });
                },
              ),
              TextButton(
                child: Text('show_trailer'.tr),
                onPressed: () {
                  Get.toNamed(AppRoutes.MOVIE_TRAILER_ROUTE, arguments: {
                    AppConstants.KEY_PARAM_MOVIE_ID: movieId,
                  });
                },
              )
            ],
          ),
        )
    );
  }
}
