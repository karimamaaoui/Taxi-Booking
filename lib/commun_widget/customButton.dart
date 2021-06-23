
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///************** si il y a plusieurs buttom de mmeme forme mettre le en stless
class CustomButton extends StatelessWidget {
  const CustomButton({Key key,@required this.color,@required this.press ,  @required this.child}) : super(key: key);
  final Color color;
  final Function press;



  final Widget child;

  @override
  Widget build(BuildContext context) {
    return  MaterialButton(
        minWidth:  Get.width*0.5,
        color: color,
        height: Get.height*0.08,
        elevation: 10.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Get.width*0.03)
        ),
        child: child,
        onPressed: press
    );
  }
}
