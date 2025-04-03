import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moviego/screens/CategoriesScreen.dart';
import 'package:moviego/screens/HomeScreen.dart';
import 'package:moviego/screens/ProfileScreen.dart';
import 'package:moviego/screens/SearchScreen.dart';
import 'package:moviego/utils/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex=0;
  final List<Widget> screens = [
    HomeScreen(),
    CategoriesScreen(),
    SearchScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 70,
        child: Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
              selectedItemColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              elevation: 0,
              backgroundColor: colors.secondary,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),
              unselectedItemColor: Colors.grey.shade600,
              selectedIconTheme: IconThemeData(color: Colors.white),
              currentIndex: currentIndex,
              onTap: (index){
                setState(() {
                  currentIndex=index;
                });
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Iconsax.home),label: "Home"),
                BottomNavigationBarItem(icon: Icon(Iconsax.save_2),label: "Categories"),
                BottomNavigationBarItem(icon: Icon(Iconsax.search_normal),label: "Search"),
                BottomNavigationBarItem(icon: Icon(Iconsax.profile_circle),label: "Me"),
              ]
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
    );
  }
}
