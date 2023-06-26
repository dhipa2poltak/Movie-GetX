
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/theme/controller/theme_controller.dart';

import 'common/theme/app_themes.dart';
import 'common/theme/controller/theme_state.dart';
import 'framework/router/app_pages.dart';
import 'framework/translations/app_translations.dart';

class MyApp extends GetView<ThemeController> {

  MyApp({super.key}) {
    controller.onThemeInitiated();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
        return _buildWithTheme(context, controller.state);
      }
    );
  }

  Widget _buildWithTheme(BuildContext context, ThemeState state) {
    return GetMaterialApp(
      title: 'Tmdb GetX',
      theme: appThemeData[state.isDarkMode ? AppTheme.Dark : AppTheme.Light],
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: AppPages.INITIAL_ROUTE,
      getPages: AppPages.getPages,
      /*
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      */
    );
  }
}
