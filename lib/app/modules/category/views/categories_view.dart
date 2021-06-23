import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_services/app/modules/home/widgets/featured_categories_widget.dart';
import 'package:home_services/app/modules/home/widgets/recommended_carousel_widget.dart';
import 'package:home_services/app/routes/app_routes.dart';
import '../../../providers/laravel_provider.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../controllers/categories_controller.dart';
import '../widgets/category_list_item_widget.dart';

class CategoriesView extends GetView<CategoriesController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print("${Get.arguments}");
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Categories".tr,
            style: Get.textTheme.headline6,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: () => {Get.back()},
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            controller.refreshCategories(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: ListView(
            primary: true,
            children: [
              /// Search bar widget with filter
              HomeSearchBarWidget(),

              /// heading of the categories of services and two buttons
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 10, top: 5, bottom: 15),
                child: Row(children: [
                  Expanded(
                    child: Text(
                      "Categories of ".tr + "${Get.arguments}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  // Row(
                  //   mainAxisSize: MainAxisSize.min,
                  //   children: <Widget>[
                  //     IconButton(
                  //       onPressed: () {
                  //         controller.layout.value = CategoriesLayout.LIST;
                  //       },
                  //       icon: Obx((){
                  //         return Icon(
                  //           Icons.format_list_bulleted,
                  //           color: controller.layout.value == CategoriesLayout.LIST ? Get.theme.accentColor : Get.theme.focusColor,
                  //         );
                  //       }),
                  //     ),
                  //     IconButton(
                  //       onPressed: () {
                  //         controller.layout.value = CategoriesLayout.GRID;
                  //       },
                  //       icon: Obx(() {
                  //         return Icon(
                  //           Icons.apps,
                  //           color: controller.layout.value == CategoriesLayout.GRID ? Get.theme.accentColor : Get.theme.focusColor,
                  //         );
                  //       }),
                  //     )
                  //   ],
                  // ),
                ]),
              ),

              //
              // Obx((){
              //   return Offstage(
              //     offstage: controller.layout.value != CategoriesLayout.GRID,
              //     child: controller.categories.isEmpty
              //         ? CircularLoadingWidget(height: 400)
              //         : StaggeredGridView.countBuilder(
              //             primary: false,
              //             shrinkWrap: true,
              //             crossAxisCount: 4,
              //             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //             itemCount: controller.categories.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               return CategoryGridItemWidget(category: controller.categories.elementAt(index), heroTag: "heroTag");
              //             },
              //             staggeredTileBuilder: (int index) => new StaggeredTile.fit(Get.mediaQuery.orientation == Orientation.portrait ? 2 : 4),
              //             mainAxisSpacing: 15.0,
              //             crossAxisSpacing: 15.0,
              //           ),
              //   );
              // }),

              Obx(() {
                return Offstage(
                  offstage: controller.layout.value != CategoriesLayout.LIST,
                  child: controller.categories.isEmpty
                      ? CircularLoadingWidget(height: 400)
                      : Container(
                          height: size.width * 0.28,
                          width: double.infinity,
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: controller.categories.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 10);
                            },
                            itemBuilder: (context, index) {
                              if (Get.arguments ==
                                  controller.categories.elementAt(index).name) {
                                return Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: size.width * 0.26,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: controller.categories
                                          .elementAt(index)
                                          .subCategories
                                          .length,
                                      itemBuilder: (_, subCategIndex) {
                                        var color = [Color(0xffEE892F),Color(0xffB23939),Color(0xffD9758F),Color(
                                            0xffcbbaba)];
                                        var finalColor = color[Random().nextInt(color.length)];
                                        var item = controller.categories
                                            .elementAt(index)
                                            .subCategories[subCategIndex];
                                        return InkWell(
                                          onTap: () {
                                            Get.toNamed(Routes.CATEGORY,
                                                arguments: controller.categories
                                                    .elementAt(index));
                                          },
                                          child: Container(
                                            width: size.width * 0.23,
                                            height: size.width * 0.23,
                                            margin: EdgeInsets.only(
                                                left: subCategIndex == 0 ? 5 : 0,
                                                right: 5,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment(1,0),
                                                  end: Alignment(1,1),
                                                  colors: [
                                                item.color
                                                    .withRed(subCategIndex),
                                                    item.color
                                                    .withRed(subCategIndex)
                                                    .withOpacity(0.4),
                                              ]),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "${item.name}",
                                                  style: GoogleFonts.cabin(
                                                    letterSpacing: 0.7,
                                                    color: Colors.white,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        ),
                );
              }),
              // Container(
              //   child: ListView(
              //       primary: false,
              //       shrinkWrap: true,
              //       children: List.generate(controller.categories.length, (index) {
              //         return Obx(() {
              //           var _category = controller.categories.elementAt(index);
              //           return Padding(
              //             padding: const EdgeInsetsDirectional.only(start: 20),
              //             child: Text(_category.name),
              //           );
              //         });
              //       })),
              // ),
              RecommendedCarouselWidget(),
              FeaturedCategoriesWidget(),
            ],
          ),
        ));
  }
}
