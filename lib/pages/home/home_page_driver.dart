import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi2/Drivers/LocationDv.dart';
import 'package:taxi2/LocationCustomer/LocationC.dart';
import 'package:taxi2/commun_widget/customButton.dart';




class HomePageDriver extends StatelessWidget {
  AppLifecycleState state;
  bool isConnect() {

    if (state == AppLifecycleState.inactive)
    {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      return true;
      // setSatuts("Online");
      /// **** ritha ha4i taw  bool isconnect awel may3ml log enti ta3ml update "isconnect" : true mouch hne khtr ma3ndh 3ale9A  bhy
    }
    else
    {
      return false;
      //   setSatuts("Offline");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text("Home",style: Theme.of(context).textTheme.headline6,),
        actions: [
          GestureDetector(
            onTap: (){

            },
            child: Padding(
              padding: const EdgeInsets.only(right:15.0),
              child: SvgPicture.asset("assets/logout-svgrepo-com.svg",height: 25,width: 20,),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: Get.height,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Spacer(),
                Lottie.asset('assets/23521-taxi-app-starter-screen-animation.json',width: Get.width*0.5,height: Get.width*0.5,),
                Spacer(flex: 3,),
                Text("To show the reservation",style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.grey
                ),textAlign: TextAlign.center,),
                Spacer(flex: 2,),
                CustomButton(color: Colors.yellow,
                    press: (){
                      isConnect();
                      Get.to(()=>LocationDv());
                    }, child: Text("Allow",style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        letterSpacing: 1.0
                    ),)),
                Spacer(flex: 5,),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
