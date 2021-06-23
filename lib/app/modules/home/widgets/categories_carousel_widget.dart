import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class CategoriesCarouselWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.25,
      margin: EdgeInsets.only(bottom: 15, top: size.width * 0.03),
      child: Obx(() {
        return ListView.builder(
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (_, index) {
              var _category = controller.categories.elementAt(index);
              return InkWell(
                onTap: () {
                  Get.toNamed(Routes.CATEGORIES,arguments: "${_category.name}");
                  // Get.toNamed(Routes.CATEGORY, arguments: _category);
                },
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.35,
                  margin: EdgeInsetsDirectional.only(
                      end: 15, start: index == 0 ? 15 : 0,
                  top: 5,
                  bottom: 5),
                  decoration: new BoxDecoration(
                    color: Get.theme.primaryColor,
                    // gradient: new LinearGradient(
                    //     colors: [
                    //       _category.color.withOpacity(1),
                    //       _category.color.withOpacity(0.1)
                    //     ],
                    //     begin: AlignmentDirectional.topStart,
                    //     //const FractionalOffset(1, 0),
                    //     end: AlignmentDirectional.bottomEnd,
                    //     stops: [0.1, 0.9],
                    //     tileMode: TileMode.clamp),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 6,
                        offset: Offset(-1,1),
                        spreadRadius: 2
                      ),

                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: size.width * 0.45,
                        height: size.height * 0.16,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: (_category.image.url
                                  .toLowerCase()
                                  .endsWith('.svg')
                              ? SvgPicture.network(
                                  _category.image.url,
                                  color: _category.color,
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: _category.image.url,
                                  placeholder: (context, url) => Image.asset(
                                    'assets/img/loading.gif',
                                    fit: BoxFit.cover,
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error_outline),
                                )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 18,left: 10),
                        child: Text(
                          _category.name,
                          maxLines: 2,
                          style: Get.textTheme.bodyText2
                              .merge(GoogleFonts.roboto(color: context.theme.accentColor)),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
