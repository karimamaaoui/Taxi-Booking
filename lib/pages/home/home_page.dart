import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:taxi2/LocationCustomer/LocationC.dart';
import 'package:taxi2/commun_widget/customButton.dart';




class HomePage extends StatelessWidget {


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
                Text("To make Reservation faster and easier from your current location\npress Allow",style: Theme.of(context).textTheme.headline6.copyWith(
                    color: Colors.grey
                ),textAlign: TextAlign.center,),
                Spacer(flex: 2,),
                CustomButton(color: Colors.yellow,
                    press: (){
                      Get.to(()=>LocationC());
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
