import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DashboardCount{

  final int totalDeathCount;
  final int totalRecoveredCasesCount;
  final int totalActiveCasesCount;
  final int totalConfirmedCasesCount;
  final Color color;

  int get getTotalDeathCount => totalDeathCount;
  int get getTotalRecoverdCount => totalRecoveredCasesCount;
  int get getTotalActiveCasesCount => totalActiveCasesCount;
  int get getTotalConfirmedCasesCount => totalConfirmedCasesCount;
  Color get getColor => color;


  DashboardCount({@required this.totalDeathCount,
  @required this.totalRecoveredCasesCount,
  @required this.totalActiveCasesCount,
   @required this.totalConfirmedCasesCount,
   this.color});

  @override
  String toString() {
    return 'DashboardCount{totalDeathCount: $totalDeathCount, totalRecoveredCasesCount: $totalRecoveredCasesCount, totalActiveCasesCount: $totalActiveCasesCount, totalConfirmedCasesCount: $totalConfirmedCasesCount}';
  }


}