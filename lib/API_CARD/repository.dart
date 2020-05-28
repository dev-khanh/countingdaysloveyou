import 'dart:async';
import 'model/itemmodel.dart';
import 'movie_api_provider.dart';
class Repository {
  Future<ItemModel> fetchMovieList(String type) => MovieApiProvider().fetchMovieList(type);
}