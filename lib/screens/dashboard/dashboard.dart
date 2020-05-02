import 'dart:io';
import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/dashboardcount.dart';
import 'package:covid19_tracker/data/prevention.dart';
import 'package:covid19_tracker/data/symptom.dart';
import 'package:covid19_tracker/network/apiservice.dart';
import 'package:covid19_tracker/network/apiserviceimpl.dart';
import 'package:covid19_tracker/screens/about/aboutpage.dart';
import 'package:covid19_tracker/screens/countrylist/countrylist.dart';
import 'package:covid19_tracker/screens/dashboard/dashboardheader.dart';
import 'package:covid19_tracker/screens/dashboard/symptomslist.dart';
import 'package:covid19_tracker/screens/dashboard/worldwidecountgridview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  double _height, _width;
  int currentBottomBarIndex = 0;
  String filteredArea;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 8.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  child: BottomNavItem(
                    icon: Icons.dashboard,
                    indicatorColor: currentBottomBarIndex == 0
                        ? MyColors.headerBg
                        : Colors.transparent,
                  ),
                  onTap: () {
                    setState(() {
                      currentBottomBarIndex = 0;
                      filteredArea = null;
                    });
                  },
                ),
                GestureDetector(
                  child: BottomNavItem(
                    icon: Icons.map,
                    indicatorColor: currentBottomBarIndex == 1
                        ? MyColors.headerBg
                        : Colors.transparent,
                  ),
                  onTap: () {
                    setState(() {
                      currentBottomBarIndex = 1;
                    
                    });
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => CountryListPage(null)));
                  },
                ),
                GestureDetector(
                  child: BottomNavItem(
                    icon: Icons.info,
                    indicatorColor: currentBottomBarIndex == 2
                        ? MyColors.headerBg
                        : Colors.transparent,
                  ),
                  onTap: () {
                    setState(() {
                      currentBottomBarIndex = 2;
                      filteredArea = null;
                    });
                  },
                ),
              ],
            ),
          ),
          body:_switchPages(currentBottomBarIndex)),
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

  Widget _switchPages(int index){
  switch(index){
    case 0: 
    return  Container(
                  constraints: BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        DashboardHeader(onPressed: (){
                          setState(() {
                            print('clicked');
                            currentBottomBarIndex = 1;
                            filteredArea = 'Nepal';
                          });
                        },),
                        SizedBox(
                          height: 24,
                        ),
                        _buildSectionTitle('Worldwide Counter'),
                        _buildWorldwideCounterGrid(),
                        _buildSectionTitle('Symptoms'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                for (var symptom in Symptom.getSymptoms())
                                  SymptomsList(text: symptom.title)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        _buildSectionTitle('Prevention'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: <Widget>[
                                for (var prevention
                                    in Prevention.getPrevention())
                                  SymptomsList(text: prevention.title)
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 36,
                        ),
                      ],
                    ),
                  ),
                );
    break;
    case 1:
    return CountryListPage(filteredArea);
    case 2:
    return AboutPage();
    break;
  }
}

}


class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final Color indicatorColor;

  const BottomNavItem({@required this.icon, @required this.indicatorColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: indicatorColor,
              shape: BoxShape.circle,
            ),
          )
        ],
      ),
    );
  }
}
