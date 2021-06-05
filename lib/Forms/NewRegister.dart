import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'RegisterDriverForm.dart';
import '../main.dart';

class NewRegister
{

  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
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

    final User _newdriv = (await _firebaseAuth.createUserWithEmailAndPassword
      (email: emailTextEditingController.text,
      password: passwordTextEditingController.text,
    ).catchError((errMsg){
      displayToastMessage("Error "+errMsg.toString(), ctx);
    })
    ).user;

    if (_newdriv!=null)

    {

      Map cusDataMap={
        "name":nameTextEditingController.text.trim(),
        "email":emailTextEditingController.text.trim(),
        "password":passwordTextEditingController.text.trim(),
        "phone":phoneTextEditingController.text.trim(),
        "status":"Available",
        "address":dropdownValue

      };
      usersRef2.child(_newdriv.uid).set(cusDataMap);


    }
    else
    {
      displayToastMessage("New  account has not created",ctx);

    }

  }



}

displayToastMessage(String message,BuildContext ctx1)
{
  Fluttertoast.showToast(msg: message);
}


