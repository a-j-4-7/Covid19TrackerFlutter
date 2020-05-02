import 'dart:convert';
import 'dart:math';

import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/country.dart';
import 'package:covid19_tracker/data/countryDTO.dart';
import 'package:covid19_tracker/network/apiservice.dart';
import 'package:covid19_tracker/network/apiserviceimpl.dart';
import 'package:covid19_tracker/screens/countrylist/countrylisttile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'mytogglebutton.dart';

enum SelectedStats { TODAY, TOTAL }

const COUNTRIES_API_URL = 'https://corona.lmao.ninja/v2/countries?sort=cases';

class CountryListPage extends StatefulWidget {
  final String _countryName;

  CountryListPage(this._countryName);

  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  SelectedStats _selectedStats = SelectedStats.TOTAL;
  bool _isSearchEnabled = false;
  bool _isLoading = true;
  final TextEditingController textEditingController = TextEditingController();
  List newCountriesList = [];
  List newCountriesFilteredList = [];

  @override
  void initState() {
    super.initState();
    fetchCountryStats();
  }

  fetchCountryStats() async {
    final response =
        await http.get(COUNTRIES_API_URL);
    if (response.statusCode == 200) {
      setState(() {
        _isLoading = false;
        newCountriesList = newCountriesFilteredList = jsonDecode(response.body);
      });
    } else {
       throw Exception('IO Error');
    }
    
  }

  @override
  Widget build(BuildContext context) {
    print("Passed Data =>" + widget._countryName.toString());
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          color: MyColors.appBgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                children: _buildCustomAppBar(context),
              ),
              SizedBox(
                height: 16,
              ),
              _buildStatsToggleLayout(),
              SizedBox(
                height: 16,
              ),
              _buildColorInfoLayout(),
              SizedBox(
                height: 8,
              ),
              if (widget._countryName == 'Nepal') ...[
                _getCountryByArea()
              ] else ...[
                _getAllCountries()
              ],
            ],
          ),
        ),
      ),
    );
  }

  Container _buildColorInfoLayout() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: _buildColorInfoItem(
                textColor: Colors.blue,
                title: _selectedStats == SelectedStats.TOTAL
                    ? 'ACTIVE'
                    : 'NEW CASES'),
          ),
          Expanded(
            child: _buildColorInfoItem(
                textColor: Colors.green, title: 'RECOVERED'),
          ),
          Expanded(
            child: _buildColorInfoItem(textColor: Colors.red, title: 'DEATHS'),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCustomAppBar(BuildContext context) {
    return <Widget>[
      if (_isSearchEnabled) ...[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(24),
            ),
            child: TextField(
              controller: textEditingController,
              onChanged: (onChangedValue) {
                print("onChangedVlaue =>" + onChangedValue.toString());
                print("HERE =>" + newCountriesFilteredList.toString());
                setState(() {
                  var list = newCountriesList
                      .where((country) => country['country']
                          .toLowerCase()
                          .contains(onChangedValue))
                      .toList();
                  print("Filtered LIst =>" + list.toString());
                  newCountriesFilteredList = list;
                });
              },
              decoration: InputDecoration(
                hintText: 'Type Country Name',
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ] else ...[
        Expanded(
          child: Text(
            'Countries',
            style: MyStyles.headerTextStyle.copyWith(color: Colors.black87),
          ),
        ),
      ],
      GestureDetector(
        onTap: () {
          setState(() {
            _isSearchEnabled = !_isSearchEnabled;
          });
        },
        child: _isSearchEnabled
            ? Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: GestureDetector(
                  onTap: () {
                    textEditingController.clear();
                    setState(() {
                      newCountriesFilteredList = newCountriesList;
                    });
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black87,
                    size: 32,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.black87,
                  size: 32,
                ),
              ),
      ),
    ];
  }

  Container _buildStatsToggleLayout() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.7),
          borderRadius: BorderRadius.circular(36)),
      child: ButtonBar(
        mainAxisSize: MainAxisSize.min,
        alignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedStats = SelectedStats.TODAY;
              });
            },
            child: MyToggleButton(
              title: 'Today',
              bgColor: _selectedStats == SelectedStats.TODAY
                  ? buttonActiveColor
                  : Colors.transparent,
              textColor: Colors.white,
            ),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  _selectedStats = SelectedStats.TOTAL;
                });
              },
              child: MyToggleButton(
                title: 'Total',
                bgColor: _selectedStats == SelectedStats.TOTAL
                    ? buttonActiveColor
                    : Colors.transparent,
                textColor: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget _getAllCountries() {
    return Expanded(
      child: _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ListView.builder(
              shrinkWrap: true,
              itemCount: newCountriesFilteredList.length,
              itemBuilder: (context, index) {
                return CountryListTile(
                    country: CountryDTO(
                  countryName: newCountriesFilteredList[index]['country'],
                  active: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['active'].toString()
                      : newCountriesFilteredList[index]['todayCases']
                          .toString(),
                  deaths: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['deaths'].toString()
                      : newCountriesFilteredList[index]['todayDeaths']
                          .toString(),
                  recovered: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['recovered'].toString()
                      : 'No Data',
                  imageUrl: newCountriesFilteredList[index]['countryInfo']
                      ['flag'],
                ));
              }),
    );
  }

  Widget _getCountryByArea() {
    newCountriesFilteredList = newCountriesFilteredList
        .where((country) => country['country'] == 'Nepal')
        .toList();
    return Expanded(
      child:  _isLoading
          ? Center(child: CircularProgressIndicator(),)
          : ListView.builder(
              shrinkWrap: true,
              itemCount: newCountriesFilteredList.length,
              itemBuilder: (context, index) {
                return CountryListTile(
                    country: CountryDTO(
                  countryName: newCountriesFilteredList[index]['country'],
                  active: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['active'].toString()
                      : newCountriesFilteredList[index]['todayCases']
                          .toString(),
                  deaths: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['deaths'].toString()
                      : newCountriesFilteredList[index]['todayDeaths']
                          .toString(),
                  recovered: _selectedStats == SelectedStats.TOTAL
                      ? newCountriesFilteredList[index]['recovered'].toString()
                      : 'No Data',
                  imageUrl: newCountriesFilteredList[index]['countryInfo']
                      ['flag'],
                ));
              }),
    );
  }
}

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
        SizedBox(
          height: 12,
        ),
        Text(
          'OOOPS !!! \nSomething went wrong.',
          textAlign: TextAlign.center,
          style: MyStyles.headerTextStyle
              .copyWith(fontSize: 24, color: MyColors.headerBg),
        ),
      ],
    ));
  }
}

Container _buildColorInfoItem(
    {@required Color textColor, @required String title}) {
  return Container(
    padding: EdgeInsets.all(8),
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
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

class StatsToggleLayout extends StatefulWidget {
  @override
  _StatsToggleLayoutState createState() => _StatsToggleLayoutState();
}

class _StatsToggleLayoutState extends State<StatsToggleLayout> {
  List<bool> _selection = [false, true];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
      ),
      child: Center(
        child: ToggleButtons(
          color: Colors.green.withOpacity(0.7),
          selectedColor: Colors.white,
          fillColor: MyColors.headerBg,
          renderBorder: true,
          borderRadius: BorderRadius.circular(24),
          disabledColor: Colors.purple,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 48,
                ),
                child: Text('Today')),
            Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 48,
                ),
                child: Text('Total')),
          ],
          isSelected: _selection,
          onPressed: (int index) {
            setState(() {
              for (int i = 0; i < _selection.length; i++) {
                if (i == index) {
                  _selection[i] = true;
                } else {
                  _selection[i] = false;
                }
              }
              print(_selection.toString());
            });
          },
        ),
      ),
    );
  }
}
