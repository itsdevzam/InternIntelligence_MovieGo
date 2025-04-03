import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:moviego/screens/MovieDetailScreen.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/widgets/customText.dart';

import '../controller/SearchController.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final movieSearchController = Get.put(MovieSearchController());
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              customText(
                text: "Search Movies",
                size: 22,
                isbold: true,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: textEditingController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    label: customText(text: "Search"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              GetBuilder<MovieSearchController>(
                builder: (controller) => controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Expanded(
                        child: controller.searchList.isNotEmpty?
                        ListView.builder(
                          controller: movieSearchController.searchController,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Get.to(()=>MovieDetailScreen(currentIndex: controller.searchList[index],),transition: Transition.rightToLeft);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 20, right: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          controller.searchList[index].posterPath,
                                          height: 150,
                                          width: 100,
                                          errorBuilder: (context, error,
                                              stackTrace) =>
                                              Container(
                                                height: 150,
                                                width: 100,
                                                color: Colors.white,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    Icon(Iconsax.folder_cross,
                                                      size: 30,),
                                                    SizedBox(height: 5,),
                                                    customText(
                                                      text: "No Image Available",
                                                      color: Colors.black,
                                                      size: 12,
                                                      iscenter: true,)
                                                  ],
                                                ),
                                              ),
                                        ),
                                      ),
                                      SizedBox(width: 20,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            child: customText(
                                              text: controller.searchList[index]
                                                  .title,
                                              size: 18,
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          customText(
                                            text: "Rating: ${controller
                                                .searchList[index].voteAverage
                                                .toString()} / 10",
                                            size: 14,
                                          ),
                                          SizedBox(height: 5,),
                                          customText(
                                            text: "Date: ${controller
                                                .searchList[index].releaseDate}",
                                            size: 14,
                                          ),
                                          SizedBox(height: 5,),
                                        ],
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        height: 150,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: customText(
                                            text: controller.searchList[index]
                                                .lang.toUpperCase(),
                                            color: colors.primary,
                                            size: 14,
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              );
                          },
                          itemCount: controller.searchList.length,
                        ):
                        Container(
                          alignment: Alignment.center,
                          child: customText(text: "No Result Found!",size: 18,),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // movieSearchController.searchMovie("tarzan");
    textEditingController.addListener(() {
      if (textEditingController.text.isNotEmpty) {
        movieSearchController.searchMovie(textEditingController.text);
      }else{
        movieSearchController.searchMovie("");
      }
    });
    movieSearchController.searchController.addListener((){
      if(movieSearchController.searchController.position.maxScrollExtent==movieSearchController.searchController.offset){
        movieSearchController.loadMore(textEditingController.text);
      }
    });
  }

}
