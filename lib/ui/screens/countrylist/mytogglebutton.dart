import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum StatType { TODAY, TOTAL }

Color buttonActiveColor = Colors.green.shade700;
Color buttonInActiveColor = Colors.green.withOpacity(0.7);
const Color buttonActiveTextColor = Colors.white;
Color buttonInActiveTextColor = Colors.white;

class MyToggleButton extends StatelessWidget {

  final String title;
  final Color bgColor;
  final Color textColor;

  const MyToggleButton({Key key,@required this.title, @required this.bgColor, @required this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          child : Container(
            padding: EdgeInsets.all(0),
            width: 120,
            height: 36,
            child: Center(
              child: Text(
                  title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: textColor,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(24),
            ),
          ),
    );
  }
}
