import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi2/commun_widget/customButton.dart';
import 'package:taxi2/pages/choix/category_text.dart';
import 'package:taxi2/pages/choix/welcome_text.dart';
import 'package:taxi2/pages/login/Customers/customer_login.dart';
import 'package:taxi2/pages/login/drivers/driver_login.dart';


///****mouch 93d ekhrj feha ha4i 3la ha4eka 3awdt ranit okk

class CustomersChoix extends StatelessWidget {
  const CustomersChoix({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          child: Column(
            children: [
              Spacer(),
              Image.asset("assets/images/taxi.png",width: Get.width*0.5,height: Get.width*0.5,),
              SizedBox(
                height: Get.height * 0.1,
              ),
              WelcomeText(),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CategorySelect(),
              SizedBox(
                height: Get.height * 0.1,
              ),
              CustomButton(
                color: Colors.black87,
                child: Text(
                  "Customer",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white),
                ),
                press: () {
                  Get.to(()=>CustomersLogin(),transition: Transition.fadeIn,duration: Duration(milliseconds: 600));
                },
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              CustomButton(
                color: Colors.yellow,
                press: () {
                  Get.to(()=>DriversLogin(),transition: Transition.fadeIn,duration: Duration(milliseconds: 600));
                },
                child: Text(
                  "Driver",
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      color :Colors.black
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
