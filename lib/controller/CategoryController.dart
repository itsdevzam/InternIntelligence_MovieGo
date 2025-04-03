
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviego/model/MovieModel.dart';
import 'package:moviego/utils/api.dart';

class CategoryController extends GetxController{
  List<MovieModel> _movieList = [];
  List<MovieModel> get movieList => _movieList;
  int _page = 1;
  final ScrollController scrollController = ScrollController();

  bool _loading = true;
  bool get isLoading => _loading;
  void setLoading(bool loading){
    _loading=loading;
    update();
  }

  Future<void> fetchList(String type)async{
    setLoading(true);
    final data = await API().fetchMovieList(type,_page);
    List<MovieModel> movieList = (data['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    _movieList=movieList;
    setLoading(false);
  }

  Future<void> loadMore(String type) async {
    _page++; // Increase page
    // print("Page is $_page");
    final data = await API().fetchMovieList(type, _page);
    List<MovieModel> newMovies = (data['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();

    if (newMovies.isNotEmpty) {
      _movieList.addAll(newMovies); // Add new movies to the list
    } else {
      // _isMoreAvailable = false; // No more data
    }
    update();
  }

}