
import 'package:get/get.dart';
import 'package:moviego/model/MovieModel.dart';
import 'package:moviego/utils/api.dart';

class MovieDetailController extends GetxController{
  bool _isloading = false;
  bool get isLoading => _isloading;
  List<MovieModel> _recommendedList = [];
  List<MovieModel> get recommendedList => _recommendedList;

  void _setLoading(bool value){
    _isloading = value;
    update();
  }

  Future<void> fetchRecommended()async{
    _setLoading(true);
    final data = await API().fetchMovieList("upcoming",1);
    List<MovieModel> movieList = (data['results'] as List)
        .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
        .toList();
    _recommendedList=movieList;
    _setLoading(false);
  }
}