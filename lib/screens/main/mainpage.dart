import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/screens/about/aboutpage.dart';
import 'package:covid19_tracker/screens/countrylist/countrylist.dart';
import 'package:covid19_tracker/screens/dashboard/dashboard.dart';
import 'package:covid19_tracker/screens/news/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    _tabController = TabController(length: 4, vsync: this);
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
              icon: Icon(
                Icons.dashboard,
                color: Colors.blueGrey.shade700,
              ),
            ),
            BottomNavItem(
              icon: Icon(
                Icons.public,
                color: Colors.blueGrey.shade700,
              ),
            ),
            BottomNavItem(
              icon: SvgPicture.asset(
                'assets/news.svg',
                color: Colors.blueGrey.shade700,
                height: 20,
                width: 20,
              ),
            ),
            BottomNavItem(
              icon: Icon(
                Icons.person_pin,
                color: Colors.blueGrey.shade700,
              ),
            ),
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
          NewsPage(),
          AboutPage(),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final Widget icon;

  const BottomNavItem({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          icon,
          SizedBox(
            height: 6,
          ),
        ],
      ),
    );
  }
}
