import 'package:flutter/material.dart';

class Progress extends StatelessWidget {

  final int done, total;

  Progress({this.done, this.total});

  @override
  Widget build(BuildContext context) {
    const notDoneIcon = Icon(
      Icons.assignment_turned_in_outlined,
      color: Colors.redAccent,
      size: 35,
    );
    const doneIcon = Icon(
      Icons.assignment_turned_in,
      color: Colors.green,
      size: 35,
    );

    List <Icon> progressIndicator = [];

    for(int i = 0; i < total; i++ ) {
      if(i < done)
        progressIndicator.add(doneIcon);
      else
        progressIndicator.add(notDoneIcon);
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,

      children: progressIndicator,
    );
  }
}
