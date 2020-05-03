import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/screens/about/aboutpage.dart';
import 'package:covid19_tracker/screens/countrylist/countrylist.dart';
import 'package:covid19_tracker/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int tabIndex = 0;
  String _selectedArea;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
      if (tabIndex != 1) _selectedArea = null;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        child: TabBar(
          indicatorColor: MyColors.headerBg,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 4,
          tabs: <Widget>[
            BottomNavItem(
                icon: Icons.dashboard,
                indicatorColor:
                    tabIndex == 0 ? MyColors.headerBg : Colors.transparent),
            BottomNavItem(
                icon: Icons.map,
                indicatorColor:
                    tabIndex == 1 ? MyColors.headerBg : Colors.transparent),
            BottomNavItem(
                icon: Icons.info,
                indicatorColor:
                    tabIndex == 2 ? MyColors.headerBg : Colors.transparent),
          ],
          controller: _tabController,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          DashboardPage(
            onAreaSelectedCallback: (selectedArea) {
              setState(() {
                _selectedArea = selectedArea;
                _tabController.animateTo(1);
              });
            },
          ),
            CountryListPage(
              countryName: _selectedArea,
            ),
          AboutPage(),
        ],
      ),
    );
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
            color: Colors.blueGrey.shade700,
          ),
          SizedBox(
            height: 6,
          ),
         
        ],
      ),
    );
  }
}
