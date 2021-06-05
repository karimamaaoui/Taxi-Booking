import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxi2/OPScreen.dart';
import '../loginScreenDriver.dart';


class RegisterForm  extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();

}

List <String> listOfCountries =<String> ["Tunisia", "Bizerte", "Sousse","Ben Arous"];
var dropdownValue ;

TextEditingController nameTextEditingController = TextEditingController();
TextEditingController emailTextEditingController = TextEditingController();
TextEditingController passwordTextEditingController = TextEditingController();
TextEditingController phoneTextEditingController = TextEditingController();


String email, password, name, phone;
var index;


class _RegisterFormState extends State<RegisterForm> {

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
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(height: 5.0),
                      Image(
                        image: AssetImage("assets/driver.jpg"),
                        width: 290.0,
                        height: 150.0,
                        alignment: Alignment.center,

                      ),
                      SizedBox(height: 5.0,),
                      Text("Create new Driver account ",
                        style: TextStyle(fontSize: 32, color: Color.fromRGBO(
                            240, 160, 50, 1.0)),
                        textAlign: TextAlign.center,),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(height: 5.0,),
                            TextFormField(
                              controller: nameTextEditingController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: "Name",
                                labelStyle: TextStyle(fontSize: 14
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),
                            ),
                            TextFormField(
                              controller: emailTextEditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: "Email",
                                labelStyle: TextStyle(fontSize: 14
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                              ),


                            ),
                            Container(

                              child: TextFormField(

                                decoration: InputDecoration(
                                  labelText: "Phone number",
                                  labelStyle: TextStyle(fontSize: 14
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 10.0,
                                  ),

                                  prefix: Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Text('+216',style:TextStyle(fontSize: 17),),
                                  ),
                                ),
                                maxLength: 10,
                                keyboardType: TextInputType.number,
                                controller: phoneTextEditingController,
                              ),


                            ),
                            Padding(
                              padding: EdgeInsets.all(20.0),
                              child: DropdownButtonFormField(
                                items: listOfCountries.map(
                                        (value) => DropdownMenuItem(
                                          child:Text(value),
                                            value:value,
                                        )).toList(),
                                onChanged: (selectedCountry){
                                  setState(() {
                                    dropdownValue=selectedCountry;
                                  });
                                },
                                value: dropdownValue,
                                isExpanded: false,
                                hint: Text('Choose Country'),
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
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10.0,
                                ),
                                suffixIcon:
                                IconButton(
                                  icon: Icon(this.passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      this.passwordVisible =
                                      !this.passwordVisible;
                                    });
                                  },
                                ),
                              ),
                            ), SizedBox(height: 20.0,),

                            RaisedButton(
                              color: Colors.yellow,
                              textColor: Colors.white,
                              child: Container(
                                child: Text("Next", style: TextStyle(
                                    fontSize: 18, fontFamily: "Brand Bold"),),
                              ),
                              onPressed: () async {
                                if (nameTextEditingController.text.length < 3) {
                                  displayToastMessage(
                                      "Name must be at least 3 caracters ",
                                      context);
                                }
                                else
                                if (!emailTextEditingController.text.contains(
                                    '@')) {
                                  displayToastMessage(
                                      "Email address invalid ", context);
                                }
                                else
                                if (passwordTextEditingController.text.length <
                                    6) {
                                  displayToastMessage(
                                      "Password must be at least 6 caracters ",
                                      context);
                                }
                                else
                                if (phoneTextEditingController.text.length <
                                    8) {
                                  displayToastMessage(
                                      "Phone number must be 8 chirrefes ",
                                      context);
                                }
                                else {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) =>
                                          OTPScreen(phoneTextEditingController
                                              .text)));
                                }
                              },
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(
                                  builder: (context) => loginScreenDriver()));
                        }, child: Text("Already have an account ? Login here"),

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

