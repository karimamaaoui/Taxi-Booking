import 'package:flutter/material.dart';
import 'package:get/get.dart';

///********* package get bch e3awena fel navigation w fih des autre parametre eli bch e3awnouk
/// Get.height = MediaQueri.of(context).size.height rit elfar9
/// Get.to(()=> user()) == navigtor.of(context).push(materialPageRoute( .......))
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: Get.height,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
          ),
          ),
          child: Center(
            child: MaterialButton(
              child: Text("Start"),
              onPressed: (){

              },
            ),
          ),
        ),
      ),
    );
  }
}
