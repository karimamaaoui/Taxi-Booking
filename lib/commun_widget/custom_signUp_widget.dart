import 'package:flutter/material.dart';



class CustomSignUp extends StatelessWidget {
  const CustomSignUp({
    Key key,@required this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don\'t have an Account? "),
        TextButton(onPressed: press, child: Text("Sign Up",))
      ],
    );
  }
}
