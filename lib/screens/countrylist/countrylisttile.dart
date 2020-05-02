import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/country.dart';
import 'package:covid19_tracker/data/countryDTO.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryListTile extends StatelessWidget {
  final CountryDTO country;

  const CountryListTile({Key key, this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    country.imageUrl,
                    fit: BoxFit.fill,
                    width: 36,
                    height: 24,
                  ),
                ),
                SizedBox(width: 8,),
                Text(
                  country.countryName,
                  style: MyStyles.headerTextStyle.copyWith(fontSize:20,color: Colors.black87),
                )
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: _buildColorInfoItem(
                    textColor: Colors.blue, title: country.active.toString()),
              ),
              Expanded(
                child: _buildColorInfoItem(
                    textColor: Colors.green,
                    title: country.recovered.toString()),
              ),
              Expanded(
                child: _buildColorInfoItem(
                    textColor: Colors.red, title: country.deaths.toString()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container _buildColorInfoItem(
      {@required Color textColor, @required String title}) {
    return Container(
      padding: EdgeInsets.only(bottom: 16,),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(color: textColor, shape: BoxShape.circle),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            title,
            style: MyStyles.subHeaderTextStyle.copyWith(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
