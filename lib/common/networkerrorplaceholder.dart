import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';

class NetworkErrorPlaceholder extends StatelessWidget {
  const NetworkErrorPlaceholder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 96,
            color: Colors.red.shade500,
          ),
          SizedBox(height: 12,),
          Text(
            'OOOPS !!! \nSomething went wrong.',
            textAlign: TextAlign.center,
            style: MyStyles.headerTextStyle
                .copyWith(fontSize:24,color: MyColors.headerBg),
              
          ),
        ],
      ));
  }
}