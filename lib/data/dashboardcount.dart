import 'package:covid19_tracker/screens/dashboard/dashboard.dart';
import 'package:flutter/foundation.dart';

class DashboardCount{

  final String totalDeathCount;
  final String totalRecoveredCasesCount;
  final String totalActiveCasesCount;
  final String totalConfirmedCasesCount;


  DashboardCount({@required this.totalDeathCount,
  @required this.totalRecoveredCasesCount,
  @required this.totalActiveCasesCount,
   @required this.totalConfirmedCasesCount});

  @override
  String toString() {
    return 'DashboardCount{totalDeathCount: $totalDeathCount, totalRecoveredCasesCount: $totalRecoveredCasesCount, totalActiveCasesCount: $totalActiveCasesCount, totalConfirmedCasesCount: $totalConfirmedCasesCount}';
  }


}