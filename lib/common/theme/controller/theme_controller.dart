
import 'package:domain/domain.dart';
import 'package:get/get.dart';
import 'package:movie_getx/common/theme/controller/theme_state.dart';

class ThemeController extends GetxController {

  ThemeController(this.isDarkModeUseCase, this.setDarkModeUseCase);

  final IsDarkModeUseCase isDarkModeUseCase;
  final SetDarkModeUseCase setDarkModeUseCase;

  final _state = ThemeState().obs;
  ThemeState get state => _state.value;

  void onThemeInitiated() async {
    final result = await isDarkModeUseCase();
    result.fold((appError) {
      //--ignore
    }, (isDarkMode) {
      _state.value = state.copyWith(isDarkMode: isDarkMode);
    });
  }

  void onThemeChanged() async {
    final isDarkMode = !state.isDarkMode;
    final result = await setDarkModeUseCase(isDarkMode);
    result.fold((appError) {
      //--ignore
    }, (isDarkMode) {
      _state.value = state.copyWith(isDarkMode: isDarkMode);
    });
  }
}
