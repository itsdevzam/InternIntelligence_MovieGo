import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:moviego/screens/BottomNavBar.dart';
import 'package:moviego/screens/HomeScreen.dart';
import 'package:moviego/screens/MovieDetailScreen.dart';
import 'package:moviego/screens/SplashScreen.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/utils/utils.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/home', page: () => HomeScreen(),transition: Transition.fadeIn),
      ],
      title: utils.AppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: colors.primary),
        scaffoldBackgroundColor: colors.primary,
        useMaterial3: true,
      ),
      home: const BottomNavBar(),
    );
  }
}

