
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/theme/controller/theme_controller.dart';

import '../../app_config.dart';

AppBar buildAppBar() {
  return AppBar(
    title: Text(AppConfig.appName),
    actions: <Widget>[
      GetX<ThemeController>(
        builder: (themeController) {
          return Container(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(
                      themeController.state.isDarkMode ? 'light_mode'.tr : 'dark_mode'.tr,
                      style: const TextStyle(
                        color: Colors.white
                      ),
                    ),
                    onPressed: () {
                      themeController.onThemeChanged();
                    },
                  )
                ],
              )
          );
        },
      )
    ],
  );
}

Widget emptyWidget() {
  return const SizedBox.shrink();
}

Widget buildLoadingIndicator(bool isLoading) {
  if (isLoading) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  } else {
    return emptyWidget();
  }
}
