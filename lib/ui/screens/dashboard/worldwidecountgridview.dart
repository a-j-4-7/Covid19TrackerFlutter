import 'package:covid19_tracker/ui/screens/dashboard/worlwidecountgridtile.dart';
import 'package:flutter/material.dart';

class WorldwideCountGridView extends StatelessWidget {
  final int totalCases;
  final int activeCases;
  final int deaths;
  final int recoveredCases;
  final int todayCases;
  final int todayDeaths;

  const WorldwideCountGridView({
    Key key,
    @required this.totalCases,
    @required this.activeCases,
    @required this.deaths,
    @required this.recoveredCases,
    @required this.todayCases,
    @required this.todayDeaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(this.todayCases);
    print(this.todayDeaths);
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      width: double.infinity,
      child: GridView.count(
        crossAxisCount: 2,
        physics: NeverScrollableScrollPhysics(),
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          WorldwideCountGridTile(
            totalNumber: totalCases,
            todaysNumber: todayCases,
            title: 'CONFIRMED',
            textColor: Colors.indigo,
            bgColor: Colors.indigo.shade200,
          ),
          WorldwideCountGridTile(
            totalNumber: activeCases,
            title: 'ACTIVE CASES',
            textColor: Colors.yellow[800],
            bgColor: Colors.yellow.shade300,
          ),
          WorldwideCountGridTile(
            totalNumber: recoveredCases,
            title: 'RECOVERED',
            textColor: Colors.green,
            bgColor: Colors.green.shade200,
          ),
          WorldwideCountGridTile(
            totalNumber: deaths,
            todaysNumber: todayDeaths,
            title: 'DEATHS',
            textColor: Colors.red[600],
            bgColor: Colors.red.shade200,
          ),
        ],
      ),
    );
  }
}
