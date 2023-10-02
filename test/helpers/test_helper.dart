import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:tmdb/data/datasources/movie_remote_data_surce.dart';
import 'package:tmdb/data/datasources/tv_remote_data_source.dart';
import 'package:tmdb/domain/repositories/movie_repository.dart';
import 'package:tmdb/domain/repositories/tv_repository.dart';

@GenerateMocks([
  MovieRepository,
  TvRepository,
  MovieRemoteDataSource,
  TvRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
