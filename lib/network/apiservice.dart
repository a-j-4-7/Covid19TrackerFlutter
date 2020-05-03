
import 'package:covid19_tracker/data/dashboardcount.dart';

abstract class ApiService{

  Future<DashboardCount> getWorldwideCount();

  // Future<List> getCountries();


}