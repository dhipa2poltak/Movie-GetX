

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_config.dart';
import '../../common/app_constants.dart';
import '../../common/function/common_functions.dart';
import '../../framework/router/app_pages.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    enterFullScreen();

    Future.delayed(const Duration(seconds: AppConstants.DELAY_SPLASH)).then((value) {
      exitFullScreen();

      Get.offNamed(AppRoutes.GENRE_ROUTE);
    });

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Text(
                  AppConfig.appName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 36
                  ),
                ),
              ),
              Expanded(
                child: Image.asset(
                  'assets/icons/ic_launcher.png',
                  width: 200,
                  height: 200,
                )
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const CircularProgressIndicator(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 20),
                child: Text(
                  'loading'.tr,
                  style: const TextStyle(
                    fontSize: 18
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
