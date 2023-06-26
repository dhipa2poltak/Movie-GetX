
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/app_constants.dart';
import 'package:movie_getx/common/function/common_functions.dart';
import 'package:movie_getx/page/genre/controller/genre_controller.dart';

import '../../common/widget/common_widget.dart';
import '../../framework/router/app_pages.dart';

class GenrePage extends GetView<GenreController> {

  GenrePage({super.key}) {
    controller.onGenrePageInitiated();
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
                  'movie_genres'.tr,
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
                    _buildGenreListView(context, state.genres),
                    buildLoadingIndicator(state.isLoading)
                  ],
                )
            )
          ],
        );
      }),
    );
  }

  Widget _buildGenreListView(BuildContext context, List<GenreEntity> genres) {
    return ListView.builder(
        itemCount: genres.length,
        itemBuilder: (_, index) {
          final genre = genres[index];

          return Card(
            child: ListTile(
              title: Text(genre.name),
              onTap: () {
                Get.toNamed(AppRoutes.MOVIES_BY_GENRE_ROUTE, arguments: {
                  AppConstants.KEY_PARAM_GENRE_ID: genre.id,
                  AppConstants.KEY_PARAM_GENRE_NAME: genre.name
                });
              },
            ),
          );
        }
    );
  }
}
