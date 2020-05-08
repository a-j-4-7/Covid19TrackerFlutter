import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';

class ErrorPlaceholder extends StatelessWidget {

  final String errorMsg;
  final IconData iconData;

  const ErrorPlaceholder({Key key,@required this.errorMsg,@required this.iconData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
          size: 96,
          color: Colors.yellow.shade800,
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          errorMsg,
          textAlign: TextAlign.center,
          style: MyStyles.headerTextStyle
              .copyWith(fontSize: 24, color: Colors.blueGrey.shade700),
        ),
      ],
    ));
  }
}