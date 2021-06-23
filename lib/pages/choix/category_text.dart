import 'package:flutter/material.dart';



class CategorySelect extends StatelessWidget {
  const CategorySelect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Please select your category To sign in",style: Theme.of(context).textTheme.bodyText2.copyWith(
        color: Colors.black54
    ),);
  }
}