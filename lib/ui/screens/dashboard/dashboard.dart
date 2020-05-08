import 'dart:convert';
import 'dart:io';
import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/dashboardcount.dart';
import 'package:covid19_tracker/data/prevention.dart';
import 'package:covid19_tracker/data/symptom.dart';
import 'package:covid19_tracker/data/worldwidestatspiechartmodel.dart';
import 'package:covid19_tracker/ui/screens/dashboard/dashboardheader.dart';
import 'package:covid19_tracker/ui/screens/dashboard/symptomslist.dart';
import 'package:covid19_tracker/ui/screens/dashboard/worldwidecountgridview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:charts_flutter/flutter.dart' as charts;

const WORLDWIDE_COUNT_API_URL = 'https://corona.lmao.ninja/v2/all';

class DashboardPage extends StatefulWidget {
  final Function(String) onAreaSelectedCallback;

  const DashboardPage({Key key, @required this.onAreaSelectedCallback})
      : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardCount _dashboardCount;
  List<charts.Series<WorldwideStatsPieChartModel, String>> _seriesList;

  @override
  void initState() {
    super.initState();
    _fetchWorldwideStats();
  }

  _fetchWorldwideStats() async {
    var response = await http.get(WORLDWIDE_COUNT_API_URL);
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      print("DECODED JSON RESULT =>" + decodedJson.toString());
      if (!mounted) return;
      setState(() {
        _dashboardCount = DashboardCount(
          totalDeathCount: decodedJson['deaths'],
          totalRecoveredCasesCount: decodedJson['recovered'],
          totalActiveCasesCount: decodedJson['active'],
          totalConfirmedCasesCount: decodedJson['cases'],
        );
        print("DASHBOARDCOUNT RESULT =>" + _dashboardCount.toString());

        _buildPieChartSeriesList(_dashboardCount);
      });
    } else {
      print("HTTP ERROR");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: BoxConstraints.expand(),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                DashboardHeader(
                  onCheckYourAreaPressed: (selectedArea) {
                    setState(
                      () {
                        print('clicked');
                        print('Selected Area =>' + selectedArea);
                        widget.onAreaSelectedCallback(selectedArea);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 24,
                ),
                _buildSectionTitle('Worldwide Counter'),
                if (_dashboardCount != null) _buildWorldwideStatsPieChart(),
                _buildWorldwideCounterGrid(),
                _buildSectionTitle('Symptoms'),
                _buildSymptomsLayout(),
                SizedBox(
                  height: 16,
                ),
                _buildSectionTitle('Prevention'),
                _buildPreventionLayout(),
                SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildPreventionLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (var prevention in Prevention.getPrevention())
              SymptomPreventionListTile(
                  text: prevention.title,
                  color: Colors.yellow.shade600,
                  icon: Icons.beenhere)
          ],
        ),
      ),
    );
  }

  Padding _buildSymptomsLayout() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            for (var symptom in Symptom.getSymptoms())
              SymptomPreventionListTile(
                text: symptom.title,
                color: Colors.red.shade300,
                icon: Icons.warning,
              )
          ],
        ),
      ),
    );
  }

  Container _buildSectionTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
          border: Border(left: BorderSide(color: MyColors.headerBg, width: 4))),
      child: Text(title,
          style: MyStyles.headerTextStyle
              .copyWith(color: Colors.black, fontSize: 24)),
    );
  }

  Widget _buildWorldwideCounterGrid() {
    return WorldwideCountGridView(
        activeCases: _dashboardCount != null
            ? _dashboardCount.getTotalActiveCasesCount
            : 0,
        deaths:
            _dashboardCount != null ? _dashboardCount.getTotalDeathCount : 0,
        recoveredCases:
            _dashboardCount != null ? _dashboardCount.getTotalRecoverdCount : 0,
        totalCases: _dashboardCount != null
            ? _dashboardCount.getTotalConfirmedCasesCount
            : 0);
  }

  Widget _buildWorldwideStatsPieChart() {
    return Container(
      margin: EdgeInsets.only(top: 16,),
      height: 220,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: charts.PieChart(_seriesList,
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                  arcRendererDecorators: [
                    new charts.ArcLabelDecorator(
                        //labelPadding:-25,
                        labelPosition: charts.ArcLabelPosition.outside),
                  ],
                  arcWidth: 50,
                )),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,width: 50,
              decoration: MyStyles.myBoxD(),
            ),
          )
        ],
      ),
    );
  }

  void _buildPieChartSeriesList(DashboardCount dashboardCount) {
    final pieData = [
      WorldwideStatsPieChartModel(
          title: 'Confirmed',
          number: dashboardCount.getTotalConfirmedCasesCount),
      WorldwideStatsPieChartModel(
          title: 'Active', number: dashboardCount.getTotalActiveCasesCount),
      WorldwideStatsPieChartModel(
          title: 'Deaths', number: dashboardCount.getTotalDeathCount),
      WorldwideStatsPieChartModel(
          title: 'Recovered', number: dashboardCount.getTotalRecoverdCount),
    ];

    _seriesList = [
      charts.Series<WorldwideStatsPieChartModel, String>(
        id: 'Global Stats',
        domainFn: (WorldwideStatsPieChartModel index, _) => index.title,
        measureFn: (WorldwideStatsPieChartModel index, _) => index.number,
        labelAccessorFn: (WorldwideStatsPieChartModel index, _) =>
            '${index.title}',
        // colorFn: (WorldwideStatsPieChartModel index, _)=> {
        //   return
        // },
        colorFn: (WorldwideStatsPieChartModel index, _) {
          switch (index.title) {
            case 'Deaths':
              return charts.MaterialPalette.red.shadeDefault;
              break;
            case 'Active':
              return charts.MaterialPalette.yellow.shadeDefault;
              break;
            case 'Confirmed':
              return charts.MaterialPalette.indigo.shadeDefault;
              break;
            case 'Recovered':
              return charts.MaterialPalette.green.shadeDefault;
              break;
            default:
              return charts.MaterialPalette.red.shadeDefault;
          }
        },
        data: pieData,
      )
    ];
  }
}
