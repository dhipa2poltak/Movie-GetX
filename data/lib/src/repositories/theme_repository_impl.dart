

import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';

import '../data_sources/prefs_data_source.dart';

class ThemeRepositoryImpl extends ThemeRepository {

  ThemeRepositoryImpl(this.prefsDataSource);

  PrefsDataSource prefsDataSource;

  @override
  Future<Either<AppError, bool>> isDarkMode() async {
    return Right(prefsDataSource.isDarkMode());
  }

  @override
  Future<Either<AppError, bool>> setDarkMode(bool isDarkMode) async {
    return Right(prefsDataSource.setDarkMode(isDarkMode));
  }
}
