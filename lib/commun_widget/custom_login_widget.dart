import 'package:flutter/material.dart';



class CustomSignIn extends StatelessWidget {
  const CustomSignIn({
    Key key,@required this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("You have already  an Account? "),
        TextButton(onPressed: press, child: Text("Sign In",))
      ],
    );
  }
}
