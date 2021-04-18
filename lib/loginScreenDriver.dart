import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Home.dart';
import 'package:taxi2/RegisterScreenDriver.dart';
import 'package:taxi2/main.dart';
import 'RegisterScreen.dart';

class loginScreenDriver extends StatefulWidget {
  @override
  _LoginScreenDriverState createState() => _LoginScreenDriverState();


}

class _LoginScreenDriverState extends State<loginScreenDriver> {
  bool passwordVisible=true;

  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
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
          appBar: AppBar(title: Text("Driver Side"),
            backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
            leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){moveToTheLastScreen();}
            ),
          ),
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
                            SizedBox(height:5.0),
                            Image(
                              image: AssetImage("assets/driver.jpg"),
                              width:290.0,
                              height:150.0,
                              alignment:Alignment.center,
                            ),
                            SizedBox(height:5.0,),
                            Text("Connect as a Driver",style: TextStyle(fontSize: 32,color: Color.fromRGBO(240, 160, 50, 1.0)),
                              textAlign: TextAlign.center,),
                            Padding(
                              padding:EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  SizedBox(height:5.0,),
                                  TextFormField(
                                    controller:emailTextEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      labelStyle: TextStyle(fontSize: 14
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:10.0,
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    controller: passwordTextEditingController,
                                    obscureText: this.passwordVisible,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(fontSize: 14
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:10.0,
                                      ),
                                      suffixIcon:
                                      IconButton(
                                        icon: Icon(this.passwordVisible? Icons.visibility:Icons.visibility_off),
                                        onPressed: (){
                                          setState(() {
                                            this.passwordVisible=!this.passwordVisible;
                                          });

                                        },
                                      ),
                                    ),
                                  ),  SizedBox(height:20.0,),
                                  RaisedButton(
                                      color: Colors.yellow,
                                      textColor: Colors.white,
                                      child: Container(
                                        child: Text("Connect",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                                      ),
                                      onPressed: ()async{
                                        if(!emailTextEditingController.text.contains('@'))
                                        {
                                          displayToastMessage("Email address invalid ",context);
                                        }
                                        else if (passwordTextEditingController.text.length<6)
                                        {

                                          displayToastMessage("Password must be at least 6 caracters ",context);
                                        }
                                        else
                                        {
                                          Login(context);
                                        }
                                      }
                                  ),
                                ],
                              ),
                            ), FlatButton (

                              onPressed:()
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>RegisterScreenDriver()));
                              },
                              child: Text("create a new account"),

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
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  displayToastMessage(String message, BuildContext ctx1) {
    Fluttertoast.showToast(msg: message);
  }
  Login(BuildContext ctx1)async
  {
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
