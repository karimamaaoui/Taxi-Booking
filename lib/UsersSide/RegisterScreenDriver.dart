/*import 'package:flutter/material.dart';
import 'package:taxi2/Forms/RegisterDriverForm.dart';

class RegisterScreenDriver extends StatefulWidget {
  @override
  _RegisterScreenDriverState createState() => _RegisterScreenDriverState();

}
class _RegisterScreenDriverState extends State<RegisterScreenDriver>{

  @override
  Widget build(BuildContext context) {

    void moveToTheLastScreen()
    {
      Navigator.pop(context);
    };
    return WillPopScope(
        onWillPop :(){
          moveToTheLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(title: Text("Driver Side"),
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
            child : Container(
              child: RegisterForm(),
            ),
          ),
        )
    );

  }

}

*/