import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviego/controller/HomeController.dart';
import 'package:moviego/screens/CategoryScreen.dart';
import 'package:moviego/screens/MovieDetailScreen.dart';
import 'package:moviego/utils/api.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/widgets/customText.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final HomeController homeController = Get.put(HomeController());

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Slider
            Slider(),

            ///Categories
            // Categories(),

            ///Popular Movies
            PopularMovies(),

            ///Latest Movies
            LatestMovies(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.fetchSliderList();
    homeController.fetchPopular();
    homeController.fetchLatest();
  }
}

class Slider extends StatelessWidget {
  const Slider({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return controller.isLoading
            ? Container(
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : SizedBox(
                width: double.infinity,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PageView.builder(
                      controller: homeController.pageController,
                      itemCount: homeController.sliderList.length,
                      onPageChanged: (index) {
                        homeController.onPageChange(index);
                      },
                      itemBuilder: (context, itemIndex) {
                        return Image.network(controller.sliderList[itemIndex],
                            fit: BoxFit.fill);
                      },
                    ),
                    Positioned(
                      bottom: 20,
                      child: controller.isLoading
                          ? SizedBox()
                          : AnimatedSmoothIndicator(
                              activeIndex: homeController.getPageIndex,
                              count: controller.sliderList.length,
                              effect: ExpandingDotsEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: colors.red,
                                dotColor: Colors.grey,
                              ),
                            ),
                    )
                  ],
                ),
              );
      },
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: customText(
            text: "Categories",
            color: Colors.white,
            size: 20,
            isbold: true,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        GetBuilder<HomeController>(
          builder: (controller) => SizedBox(
            height: 35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: API.MovieTypes.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.setCatIndex(index);
                    Get.to(
                        () => CategoryScreen(
                              title: API.MovieTypes[index],
                              type: API.MovieGenre[index],
                            ),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        color: controller.getCatIndex == index
                            ? colors.red
                            : colors.secondary,
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    width: 100,
                    child: customText(
                        text: API.MovieTypes[index],
                        color: Colors.white,
                        size: 15),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class PopularMovies extends StatelessWidget {
  const PopularMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: customText(
                text: "Most Popular",
                color: Colors.white,
                size: 20,
                isbold: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(
                        () => CategoryScreen(
                              title: "Most Popular",
                              type: "popular",
                            ),
                        transition: Transition.rightToLeft);
                  },
                  child: customText(
                    text: "See All",
                    color: Colors.white,
                    size: 13,
                    isbold: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GetBuilder<HomeController>(
          builder: (controller) => controller.isLoading
              ? Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: controller.popularList.isNotEmpty?6:controller.popularList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => MovieDetailScreen(
                                        currentIndex:
                                            controller.popularList[index],
                                      ),
                                  transition: Transition.rightToLeft);
                            },
                            child: FadeInImage.assetNetwork(
                              placeholder: '',
                              image: controller.popularList[index].posterPath,
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) =>
                                      Shimmer.fromColors(
                                          baseColor: colors.primary,
                                          highlightColor: colors.secondary,
                                          child: SizedBox(
                                            height: 200,
                                            width: 130,
                                            child: Container(
                                              color: colors.primary,
                                            ),
                                          )),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }
}

class LatestMovies extends StatelessWidget {
  const LatestMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: customText(
                text: "Latest Movies",
                color: Colors.white,
                size: 20,
                isbold: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    Get.to(
                        () => CategoryScreen(
                              title: "Latest Movies",
                              type: "upcoming",
                            ),
                        transition: Transition.rightToLeft);
                  },
                  child: customText(
                    text: "See All",
                    color: Colors.white,
                    size: 13,
                    isbold: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        GetBuilder<HomeController>(
          builder: (controller) => controller.isLoading
              ? Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : SizedBox(
                  height: 200,
                  child: ListView.builder(
                    itemCount: controller.latestList.isNotEmpty?6:controller.latestList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                  () => MovieDetailScreen(
                                        currentIndex:
                                            controller.latestList[index],
                                      ),
                                  transition: Transition.rightToLeft);
                            },
                            child: FadeInImage.assetNetwork(
                              placeholder: '',
                              image: controller.latestList[index].posterPath,
                              placeholderErrorBuilder:
                                  (context, error, stackTrace) =>
                                      Shimmer.fromColors(
                                baseColor: colors.primary,
                                highlightColor: colors.secondary,
                                child: SizedBox(
                                  height: 200,
                                  width: 130,
                                  child: Container(
                                    color: colors.primary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
