

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/app_constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../common/function/common_functions.dart';
import '../../common/widget/common_widget.dart';
import 'controller/movie_trailer_controller.dart';
import 'controller/movie_trailer_state.dart';

class MovieTrailerPage extends GetView<MovieTrailerController> {

  final int movieId = Get.arguments[AppConstants.KEY_PARAM_MOVIE_ID] ?? -1;

  MovieTrailerPage({super.key}) {
    if (movieId > -1) {
      controller.onMovieTrailerPageInitiated(movieId);
    }
  }

  @override
  Widget build(BuildContext context) {
    ever(controller.rxState, (state) {
      if (state.errorMessage.isNotEmpty) {
        showSnackBar('error'.tr, state.errorMessage);
      }
    });

    return Obx(() {
      final state = controller.state;

      return Stack(
        children: <Widget>[
          _buildMainView(context, state),
          buildLoadingIndicator(state.isLoading)
        ],
      );
    });
  }

  Widget _buildMainView(BuildContext context, MovieTrailerState state) {
    if (state.key.isEmpty) return emptyWidget();

    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: state.key,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );

    return Scaffold(
        appBar: buildAppBar(),
        body: YoutubePlayerBuilder(
            onExitFullScreen: () {
              exitFullScreen();
            },
            player: YoutubePlayer(
              controller: controller,
              showVideoProgressIndicator: true,
              bottomActions: [
                CurrentPosition(),
                ProgressBar(isExpanded: true),

              ],
            ),
            builder: (context, player) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black,
                  ),
                  Center(
                      child: player
                  )
                ],
              );
            }
        )
    );
  }
}
