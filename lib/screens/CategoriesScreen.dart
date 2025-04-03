import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:moviego/screens/CategoryScreen.dart';
import 'package:moviego/utils/api.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/widgets/BlurText.dart';
import 'package:moviego/widgets/customText.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: customText(
              text: "Categories",
              size: 22,
              isbold: true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1 /.5
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                              () => CategoryScreen(
                            title: API.MovieTypes[index],
                            type: API.MovieGenre[index],
                          ),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: API.MovieGenreColors[index],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Blurtext(
                            custom_text: customText(
                          text: API.MovieTypes[index],
                          color: Colors.white,
                          size: 20,
                          isbold: true,
                        )),
                      ),
                    ),
                  );
                },
                itemCount: API.MovieTypes.length,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
