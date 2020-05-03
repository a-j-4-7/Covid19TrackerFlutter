import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/countrydropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardHeader extends StatefulWidget {
  final Function(String) onCheckYourAreaPressed;

  const DashboardHeader({Key key, @required this.onCheckYourAreaPressed})
      : super(key: key);

  @override
  _DashboardHeaderState createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  String _dropDownValue = 'Select your country';
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
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Check Area Stats',
                          softWrap: true,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white24),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              ),
                              iconSize: 20,
                              onChanged: (selectedValue) {
                                setState(() {
                                  _dropDownValue = selectedValue;
                                });
                              },
                              items: CountryDropdown.getCountryDropdownList
                                  .map((country) => DropdownMenuItem<String>(
                                        child: Text(
                                          country,
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                        value: country,
                                      ))
                                  .toList(),
                              value: _dropDownValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    if (_dropDownValue == 'Select your country') {
                      _showSnackbar(context);
                    } else {
                      widget.onCheckYourAreaPressed(_dropDownValue);
                    }
                  },
                  child: Container(
                    width: 72,
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
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        'ERROR !!! Please select a country first.',
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ));
  }
}
