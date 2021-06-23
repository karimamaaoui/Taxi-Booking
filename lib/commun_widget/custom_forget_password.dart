import 'package:flutter/material.dart';




class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    Key key,@required this.press,
  }) : super(key: key);
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(onPressed: press
            , child: Text("Forgot your Password ?"))
      ],
    );
  }
}
