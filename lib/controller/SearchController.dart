
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moviego/model/MovieModel.dart';
import 'package:moviego/utils/api.dart';

class MovieSearchController extends GetxController{

  final ScrollController searchController = ScrollController();
  int _page = 1;

  bool _loading = false;
  bool get isLoading => _loading;
  void setLoading(bool loading){
    _loading=loading;
    update();
  }

  List<MovieModel> _movieList = [];
  List<MovieModel> get searchList => _movieList;

  void searchMovie(String query)async{
    setLoading(true);
    final data = await API().searchMovie(query, _page);
    List<MovieModel> searchMovies = (data['results'] as List)
    .map((e)=>MovieModel.fromJson(e as Map<String,dynamic>)).toList();
    _movieList=searchMovies;
    setLoading(false);
  }

  void loadMore(String query)async{
    _page++;
    final data = await API().searchMovie(query, _page);
    List<MovieModel> searchMovies = (data['results'] as List)
        .map((e)=>MovieModel.fromJson(e as Map<String,dynamic>)).toList();
    if(searchMovies.isNotEmpty){
      _movieList.addAll(searchMovies);
    }
    print(_page);
    update();
  }

}