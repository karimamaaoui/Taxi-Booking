import 'package:flutter/material.dart';
import 'package:get/get.dart';




class CustomFormEmail extends StatelessWidget {
  const CustomFormEmail({
    Key key,
    @required TextEditingController email,
    @required FocusNode nodeEmail,
    @required FocusNode nodePassword,
  }) : _email = email, _nodeEmail = nodeEmail, _nodePassword = nodePassword, super(key: key);

  final TextEditingController _email;
  final FocusNode _nodeEmail;
  final FocusNode _nodePassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _email,
      focusNode: _nodeEmail,
      keyboardType: TextInputType.emailAddress,
      onEditingComplete: (){
        FocusScope.of(context).requestFocus(_nodePassword);
      },
      validator: (value){
        if(value.isEmpty){
          return "Please set your email";
        }else if(!GetUtils.isEmail(value)){
          return "wrong Email";
        }else {
          return null;
        }
      },
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          fillColor: Colors.grey.shade200,
          border :InputBorder.none,
          enabled: true,
          filled: true,
          errorStyle: Theme.of(context).textTheme.subtitle2.copyWith(
              color: Colors.redAccent.shade100
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width*0.06,vertical: Get.width*0.04),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width*0.03),
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
          focusedBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width*0.03),
              borderSide: BorderSide(
                  color: Colors.grey
              )
          ),
          errorBorder:   OutlineInputBorder(
              borderRadius: BorderRadius.circular(Get.width*0.03),
              borderSide: BorderSide(
                  color: Colors.yellow.shade400
              )
          ),
          labelText: "Email",
          suffixIcon: Icon(Icons.email),
          labelStyle: Theme.of(context).textTheme.subtitle1,
          hintText: "Email address",
          hintStyle: Theme.of(context).textTheme.subtitle2.copyWith(
              color: Colors.black54
          )
      ),

    );
  }
}