import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class API{

  static const String apiKey = "";

  Map<String, int> genreMap = {
    "action": 28,
    "adventure": 12,
    "animation": 16,
    "comedy": 35,
    "crime": 80,
    "documentary": 99,
    "drama": 18,
    "family": 10751,
    "fantasy": 14,
    "history": 36,
    "horror": 27,
    "music": 10402,
    "mystery": 9648,
    "romance": 10749,
    "science fiction": 878,
    "tv movie": 10770,
    "thriller": 53,
    "war": 10752,
    "western": 37
  };

  Future<Map<String,dynamic>> fetchMovieList(String type,int page)async{
    final http.Response response;
    if(type=="upcoming"||type=="popular"||type=="latest"){
       response = await http.get(Uri.parse("https://api.themoviedb.org/3/movie/$type?api_key=$apiKey&page=$page"));
    }else{
      int? genreId = genreMap[type.toLowerCase()];
       response = await http.get(Uri.parse("https://api.themoviedb.org/3/discover/movie?api_key=$apiKey&with_genres=$genreId&page=$page"));
    }
    final data = json.decode(response.body);
    return data as Map<String,dynamic>;
  }

  Future<Map<String,dynamic>> searchMovie(String query,int page)async{
    final http.Response response = await http.get(Uri.parse("https://api.themoviedb.org/3/search/movie?query=$query&api_key=$apiKey&page=$page"));
    final data = json.decode(response.body);
    return data as Map<String,dynamic>;
  }


  static const List<String> MovieTypes = [
    "Action",
    "Adventure",
    "Animation",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Music",
    "Mystery",
    "Romance",
    "Science Fiction",
    "TV Movie",
    "Thriller",
    "War",
  ];

  static List<Color> MovieGenreColors = [
    Colors.red,            // Action
    Colors.deepOrange,     // Adventure
    Colors.purple,         // Animation
    Colors.amber[800]!,    // Comedy
    Colors.blueGrey[900]!, // Crime
    Colors.blue[900]!,     // Documentary
    Colors.deepPurple,     // Drama
    Colors.teal[900]!,     // Family
    Colors.indigo[900]!,   // Fantasy
    Colors.brown[800]!,    // History
    Colors.green[900]!,    // Horror
    Colors.green[800]!,    // Music
    Colors.blue[800]!,     // Mystery
    Colors.pink[800]!,     // Romance
    Colors.cyan[900]!,     // Science Fiction
    Colors.purple[900]!,   // TV Movie
    Colors.deepOrange[900]!, // Thriller
    Colors.grey[900]!,     // War
    Colors.black87,        // Western
  ];


  static const List<String> MovieGenre = [
    "action",
    "adventure",
    "animation",
    "comedy",
    "crime",
    "documentary",
    "drama",
    "family",
    "fantasy",
    "history",
    "horror",
    "music",
    "mystery",
    "romance",
    "science fiction",
    "tv movie",
    "thriller",
    "war",
  ];



}