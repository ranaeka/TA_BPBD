import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonHome extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final double iconSize;
  final String title;
  final Color titleColor;
  final Function onPressed;

  const ButtonHome(
      {Key key,
      this.iconData,
      this.iconColor=Colors.white,
      this.iconSize=35,
      this.title,
      this.titleColor=Colors.white,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      child: Column(
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: iconSize,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "$title",
            style: TextStyle(color: titleColor),
          )
        ],
      ),
    );
  }
}
