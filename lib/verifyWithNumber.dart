import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';

class verifyWithNumber extends StatefulWidget {
  @override
  _verifyWithNumberState createState() => _verifyWithNumberState();
}

class _verifyWithNumberState extends State<verifyWithNumber> {

  TextEditingController phoneTextEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    void moveToTheLastScreen() {
      Navigator.pop(context);
    };

    String _phone;
    void onPhoneNumberChange(String number, String internationalizedPhoneNumber, String isoCode) {
      setState(() {
        _phone = internationalizedPhoneNumber;
        print(_phone);
      });
    }
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
                                  /*TextField(
                                    controller:phoneTextEditingController,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      labelText: "Phone number",
                                      labelStyle: TextStyle(fontSize: 22
                                      ),
                                      hintStyle:TextStyle(
                                        color:Colors.grey,
                                        fontSize:10.0,
                                      ),
                                    ),
                                  ),
                                  */

                               InternationalPhoneInput(
                                  decoration: InputDecoration(
                                      labelText: "Phone number",
                                      labelStyle: TextStyle(fontSize: 22
                                      ),),
                                  onPhoneNumberChange: onPhoneNumberChange,
                                  initialPhoneNumber: _phone,
                                  initialSelection: "US",
                                  showCountryCodes: true
                                  ),

                                  SizedBox(height:20.0,),
                                  RaisedButton(
                                      color: Colors.yellow,
                                      textColor: Colors.white,
                                      child: Container(
                                        child: Text("Continue",style: TextStyle(fontSize: 18,fontFamily: "Brand Bold"),),
                                      ),
                                      onPressed: (){

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
}
