
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi2/OPScreen.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'package:taxi2/commun_widget/customButton.dart';
import 'package:taxi2/commun_widget/custom_forget_password.dart';
import 'package:taxi2/commun_widget/custom_login_widget.dart';

import 'package:taxi2/commun_widget/custom_text_SignUp.dart';
import 'package:taxi2/main.dart';
import 'package:taxi2/pages/home/home_page.dart';
import 'package:taxi2/pages/login/Customers/customer_login.dart';
import 'package:taxi2/pages/login/Drivers/driver_login.dart';


class DriversSignUp extends StatefulWidget {
  const DriversSignUp({Key key}) : super(key: key);

  @override
  _DriversSignUpState createState() => _DriversSignUpState();
}
TextEditingController email;
TextEditingController password;
TextEditingController name;
TextEditingController phone;
var dropdownValue ;
List <String> listOfCountries =<String> ["Tunisia", "Bizerte", "Sousse","Ben Arous","Nabeul"];


class _DriversSignUpState extends State<DriversSignUp> {

  bool _isObscure = true;
  FocusNode _nodeEmail;
  FocusNode _nodePassword;
  FocusNode _nodeName;
  FocusNode _nodePhone;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeName=FocusNode();
    _nodeEmail = FocusNode();
    _nodePhone=FocusNode();

    _nodePassword = FocusNode();
    name=TextEditingController();
    email = TextEditingController();
    phone=TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nodeName.dispose();
    _nodePassword.dispose();
    _nodeEmail.dispose();
    _nodePhone.dispose();
    name.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Taxi Bi-Bi Drivers", style: Theme
            .of(context)
            .textTheme
            .headline6,),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          iconSize: Get.height * 0.025,
          onPressed: () {
            Get.back();
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _form.currentState.reset();
              });
            },
            child: Container(
              width: double.infinity,
              height: Get.height,
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Spacer(),
                  CustomTextSignUp(),
                  Spacer(
                    flex: 2,
                  ),
                  Form(
                    key: _form,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            focusNode: _nodeName,
                            enabled: true,
                            keyboardType: TextInputType.text,
                            autocorrect: true,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(
                                  _nodeEmail);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "email set your name ";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .auto,
                                fillColor: Colors.grey.shade200,
                                border: InputBorder.none,
                                filled: true,
                                errorStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.redAccent.shade100
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06,
                                    vertical: Get.width * 0.04),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.yellow.shade400
                                    )
                                ),
                                labelText: "Name",
                                suffixIcon: Icon(Icons.text_fields),
                                labelStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                                hintText: "Driver Name",
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.black54
                                )
                            ),

                          ),
                          SizedBox(height: Get.height * 0.02,
                          ),
                          TextFormField(
                            controller: email,
                            focusNode: _nodeEmail,
                            enabled: true,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () {
                              FocusScope.of(context).requestFocus(
                                  _nodePassword);
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Password set your email";
                              } else if (!value
                                  .trim()
                                  .isEmail) {
                                return "wrong Email";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .auto,
                                fillColor: Colors.grey.shade200,
                                border: InputBorder.none,
                                filled: true,
                                errorStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.redAccent.shade100
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06,
                                    vertical: Get.width * 0.04),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.yellow.shade400
                                    )
                                ),
                                labelText: "Email",
                                suffixIcon: Icon(Icons.email),
                                labelStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                                hintText: "Email address",
                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.black54
                                )
                            ),

                          ),
                          SizedBox(height: Get.height * 0.02,
                          ),
                          TextFormField(
                            controller: password,
                            focusNode: _nodePassword,
                            keyboardType: TextInputType.text,
                            obscureText: _isObscure,
                            enabled: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "write your password";
                              } else if (value.length < 5) {
                                return "password must be more than 5 caratere";
                              } else {
                                return null;
                              }
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .auto,
                                fillColor: Colors.grey.shade200,
                                errorStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.redAccent.shade100
                                ),
                                border: InputBorder.none,
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.yellow.shade400
                                    )
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06,
                                    vertical: Get.width * 0.04),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                labelText: "Password",
                                suffixIcon: IconButton(
                                  icon: _isObscure
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                                labelStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                                hintText: "***********",

                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.black54
                                )
                            ),

                          ),
                          SizedBox(height: Get.height * 0.02,
                          ),
                          TextFormField(
                            controller: phone,
                            focusNode: _nodePhone,
                            keyboardType: TextInputType.phone,
                            enabled: true,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "write your Phone nmuber";
                              } else if (value.length < 8) {
                                return "phone number must be  8 numbers";
                              } else {
                                return null;
                              }
                            },
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                            },
                            decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior
                                    .auto,
                                fillColor: Colors.grey.shade200,
                                errorStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.redAccent.shade100
                                ),
                                border: InputBorder.none,
                                filled: true,
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.yellow.shade400
                                    )
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.06,
                                    vertical: Get.width * 0.04),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                        Get.width * 0.03),
                                    borderSide: BorderSide(
                                        color: Colors.grey
                                    )
                                ),
                                labelText: "Phone",
                                suffixIcon: Icon(Icons.phone),
                                prefix: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Text('+216',style:TextStyle(fontSize: 17),),
                                ),
                                labelStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle1,
                                hintText: "00 000 000",

                                hintStyle: Theme
                                    .of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                    color: Colors.black54
                                )
                            ),

                          ),
                          SizedBox(height: Get.height * 0.02,),

                          Padding(

                            padding: EdgeInsets.only(left:8,right:8),

                            child:
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.grey.shade200,
                                ),
                              child: DropdownButtonFormField(
                                  dropdownColor: Colors.grey.shade200,

                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade200,

                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25.0),
                                        borderSide: BorderSide(color: Colors.grey.shade200,),

                                    ),


                                ),

                                items: listOfCountries.map(
                                        (value) => DropdownMenuItem(

                                      child:Text(value),
                                      value:value,

                                    )).toList(),
                                onChanged: (selectedCountry){
                                  setState(() {
                                    dropdownValue=selectedCountry;
                                  });
                                },
                                value: dropdownValue,
                                isExpanded: false,

                                hint: Text('Choose Country',),
                              ),
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01,
                  ),
                  ForgetPassword(
                    press: () {
                      ///******* hne 3andk page forgot password wela le ??? maamlthach mzlt
                      ///
                    },
                  ),
                  Spacer(flex: 3),

                  CustomButton(
                    child: Text("Sign Up ", style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(
                        color: Colors.white
                    ),),
                    color: Colors.black87,
                    press: () {
                      if (_form.currentState.validate()) {
                        _form.currentState.save();


                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) =>
                                OTPScreen(phone
                                    .text)));
                    //    Get.to(()=>OTPScreen(phone.text));
                      }
                    },
                  ),
                  Spacer(),
                  CustomSignIn(
                    press: () {
                      Get.to(()=>DriversLogin());

                    },

                  ),
                  Spacer(flex: 2,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
