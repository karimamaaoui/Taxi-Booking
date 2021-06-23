import 'package:flutter/material.dart';

class CustomTextReset extends StatelessWidget {
  const CustomTextReset({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please Enter Your email to \n Get Started",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
