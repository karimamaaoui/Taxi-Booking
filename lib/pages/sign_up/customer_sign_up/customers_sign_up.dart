
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
////****zid commun widets 9bal w ba3d ha4om bch maykhrjlkch les erreurs w a3ml valide cache bch ma3dch ya3kich elandroid studio
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
import 'package:taxi2/pages/login/Customers/customer_login.dart';



///******* defaut fel android studio eno yplanta taw package ha4a bch ki tnzel elbara mel textformfield ena7i clavier ya3mllha desmi
///***** mouch ha4i elpage
class CustomersSignUp extends StatefulWidget {
  const CustomersSignUp({Key key}) : super(key: key);

  @override
  _CustomersSignUpState createState() => _CustomersSignUpState();
}

class _CustomersSignUpState extends State<CustomersSignUp> {

  bool _isObscure = true;
  FocusNode _nodeEmail;
  FocusNode _nodePassword;
  FocusNode _nodeName;
  TextEditingController _email;
  TextEditingController _password;
  TextEditingController _name;
  GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nodeName=FocusNode();
    _nodeEmail = FocusNode();
    _nodePassword = FocusNode();
    _name=TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nodeName.dispose();
    _nodePassword.dispose();
    _nodeEmail.dispose();
    _name.dispose();
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
                            controller: _name,
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
                                hintText: "Customer Name",
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
                        registerNew(context);
                         }
                    },
                  ),
                  Spacer(),
                  CustomSignUp(
                    press: () {
                      ///********* hnr sign up ta3 customers bhy kifh bch t3ml bch nfhmk
                      Get.to(()=>CustomersLogin());
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


  displayToastMessage(String message, BuildContext ctx1) {
    Fluttertoast.showToast(msg: message);
  }


  registerNew(BuildContext ctx)async
  {
    showDialog(
        context: ctx,
        barrierDismissible: false,
        builder: (BuildContext context)
        {
          return  ProgressDialog(message:"Registering, Please wait ...");
        }
    );




    final User _newcus = (await _firebaseAuth.createUserWithEmailAndPassword
      (email: _email.text,
        password: _password.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error "+errMsg.toString(), ctx);
    })
    ).user;

    if (_newcus!=null)
    {
      Map cusDataMap={
        "name":_name.text.trim(),
        "email":_email.text.trim(),
        "password":_password.text.trim(),
      };
      usersRef.child(_newcus.uid).set(cusDataMap);
      displayToastMessage("New Customer account has created ",ctx);

      Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context)=>HomePage()));

    }
    else
    {
      Navigator.pop(context);
      displayToastMessage("New Customer account has not created",ctx);
    }
  }

}
