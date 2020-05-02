import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';

class SymptomsList extends StatelessWidget{

  final String text;

  const SymptomsList({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(24)),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                  color: Colors.red.shade200,
                  borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              child: Text(
                text,
                style: MyStyles.cardDescTextStyle,
              ),
            ),
          )
        ],
      ),
    );;
  }

}