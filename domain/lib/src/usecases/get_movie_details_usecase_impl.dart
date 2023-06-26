
import 'package:dartz/dartz.dart';

import '../entities/app_error.dart';
import '../entities/movie_details_domain.dart';
import '../repositories/app_repository.dart';
import 'get_movie_details_usecase.dart';

class GetMovieDetailsUseCaseImpl extends GetMovieDetailsUseCase {

  GetMovieDetailsUseCaseImpl(this.appRepository);

  final AppRepository appRepository;

  @override
  Future<Either<AppError, MovieDetailsDomain>> call(int movieId) async {
    return appRepository.getMovieDetail(movieId);
  }
}
