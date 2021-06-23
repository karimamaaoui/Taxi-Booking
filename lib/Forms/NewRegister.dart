import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'package:taxi2/pages/sign_up/driver_sign_up/drivers_sign_up.dart';
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
      (email: email.text,
      password: password.text,
    ).catchError((errMsg){
      displayToastMessage("Error "+errMsg.toString(), ctx);
    })
    ).user;

    if (_newdriv!=null)

    {

      Map cusDataMap={
        "name":name.text.trim(),
        "email":email.text.trim(),
        "password":password.text.trim(),
        "phone":phone.text.trim(),
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


