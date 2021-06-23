import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Please Sign In To\n Get Started",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontWeight: FontWeight.bold),
    );
  }
}
