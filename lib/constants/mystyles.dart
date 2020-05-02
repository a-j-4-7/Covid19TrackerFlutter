import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  MyStyles._();

    static TextStyle headerTextStyle = GoogleFonts.montserrat(
      fontSize: 30,fontWeight: FontWeight.w800,color: Colors.white,
    );


    static TextStyle subHeaderTextStyle = GoogleFonts.montserrat(
      fontSize: 8,fontWeight: FontWeight.bold,color: Colors.white54,
    );

  static TextStyle cardDescTextStyle = GoogleFonts.poppins(
    fontSize: 14,fontWeight: FontWeight.bold,color: Colors.black87,
  );

  static BoxDecoration myBoxD({Color bgColor = const Color(0xFFE5EEFD)}) {
  return BoxDecoration(
    color: bgColor,
    shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(4, 4),
      ),
      BoxShadow(
        color: Colors.white,
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(-4, -4),
      ),
    ],
  );
}

}


