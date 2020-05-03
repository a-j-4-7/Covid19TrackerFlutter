import 'dart:io';
import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/dashboardcount.dart';
import 'package:covid19_tracker/data/prevention.dart';
import 'package:covid19_tracker/data/symptom.dart';
import 'package:covid19_tracker/network/apiservice.dart';
import 'package:covid19_tracker/network/apiserviceimpl.dart';
import 'package:covid19_tracker/screens/dashboard/dashboardheader.dart';
import 'package:covid19_tracker/screens/dashboard/symptomslist.dart';
import 'package:covid19_tracker/screens/dashboard/worldwidecountgridview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {

  final Function(String) onAreaSelectedCallback;

  const DashboardPage({Key key, @required this.onAreaSelectedCallback}) : super(key: key);


  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
          body:  Container(
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

  FutureBuilder<DashboardCount> _buildWorldwideCounterGrid() {
    ApiService apiService = ApiServiceImpl();
    return FutureBuilder<DashboardCount>(
      future: apiService.getWorldwideCount(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return WorldwideCountGridView(
              activeCases: snapshot.data.totalActiveCasesCount,
              deaths: snapshot.data.totalDeathCount,
              recoveredCases: snapshot.data.totalRecoveredCasesCount,
              totalCases: snapshot.data.totalConfirmedCasesCount);
        } else if (snapshot.hasError) {
          return WorldwideCountGridView(
              activeCases: '0',
              deaths: '0',
              recoveredCases: '0',
              totalCases: '0');
        }
        return WorldwideCountGridView(
            activeCases: '0',
            deaths: '0',
            recoveredCases: '0',
            totalCases: '0');
      },
    );
  }

  
}


