import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  //create custom Buttons with custom colors and style
  final String text;
  final Color textColor;
  final Color bgColor;
  final Function onPress;
  CustomBtn(
      {@required this.text,
      this.bgColor,
      @required this.onPress,
      @required this.textColor});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(5.0),
        elevation: 1.0,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
