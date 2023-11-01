import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:search/data/datasources/search_remote_data_source.dart';
import 'package:search/domain/repositories/search_repository.dart';

@GenerateMocks([
  SearchRepository,
  SearchRemoteDataSource,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
