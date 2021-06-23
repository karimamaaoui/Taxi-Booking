import 'package:flutter/material.dart';

class CustomTextSignUp extends StatelessWidget {
  const CustomTextSignUp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please Sign Up To\n Get Started",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
