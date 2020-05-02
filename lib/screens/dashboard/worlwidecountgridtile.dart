import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldwideCountGridTile extends StatelessWidget {
  final String title;
  final String number;
  final Color textColor;
  final Color bgColor;

  const WorldwideCountGridTile(
      {Key key,
      @required this.title,
      @required this.number,
      @required this.textColor,
      @required this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 8,
                    width: 8,
                    decoration:
                        BoxDecoration(color: textColor, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Text(
                    title,
                    style: MyStyles.subHeaderTextStyle.copyWith(
                      color: Colors.black45,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                number,
                style: MyStyles.headerTextStyle
                    .copyWith(color: textColor, fontSize: 30),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Icon(
              Icons.trending_up,
              color: Colors.white,
              size: 48,
            ),
          )
        ],
      ),
    );
  }
}
