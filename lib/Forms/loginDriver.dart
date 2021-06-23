/*import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Home.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'RegisterDriverForm.dart';
import '../main.dart';
class loginDriver{

final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
displayToastMessage(String message, BuildContext ctx1) {

  Fluttertoast.showToast(msg: message);

}

Login(BuildContext ctx1)async
{
  showDialog(
      context: ctx1,
      barrierDismissible: false,
      builder: (BuildContext context)
      {
        return  ProgressDialog(message:"Authentification , Please wait ...");
      }
  );




  final User _newdriv = (await _firebaseAuth.signInWithEmailAndPassword
    (email: emailTextEditingController.text,
      password: passwordTextEditingController.text
  ).catchError((errMsg){
    displayToastMessage("Error "+errMsg.toString(), ctx1);
  })
  ).user;
  if (_newdriv!=null)
  {
    usersRef2.child(_newdriv.uid).once().then((DataSnapshot snap)
    {
      if(snap.value!=null)
      {
        Navigator.pushReplacement(ctx1, MaterialPageRoute(builder: (context)=>Home()));
        displayToastMessage("You are logged now  ",ctx1);

      }
      else
      {
        _firebaseAuth.signOut();
        displayToastMessage("No record exists for this Driver .Please create an account  ",ctx1);

      }
    }
    );

  }
  else
  {
    displayToastMessage("Error occured can not",ctx1);
  }


}


}
*/