import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/Forms/RegisterDriverForm.dart';
import 'package:taxi2/Forms/loginDriver.dart';
import 'package:taxi2/Widget/progressDialog.dart';

class loginDriverForm extends StatefulWidget {
  @override
  _loginDriverFormState createState() => _loginDriverFormState();

}
TextEditingController emailTextEditingController=TextEditingController();
TextEditingController passwordTextEditingController=TextEditingController();

class _loginDriverFormState extends State<loginDriverForm>{

  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();

    return Container(
      child: SingleChildScrollView(
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

                                    loginDriver();
                                  }
                                }
                            ),
                          ],
                        ),
                      ), FlatButton (

                        onPressed:()
                        {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context)=>RegisterForm()));
                        },
                        child: Text("create a new account"),

                      ),

                    ],
                  ),

                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
displayToastMessage(String message,BuildContext ctx1)
{
  Fluttertoast.showToast(msg: message);
}

