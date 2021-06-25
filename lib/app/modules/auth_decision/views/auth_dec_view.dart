import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../routes/app_routes.dart';
import '../../../services/auth_service.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';


class AuthDecView extends StatefulWidget {
  const AuthDecView({Key key}) : super(key: key);

  @override
  _AuthDecViewState createState() => _AuthDecViewState();
}

class _AuthDecViewState extends State<AuthDecView> {
  bool headingIsVisible = false;
  bool topIsFar = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black, // navigation bar color
      statusBarColor: Colors.transparent, // status bar color
    ));
    Future.delayed(Duration(milliseconds: 3700),(){
      setState(() {
        topIsFar = false;
      });
      // print("top is far");
    }).whenComplete((){
      Future.delayed(Duration(milliseconds: 1900),(){
        setState(() {
          headingIsVisible = true;
        });
        // print("heading is visible");
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _currentUser = Get.find<AuthService>().user;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: AssetImage("assets/img/auth_dec_back.jpg"),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: size.width,
            height: size.height,
            color: Colors.black87.withOpacity(0.8),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1500),
                    margin: EdgeInsets.only(top:topIsFar? size.height*0.36:size.height*0.002),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: [
                    headingIsVisible?Container(
                      margin: EdgeInsets.only(top: size.height * 0.063,),
                      height: size.height * 0.136,
                      width: size.width*0.49,
                      child: Image.asset("assets/img/ic_launcher.png"),
                    ):
                    Container(
                          margin: EdgeInsets.only(top: size.height * 0.05),
                          height: size.height * 0.15,
                          width: size.width*0.55,
                          child:Image.asset("assets/icon/eaze_logo.gif",),
                        ),
                        Visibility(
                          visible: headingIsVisible,
                          child: Container(
                            child: AutoSizeText(
                              "Heading".tr,
                              style: GoogleFonts.cabin(
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),


                  Visibility(
                    visible:headingIsVisible,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                       InkWell(
                         onTap:(){
                           Get.toNamed(Routes.LOGIN);
                         },
                         child: Container(
                           alignment: Alignment.center,
                           width: size.width*0.31,
                           height: size.height*0.05,
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(20)
                           ),
                           child: AutoSizeText("Login".tr ,style: GoogleFonts.openSans(
                             color: Colors.black,
                             letterSpacing: 0.8,
                           ),
                           maxLines: 1,
                           ),
                         ),
                       ),
                        SizedBox(
                          height: size.height*0.03,
                        ),
                        GestureDetector(
                          onTap: (){
                            Get.toNamed(Routes.REGISTER);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width*0.31,
                            height: size.height*0.05,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: AutoSizeText("Sign_up".tr,style: GoogleFonts.openSans(
                                color: Colors.black,
                                letterSpacing: 0.8
                            ),),
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.024,
                        ),
                        GestureDetector(
                          onTap: (){
                       Get.offNamed(Routes.ROOT_WITH_AUTH);
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: size.height*0.02),
                            alignment: Alignment.center,
                            width: size.width*0.31,
                            height: size.height*0.05,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: AutoSizeText("Skip".tr ,style: GoogleFonts.openSans(
                                color: Colors.white,
                                letterSpacing: 0.8
                            ),),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
