import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';

import '../../global_widgets/custom_bottom_nav_bar.dart';
import '../../global_widgets/main_drawer_widget.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: Drawer(
          child: MainDrawerWidget(),
          elevation: 0,
        ),
        body: controller.currentPage,
        bottomNavigationBar:


        BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedLabelStyle:  GoogleFonts.roboto(
              color:context.theme.accentColor,
            fontWeight: FontWeight.w500,
            fontSize: MediaQuery.of(context).size.width*0.03
          ),
          selectedLabelStyle: GoogleFonts.roboto(
              color:context.theme.accentColor,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.8,
              fontSize: MediaQuery.of(context).size.width*0.03

          ),
          showSelectedLabels: true,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: context.theme.accentColor,
          unselectedItemColor:context.theme.accentColor,
          currentIndex: controller.currentIndex.value,
          onTap: (index){
            controller.changePage(int.parse(index.toString()));
          },
          backgroundColor: context.theme.scaffoldBackgroundColor,
          items: [
            BottomNavigationBarItem(icon: Image.asset("assets/icon/Home2.png",scale:20,color:context.theme.accentColor,),
                label: "Home".tr),
            BottomNavigationBarItem(icon: Image.asset("assets/icon/Booking2.png",scale: 20,color:context.theme.accentColor ,),
                label:  "Bookings".tr,),
            BottomNavigationBarItem(icon: Icon(Icons.messenger_outline,color:context.theme.accentColor),
                label:  "Chats".tr),
            BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined,color:context.theme.accentColor),
                label: "Account".tr),
          ],
        )
      );
    });
  }
}
