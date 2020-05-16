import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WorldwideCount {
  final int totalDeathCount;
  final int totalRecoveredCasesCount;
  final int totalActiveCasesCount;
  final int totalConfirmedCasesCount;
  final int todayCases;
  final int todayDeaths;
  final Color color;

  int get getTotalDeathCount => totalDeathCount;

  int get getTotalRecoverdCount => totalRecoveredCasesCount;

  int get getTotalActiveCasesCount => totalActiveCasesCount;

  int get getTotalConfirmedCasesCount => totalConfirmedCasesCount;

  int get getTodayCases => todayCases;

  int get getTodayDeaths => todayDeaths;

  Color get getColor => color;

  WorldwideCount(
      {@required this.totalDeathCount,
      @required this.totalRecoveredCasesCount,
      @required this.totalActiveCasesCount,
      @required this.totalConfirmedCasesCount,
      this.todayCases,
      this.todayDeaths,
      this.color});

  @override
  String toString() {
    return 'DashboardCount{totalDeathCount: $totalDeathCount, totalRecoveredCasesCount: $totalRecoveredCasesCount, totalActiveCasesCount: $totalActiveCasesCount, totalConfirmedCasesCount: $totalConfirmedCasesCount}';
  }

  factory WorldwideCount.fromJson(Map<String, dynamic> json) {
    return WorldwideCount(
      totalDeathCount: json['deaths'],
      totalRecoveredCasesCount: json['recovered'],
      totalActiveCasesCount: json['active'],
      totalConfirmedCasesCount: json['cases'],
      todayCases: json['todayCases'],
      todayDeaths: json['todayDeaths'],
    );
  }
}
