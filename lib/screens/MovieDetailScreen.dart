import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moviego/controller/MovieDetailController.dart';
import 'package:moviego/controller/SearchController.dart';
import 'package:moviego/model/MovieModel.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/utils/utils.dart';
import 'package:moviego/widgets/BlurText.dart';
import 'package:moviego/widgets/customText.dart';
import 'package:shimmer/shimmer.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

class MovieDetailScreen extends StatefulWidget {
  MovieModel currentIndex;

  MovieDetailScreen({super.key, required this.currentIndex});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  final movieDetailController = Get.put(MovieDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Image
            Stack(
              children: [
                widget.currentIndex.backdropPath.isNotEmpty?
                FadeInImage.assetNetwork(
                  placeholder: "",
                  image: widget.currentIndex.backdropPath,
                  fit: BoxFit.fill,
                  height: 300,
                  placeholderErrorBuilder: (context, error, stackTrace) {
                    return Shimmer.fromColors(
                      baseColor: colors.primary,
                      highlightColor: colors.secondary,
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                    );
                  },
                ):
                Container(
                  height: 300,
                  width: 300,
                  color: Colors.white,
                ),
                Positioned(
                  top: 40,
                  child: SizedBox(
                    width: utils.getDeviceWidth(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.withAlpha(128),
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Iconsax.arrow_left_24,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.withAlpha(128),
                            child: GestureDetector(
                              onTap: () {
                              },
                              child: Icon(
                                Iconsax.save_2,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.grey.withAlpha(128),
                            child: GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.share_outlined,
                                size: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          colors.primary.withAlpha(0),
                          colors.primary,
                        ],
                      ),
                    ),
                    height: 50,
                    width: utils.getDeviceWidth(context),
                  ),
                ),
              ],
            ),

            ///title
            Blurtext(
              custom_text: customText(
                text: widget.currentIndex.title,
                size: 30,
                isbold: true,
                iscenter: true,
              ),
            ),

            ///Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Blurtext(
                custom_text: customText(
                  text: "Description: ${widget.currentIndex.overview}",
                  size: 15,
                  isbold: true,
                ),
              ),
            ),

            SizedBox(
              height: 10,
            ),

            ///desc box
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white.withAlpha(15),
                  borderRadius: BorderRadius.circular(15)),
              child: DescBox(
                currentIndex: widget.currentIndex,
              ),
            ),

            ///RecommendedMovies
            RecommendedMovies()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieDetailController.fetchRecommended();
  }
}

class DescBox extends StatelessWidget {
  MovieModel currentIndex;

  DescBox({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customText(
                text: "Release Date",
                size: 15,
                isbold: true,
                iscenter: true,
              ),
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(height: 1, color: Colors.white),
                ),
              )),
              customText(
                text: currentIndex.releaseDate,
                size: 15,
                isbold: true,
                iscenter: true,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customText(
                text: "Rating",
                size: 15,
                isbold: true,
                iscenter: true,
              ),
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(height: 1, color: Colors.white),
                ),
              )),
              customText(
                text: "${currentIndex.voteAverage.toString()} / 10",
                size: 15,
                isbold: true,
                iscenter: true,
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              customText(
                text: "Language",
                size: 15,
                isbold: true,
                iscenter: true,
              ),
              Expanded(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(height: 1, color: Colors.white),
                ),
              )),
              customText(
                text: currentIndex.lang.toUpperCase(),
                size: 15,
                isbold: true,
                iscenter: true,
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

class RecommendedMovies extends StatelessWidget {
  const RecommendedMovies({super.key});

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
              padding: const EdgeInsets.only(left: 20.0),
              child: customText(
                text: "Recommended Movies",
                color: Colors.white,
                size: 20,
                isbold: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: SizedBox(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        GetBuilder<MovieDetailController>(builder: (controller) {
          return controller.isLoading
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
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      int reversedIndex = controller.recommendedList.length - 1 - index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.off(() => MovieDetailScreen(currentIndex: controller.recommendedList[reversedIndex],),transition: Transition.rightToLeft,preventDuplicates: false);
                            },
                            child: Image.network(
                                controller.recommendedList[reversedIndex].posterPath),
                          ),
                        ),
                      );
                    },
                  ),
                );
        }),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
