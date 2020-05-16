import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorldwideCountGridTile extends StatelessWidget {
  final String title;
  final int totalNumber;
  final int todaysNumber;
  final Color textColor;
  final Color bgColor;

  const WorldwideCountGridTile(
      {Key key,
      @required this.title,
      @required this.totalNumber,
      this.todaysNumber,
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
                totalNumber.toString(),
                style: MyStyles.headerTextStyle
                    .copyWith(color: textColor, fontSize: 30),
              ),
            ],
          ),
          if (todaysNumber != null && todaysNumber != 0)
            Positioned(
                bottom: 0,
                right: 0,
                child: Row(
                  children: <Widget>[
                    Text(
                      '+ ${todaysNumber.toString()}',
                      style: GoogleFonts.montserrat(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Icon(
                      Icons.arrow_upward,
                      color: textColor,
                      size: 16,
                    ),
                  ],
                )),
        ],
      ),
    );
  }
}
