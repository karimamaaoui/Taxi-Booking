import 'package:flutter/material.dart';
import 'package:taxi2/RegisterScreen.dart';

class JoinCollection extends StatefulWidget {
  @override
  _JoinCollectionState createState() => _JoinCollectionState();
}

class _JoinCollectionState extends State<JoinCollection> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
        Column(
          children: [
            SingleChildScrollView(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                  ],
                ),
              ),),

          ],
        ),
      ),
    );
  }
}
