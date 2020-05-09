import 'package:flutter/foundation.dart';

class CountryDTO {
  final String imageUrl;
  final String countryName;
  final String active;
  final String recovered;
  final String deaths;
  final String todayDeaths;
  final String todayCases;

  CountryDTO({
    @required this.imageUrl,
    @required this.countryName,
    @required this.active,
    @required this.recovered,
    @required this.deaths,
    this.todayDeaths,
    this.todayCases,
  });

  String get getCountryName => countryName;

  String get getActive => active;

  String get getRecovered => recovered;

  String get getDeaths => deaths;

  String get getTodayDeaths => todayDeaths;

  String get getTodayCases => todayCases;

  String get getImageUrl => imageUrl;

  @override
  String toString() {
    return "Country => ${this.countryName}";
  }

  factory CountryDTO.fromJson(Map<String, dynamic> json) {
    return CountryDTO(
      imageUrl: json['countryInfo']['flag'],
      countryName: json['country'],
      active: json['active'].toString(),
      recovered: json['recovered'].toString(),
      deaths: json['deaths'].toString(),
      todayCases: json['todayCases'].toString(),
      todayDeaths: json['todayDeaths'].toString()
    );
  }
}
