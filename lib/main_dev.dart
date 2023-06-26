import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'app_config.dart';
import 'framework/dependencies/app_dependencies.dart';
import 'my_app.dart';

void main() async {
  AppConfig.appFlavor = Flavor.Dev;
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await configureDependencies();
  runApp(MyApp());
}
