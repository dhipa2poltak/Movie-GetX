
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:movie_getx/common/theme/controller/theme_controller.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/core/api_client.dart';
import '../data/core/auth_interceptor.dart';
import '../data/data_sources/prefs_data_source_impl.dart';
import '../data/data_sources/remote_app_data_source_impl.dart';

Future<void> configureDependencies() async {
  Get.lazyPut<PrettyDioLogger>(() => PrettyDioLogger());
  Get.lazyPut<AuthInterceptor>(() => AuthInterceptor());
  Get.lazyPut<ApiClient>(() => ApiClient.create(Get.find(), Get.find()));
  Get.lazyPut<GetStorage>(() => GetStorage());
  Get.lazyPut<PrefsDataSource>(() => PrefsDataSourceImpl(Get.find()));
  Get.lazyPut<AppDataSource>(() => RemoteAppDataSourceImpl(Get.find()));
  Get.lazyPut<AppRepository>(() => AppRepositoryImpl(Get.find()));
  Get.lazyPut<ThemeRepository>(() => ThemeRepositoryImpl(Get.find()));

  Get.lazyPut<IsDarkModeUseCase>(() => IsDarkModeUseCaseImpl(Get.find()));
  Get.lazyPut<SetDarkModeUseCase>(() => SetDarkModeUseCaseImpl(Get.find()));
  Get.lazyPut<ThemeController>(() => ThemeController(Get.find(), Get.find()));
}
