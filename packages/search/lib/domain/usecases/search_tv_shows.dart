import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:search/domain/repositories/search_repository.dart';
import 'package:tv/domain/entities/tv.dart';

class SearchTvShows {
  final SearchRepository repository;

  SearchTvShows(this.repository);

  Future<Either<Failure, List<Tv>>> execute(String query) {
    return repository.searchTvShows(query);
  }
}
