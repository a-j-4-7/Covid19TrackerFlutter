import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/screens/countrylist/countrylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onPressed;

  const DashboardHeader({Key key, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
          color: MyColors.headerBg,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(36),
            bottomRight: Radius.circular(36),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: 'Covid-19',
              style: MyStyles.headerTextStyle.copyWith(color: Colors.red),
              children: [
                WidgetSpan(
                  child: SizedBox(
                    width: 4,
                  ),
                ),
                TextSpan(
                    text: '.',
                    style:
                        MyStyles.headerTextStyle.copyWith(color: Colors.red)),
                WidgetSpan(
                  child: SizedBox(
                    width: 8,
                  ),
                ),
                TextSpan(text: 'Tracker', style: MyStyles.headerTextStyle),
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text('#STAYHOME #STAYSAFE',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white70,
              )),
          SizedBox(
            height: 16,
          ),
          Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SvgPicture.asset(
                              'assets/nepal.svg',
                              height: 16,
                              width: 16,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              'Nepal',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Check Area Stats',
                        softWrap: true,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      height: 72,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward,
                          size: 36,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
