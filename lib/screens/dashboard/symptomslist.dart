import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';

class SymptomPreventionListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const SymptomPreventionListTile(
      {Key key, @required this.text, @required this.icon, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      child: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              width: 160,
              height: 160,
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
                  color: color, borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                child: Text(
                  text,
                  style: MyStyles.cardDescTextStyle,
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
