import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  // ignore: non_constant_identifier_names
  RoundIconButton({@required this.icon_child, @required this.onPressed});
  // ignore: non_constant_identifier_names
  final IconData icon_child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0,
      child: Icon(icon_child),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}

