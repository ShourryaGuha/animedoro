import 'package:flutter/material.dart';
import 'constants.dart';

class Icon_fill extends StatelessWidget {

  final IconData icon;
  final String text;
  Icon_fill({@required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 80.0,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          text,
          style: kLABEL_TEXT_STYLE,
        )
      ],
    );
  }
}