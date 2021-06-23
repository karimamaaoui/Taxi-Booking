
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'package:taxi2/commun_widget/customButton.dart';
import 'package:taxi2/commun_widget/custom_forget_password.dart';
import 'package:taxi2/commun_widget/custom_signUp_widget.dart';
import 'package:taxi2/commun_widget/custom_text_login.dart';
import 'package:taxi2/main.dart';
import 'package:taxi2/pages/home/home_page.dart';
import 'package:taxi2/pages/login/Customers/resetPassword.dart';
import 'package:taxi2/pages/sign_up/customer_sign_up/customers_sign_up.dart';

class CustomersLogin extends StatefulWidget {
  const CustomersLogin({Key key}) : super(key: key);

  @override
  _CustomersLoginState createState() => _CustomersLoginState();
}

class _CustomersLoginState extends State<CustomersLogin> {

  bool _isObscure = true;
  FocusNode _nodeEmail;
  FocusNode _nodePassword;
  TextEditingController _email;
  TextEditingController _password;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeEmail = FocusNode();
    _nodePassword = FocusNode();
    _email = TextEditingController();
    _password = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nodePassword.dispose();
    _nodeEmail.dispose();
    _email.dispose();
    _password.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Taxi Bi-Bi Customers", style: Theme
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
                  CustomText(),
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
                            controller: _email,
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
                            controller: _password,
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01,
                  ),
                  ForgetPassword(
                    press: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>resetPassword()));

                    },
                  ),
                  Spacer(flex: 3),

                  CustomButton(
                    child: Text("Login ", style: Theme
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
                        Login(context);// hne wi
                        ///*********** methode de sign in *****************///
                      }
                    },
                  ),
                  Spacer(),
                  CustomSignUp(
                    press: () {
                      Get.to(()=>CustomersSignUp());
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

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Login(BuildContext ctx1) async
  {
    showDialog(
        context: ctx1,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(message: "Authentification , Please wait ...");
        }
    );


    final User _newcus = (await _firebaseAuth.signInWithEmailAndPassword
      (email: _email.text,
        password: _password.text
    ).catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error " + errMsg.toString(), ctx1);
    })
    ).user;
    if (_newcus != null) {
      usersRef.child(_newcus.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushReplacement(
              ctx1, MaterialPageRoute(builder: (context) => HomePage()));
          displayToastMessage("You are logged now  ", ctx1);
        }
        else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exists for this Customer .Please create an account  ",
              ctx1);
        }
      }
      );
    }
    else {
      Navigator.pop(context);
      displayToastMessage("Error occured can not", ctx1);
    }
  }


  displayToastMessage(String message, BuildContext ctx1) {
    Fluttertoast.showToast(msg: message);
  }

}
