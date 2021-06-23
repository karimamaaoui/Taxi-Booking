import 'package:flutter/material.dart';



class WelcomeText extends StatelessWidget {
  const WelcomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Welcome To TAxi Bi-Bi :",
      style: Theme.of(context)
          .textTheme
          .headline5
          .copyWith(

          fontWeight: FontWeight.bold,
          letterSpacing: 1.0),
    );
  }
}
