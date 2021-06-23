import 'package:taxi2/commun_widget/custom_text_Reset.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:taxi2/commun_widget/customButton.dart';
import 'package:taxi2/commun_widget/custom_text_login.dart';
import 'package:taxi2/pages/login/Customers/customer_login.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key key}) : super(key: key);

  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {

  bool _isObscure = true;
  FocusNode _nodeEmail;
  TextEditingController _email;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeEmail = FocusNode();
    _email = TextEditingController();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nodeEmail.dispose();
    _email.dispose();
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
                  CustomTextReset(),
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


                            validator: (value) {
                               if (!value
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
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01,
                  ),

                  CustomButton(
                    child: Text("send Request ", style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(
                        color: Colors.white
                    ),),
                    color: Colors.black87,
                    press: () {
                      _firebaseAuth.sendPasswordResetEmail(email: _email.text.trim());
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>CustomersLogin()));


                    },
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  displayToastMessage(String message, BuildContext ctx1) {
    Fluttertoast.showToast(msg: message);
  }

}
