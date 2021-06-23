///*********enbording page *********//
///******* win metfhmch haja 7abesni  ok ?? cv ama dkika bch nkalem profa w narjaa missalech ??Hhhh behi ok

import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:taxi2/commun_widget/customButton.dart';
import 'package:taxi2/pages/choix/choix_login.dart';
import 'file:///C:/Users/asus/AndroidStudioProjects/taxi2/lib/pages/choix/login_page.dart';
import 'package:taxi2/pages/login/Customers/customer_login.dart';
///!!!chniya erreur
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _controllerSize;
  Animation _scale;
  Animation<double> _rotate;
  bool _opacity = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 550));
    _controllerSize =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));

    _scale = Tween<double>(begin: 1.0, end: 30)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInCubic))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Get.off(() => CustomersChoix(),transition: Transition.fadeIn);///win hatitha elpage ha4i
        }
      });
    _rotate = Tween<double>(begin: 200, end: Get.height * 0.08).animate(
        CurvedAnimation(parent: _controllerSize, curve: Curves.easeInToLinear))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.forward();
        }
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Lottie.asset('assets/3870-taxi.json',
                        width: Get.width*0.7,
                        height: Get.width*0.7,
                      ),
                      SizedBox(height: Get.height*0.1,),
                      Shimmer.fromColors(
                        highlightColor: Colors.black,
                        baseColor: Colors.grey,
                        child: Text("Taxi Bi-Bi",style:Theme.of(context).textTheme.headline3.copyWith(
                            letterSpacing: 1.0
                        ) ,),
                      ),
                      SizedBox(height: Get.height*0.15,),
                      Transform.scale(
                          scale: _scale.value,
                          child: AnimatedBuilder(
                              animation: _controllerSize,
                              builder: (context, child) {
                                return InkWell(
                                  onTap: () {
                                    _controllerSize.forward();
                                    setState(() {
                                      _opacity = true;
                                    });
                                  },
                                  child: Container(
                                    width: _rotate.value,
                                    height: Get.height * 0.08,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 15,
                                              offset: Offset(0,5)
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(35)),
                                    child: AnimatedOpacity(
                                      duration: Duration(milliseconds: 300),
                                      opacity: _opacity? 0:1,
                                      child: Center(
                                        child: Text(
                                          "Get started",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              })),
                      SizedBox(
                        height: Get.height * 0.1,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
