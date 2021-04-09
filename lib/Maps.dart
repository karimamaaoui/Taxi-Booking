import 'package:flutter/material.dart';

class Maps extends StatefulWidget{
  @override
  _Maps createState() => _Maps();


}

class _Maps extends State<Maps> {
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
            appBar: AppBar(title: Text("Customer Side"),
              backgroundColor: Color.fromRGBO(240, 160, 50, 1.0),
              leading: IconButton(icon: Icon(Icons.arrow_back),
                  onPressed: (){moveToTheLastScreen();}
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration:BoxDecoration(image: DecorationImage(image:
              AssetImage('assets/yellow.jpg'),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.yellow, BlendMode.colorDodge)
              ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text("Welcome",style: TextStyle(fontSize: 35),),
                  ],
                ),
              ),

            )
        )
    );

  }

}

