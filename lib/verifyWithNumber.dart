import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Maps/Maps.dart';

class verifyWithNumber extends StatefulWidget {
  @override
  _verifyWithNumberState createState() => _verifyWithNumberState();
}

class _verifyWithNumberState extends State<verifyWithNumber> {
  String numPhone,smsCode,verificationId;
  TextEditingController phoneTextEditingController=TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController=TextEditingController();

    signIn(AuthCredential authCredential)
    {
      FirebaseAuth.instance.signInWithCredential(authCredential);
    }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationCompleted verfiedSuccess=(AuthCredential authResult)
    {
      signIn(authResult);
      print(authResult);
    };
    final PhoneVerificationFailed verificationFailed=(FirebaseAuthException exception)
    {
      print('${exception.message}');
    };

    final PhoneCodeSent codeSent=(
        String verID,[int forceResendingToken])async{
      this.verificationId=verID;
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout=(String verId){
      verificationId = verificationId;
      print(verificationId);
      print("Timout");
    };

    _auth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: Duration(seconds: 60),
        verificationCompleted:verfiedSuccess,
        verificationFailed: verificationFailed,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        codeSent: (String verificationId, [int forceResendingToken]){
          //show dialog to take input from the user
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text("Enter SMS Code"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: codeController,
                    ),

                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Done"),
                    textColor: Colors.white,
                    color: Colors.redAccent,
                    onPressed: () {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      smsCode = codeController.text.trim();
                      AuthCredential authC = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                      _auth.signInWithCredential(authC).then(( authC){
                        Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => Maps()
                        ));
                      }).catchError((e){
                        print(e);
                      });
                    },
                  )
                ],
              )
          );
        },
    );
  }


  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    void moveToTheLastScreen() {
      Navigator.pop(context);
    };

    return WillPopScope(
        onWillPop: () {
          moveToTheLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(title: Text("Customer Side"),
            backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
            leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){moveToTheLastScreen();}
            ),),
          body:
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration:BoxDecoration(image: DecorationImage(image:
            AssetImage('assets/yellow.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.colorDodge)
            ),
            ),
            child : SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChildScrollView(
                      child:Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(height:5.0,),
                            Text("Connect as a Customer",style: TextStyle(fontSize: 32,color: Color.fromRGBO(240, 160, 50, 1.0)),
                              textAlign: TextAlign.center,),
                            Padding(
                              padding:EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height:5.0,),
                                  TextField(
                                    controller:phoneTextEditingController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      prefixText: "+216 ",
                                      labelText: "Enter Phone",
                                      labelStyle: TextStyle(fontSize: 25
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:22.0,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller:passController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      labelText: "Enter Password",
                                      labelStyle: TextStyle(fontSize: 25
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:22.0,
                                      ),
                                    ),
                                  ),


                                  SizedBox(height:20.0,),
                                  RaisedButton(
                                      color: Colors.yellow,
                                      textColor: Colors.white,
                                      child: Container(
                                        child: Text("Continue",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                                      ),
                                      onPressed: ()async{
                                        if (phoneTextEditingController.text.length < 6)
                                        {
                                          displayToastMessage("Number Phone invalid ",context);
                                        }
                                        else
                                        {
                                          final mobile = phoneTextEditingController.text.trim();
                                          registerUser(mobile, context);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Maps()));
                                        }

                                      }
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),

                      ),
                    )
                  ],
                ),
              ),),
          ),
        ));


  }

  /*Future <void> verifyPohne()async{
    final PhoneCodeAutoRetrievalTimeout autoRetrieve=(String verId){
      this.verificationId=verId;
    };
    final PhoneCodeSent smsCodeSent=(
        String verID,[int forceResendingToken])async{
      this.verificationId=verID;
      setState(() {
        print("Code sent to $numPhone");
        print("\n Enter the code sent to " + numPhone);

      });
    };

    final PhoneVerificationFailed verifiFailed=(FirebaseAuthException exception)
    {
      print('${exception.message}');
    };

    final PhoneVerificationCompleted verfiedSuccess=(AuthCredential authCredential)
    {
      print('verified');
    };
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
    );

    /*final User userc = await _firebaseAuth.signInWithCredential(credential).userc;
    if (userc != null) {
      setState(() {
        print( 'Authentication successful');
      });
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.numPhone,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrieve,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verfiedSuccess,
        verificationFailed: verifiFailed,
      );
*/
    }


    Future <bool> smsCodeDialog(BuildContext ctx2)
    {
      var currUser = _firebaseAuth.currentUser;
      return showDialog(
        context: ctx2,
        barrierDismissible: false,
        builder: (BuildContext ctx2)
        {
          return new AlertDialog(
            title: Text("Enter Sms Code"),
            content: TextField(
              onChanged: (value){
                this.smsCode=value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: [
              new FlatButton(
                child: Text("Done"),
                onPressed: (){
                  if(currUser!=null)
                  {
                    Navigator.of(ctx2).pop();
                    Navigator.of(ctx2).pushReplacementNamed('Maps');
                  }else{
                    Navigator.of(ctx2).pop();
                  }

                },

              )
            ],
          );
        },);
    }*/


  displayToastMessage(String message,BuildContext ctx1)
  {
    Fluttertoast.showToast(msg: message);
  }
}