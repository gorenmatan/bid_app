import 'package:flutter/material.dart';
import 'package:flutterbidapp/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  const TextFieldContainer({
    Key key,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      width: size.width * 0.88,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
