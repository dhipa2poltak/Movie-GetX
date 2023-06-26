

import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../repositories/theme_repository.dart';
import 'is_dark_mode_usecase.dart';

class IsDarkModeUseCaseImpl extends IsDarkModeUseCase {

  IsDarkModeUseCaseImpl(this.themeRepository);

  final ThemeRepository themeRepository;

  @override
  Future<Either<AppError, bool>> call() async {
    return themeRepository.isDarkMode();
  }
}
