import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moviego/controller/CategoryController.dart';
import 'package:moviego/screens/MovieDetailScreen.dart';
import 'package:moviego/utils/colors.dart';
import 'package:moviego/widgets/customText.dart';

class CategoryScreen extends StatefulWidget {
  String title, type;

  CategoryScreen({super.key, required this.title, required this.type});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        // categoryController.dispose(); // Dispose the controller
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: colors.primary,
          title: customText(
            text: widget.title,
            size: 20,
            isbold: true,
          ),
          centerTitle: true,
        ),
        body: GetBuilder<CategoryController>(
          builder: (controller) => controller.isLoading
              ? Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1 / 1.5,
                  ),
                  shrinkWrap: true,
                  controller: controller.scrollController,
                  itemBuilder: (context, index) {
                    if(index<controller.movieList.length){
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                      () => MovieDetailScreen(currentIndex: controller.movieList[index],),
                                  transition: Transition.rightToLeft);
                            },
                            child: Image.network(
                              controller.movieList[index].posterPath,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      );
                    }else{
                      return Center(child: CircularProgressIndicator(color: Colors.white,));
                    }
                  },
                  itemCount: controller.movieList.length+1,
                ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final CategoryController categoryController = Get.put(CategoryController());
    categoryController.fetchList(widget.type);
    categoryController.scrollController.addListener((){
      if(categoryController.scrollController.position.maxScrollExtent==categoryController.scrollController.offset){
        categoryController.loadMore(widget.type);
      }
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    final CategoryController categoryController = Get.find();
    categoryController.scrollController.dispose();
    super.dispose();
  }
}
