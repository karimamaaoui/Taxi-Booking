import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Home.dart';
import 'package:taxi2/Widget/progressDialog.dart';
import 'package:taxi2/loginScreen.dart';
import 'package:taxi2/main.dart';
import 'LoginPhone.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

}
class _RegisterScreenState extends State<RegisterScreen>{
  bool passwordVisible=true;

  TextEditingController nameTextEditingController=TextEditingController();
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController passwordTextEditingController=TextEditingController();
  String email,password,name;

  @override
  Widget build(BuildContext context) {
    final _formkey=GlobalKey<FormState>();

    void moveToTheLastScreen()
    {
      Navigator.pop(context);
    };
    return WillPopScope(
        onWillPop :(){
          moveToTheLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(title: Text("Customer Side"),
            backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
            leading: IconButton(icon: Icon(Icons.arrow_back),
                onPressed: (){moveToTheLastScreen();}
            ),),
          body: Container(
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
                              image: AssetImage("assets/images/taxi.png"),
                              width:290.0,
                              height:150.0,
                              alignment:Alignment.center,

                            ),
                            SizedBox(height:5.0,),
                            Text("Create new Customer account ",style: TextStyle(fontSize: 32,color: Color.fromRGBO(240, 160, 50, 1.0)),
                              textAlign: TextAlign.center,),
                            Padding(
                              padding:EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  SizedBox(height:5.0,),
                                  TextFormField(
                                    controller:nameTextEditingController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: "Name",
                                      labelStyle: TextStyle(fontSize: 14
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:10.0,
                                      ),
                                    ),
                                  ),
                                 TextFormField(
                                    controller:emailTextEditingController,
                                    keyboardType:TextInputType.emailAddress,
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
                                    //obscureText: true,
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
                                  ),SizedBox(height:20.0,),
                                  RaisedButton(
                                    color: Colors.yellow,
                                    textColor: Colors.white,
                                    child: Container(
                                      child: Text("Connect",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                                    ),
                                    onPressed: ()async{
                                      if (nameTextEditingController.text.length < 3)
                                        {
                                          displayToastMessage("Name must be at least 3 caracters ",context);
                                        }
                                      else if(!emailTextEditingController.text.contains('@'))
                                        {

                                            displayToastMessage("Email address invalid ",context);

                                        }
                                      else if (passwordTextEditingController.text.length<6)
                                        {

                                          displayToastMessage("Password must be at least 6 caracters ",context);
                                        }
                                      else
                                        {
                                          registerNew(context);
                                         

                                        }
                                    },
                                  )
                                ],
                              ),
                            ),
                            FlatButton(
                              onPressed:()
                              {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context)=>loginScreen()));

                              },child: Text("Already have an account ? Login here"),

                            ),
                            RaisedButton(
                                color: Colors.green,
                                textColor: Colors.white,
                                child: Row(
                                  children:[
                                    Icon(Icons.phone),
                                    Padding(
                                      padding:const EdgeInsets.only(left:14.0,top:10.0,bottom: 10.0),
                                      child: Text("Sign in with Phone",style:TextStyle(fontSize: 16)),

                                    ),
                                  ],
                                ),
                                onPressed: (){
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context)=>LoginPhone()));

                                }
                            ),


                          ],
                        ),

                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );

  }

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




    final User _newcus = (await _firebaseAuth.createUserWithEmailAndPassword
      (email: emailTextEditingController.text,
        password: passwordTextEditingController.text
    ).catchError((errMsg){
      Navigator.pop(context);
      displayToastMessage("Error "+errMsg.toString(), ctx);
    })
    ).user;

    if (_newcus!=null)
    {
      Map cusDataMap={
          "name":nameTextEditingController.text.trim(),
          "email":emailTextEditingController.text.trim(),
          "password":passwordTextEditingController.text.trim(),
        };
        usersRef.child(_newcus.uid).set(cusDataMap);
        displayToastMessage("New Customer account has created ",ctx);

        Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (context)=>Home()));

      }
    else
      {
        Navigator.pop(context);
        displayToastMessage("New Customer account has not created",ctx);
      }
  }
  displayToastMessage(String message,BuildContext ctx1)
  {
    Fluttertoast.showToast(msg: message);
  }

}

