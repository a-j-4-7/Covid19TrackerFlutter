import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';


class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.appBgColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'About Me',
                  style:
                      MyStyles.headerTextStyle.copyWith(color: Colors.black87),
                ),
              ),
              Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 16,
                    ),
                    _buildPortfolioImageContainer(),
                    SizedBox(height: 16,),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                        child: Text(
                          'Android  Developer',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      
                      decoration: BoxDecoration(
                        color: MyColors.headerBg,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    _buildContactInfoLayout(),
                    SizedBox(
                      height: 50,
                    ),
                    _buildSocialMediaButtons(),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            indent: 64,
                            color: Colors.grey.shade400,
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          '2020',
                          style: GoogleFonts.montserrat(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Divider(
                            endIndent: 64,
                            color: Colors.grey.shade400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container _buildPortfolioImageContainer() {
    return Container(
      padding: EdgeInsets.all(
        8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: Offset(4, 8),
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: 1,
          ),
          BoxShadow(
            offset: Offset(-4, -8),
            color: Colors.grey.shade300,
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/pp.jpg',
          fit: BoxFit.fill,
          width: 172,
          height: 172,
        ),
      ),
    );
  }

  Widget _buildSocialMediaButtons() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SocialMediaIcon(
            icon: FontAwesomeIcons.facebook,
          ),
          SizedBox(width: 30),
          SocialMediaIcon(
            icon: FontAwesomeIcons.twitter,
          ),
          SizedBox(width: 30),
          SocialMediaIcon(
            icon: FontAwesomeIcons.linkedin,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoLayout() {
    return Column(
      children: <Widget>[
        Text(
          'Sachet Tha Shrestha',
          style: MyStyles.headerTextStyle.copyWith(
            fontSize: 30,
            color: Colors.black87,
          ),
        ),
        Divider(
          color: Colors.grey,
          indent: 100,
          endIndent: 100,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: MyColors.headerBg,
              size: 16,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              'Bhaktapur',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          indent: 160,
          endIndent: 160,
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.phone,
              color: MyColors.headerBg,
              size: 16,
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '9840052922',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Divider(
          color: Colors.grey,
          indent: 200,
          endIndent: 200,
        ),
      ],
    );
  }
}

class SocialMediaIcon extends StatelessWidget {
  final IconData icon;

  const SocialMediaIcon({Key key, @required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      decoration: BoxDecoration(
        color: MyColors.appBgColor,
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
      ),
      child: Icon(
        icon,
        size: 24,
        color: Colors.black54,
      ),
    );
  }
}
