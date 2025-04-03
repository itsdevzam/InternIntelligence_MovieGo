
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:moviego/model/MovieModel.dart';
import 'package:moviego/utils/api.dart';

class HomeController extends GetxController{
  List<String> _sliderList = [];
  List<String> get sliderList => _sliderList;
  int pageIndex = 0;
  int get getPageIndex => pageIndex;
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  List<MovieModel> _popularList = [];
  List<MovieModel> get popularList => _popularList;
  List<MovieModel> _latestList = [];
  List<MovieModel> get latestList => _latestList;


  int catIndex = 0;
  int get getCatIndex => catIndex;
  void setCatIndex(int index){
    catIndex=index;
    update();
  }

  bool _loading = true;
  bool get isLoading => _loading;
  void setLoading(bool loading){
    _loading=loading;
    update();
  }

  Future<void> fetchSliderList()async{
    setLoading(true);
    final data = await API().fetchMovieList("popular",1);
    List<String> sliderImg = (data['results'] as List).take(5).map((e){
      return "https://image.tmdb.org/t/p/original${e['backdrop_path']}";
    }).toList();
    _sliderList=sliderImg;
    autoScroll();
    setLoading(false);
  }

  Future<void> fetchPopular()async{
    setLoading(true);
    final data = await API().fetchMovieList("popular",1);
    List<MovieModel> movieList = (data['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    _popularList=movieList;
    setLoading(false);
  }

  Future<void> fetchLatest()async{
    setLoading(true);
    final data = await API().fetchMovieList("upcoming",1);
    List<MovieModel> movieList = (data['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    _latestList=movieList;
    setLoading(false);
  }

  void onPageChange(int index){
    setLoading(true);
    pageIndex=index;
    setLoading(false);
  }

  void autoScroll(){
    Timer.periodic(Duration(seconds: 5),(timer) {
      if (_sliderList.isNotEmpty) {
        if (pageIndex < _sliderList.length - 1) {
          pageIndex++;
        } else {
          pageIndex = 0;
        }
        _pageController.animateToPage(
          pageIndex,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        update();
      }
    },);
  }
}