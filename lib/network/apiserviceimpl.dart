
import 'package:covid19_tracker/data/dashboardcount.dart';
import 'package:covid19_tracker/network/apiservice.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

const  WORLDWIDE_COUNT_API_URL = 'https://corona.lmao.ninja/v2/all';

class ApiServiceImpl implements ApiService{


  @override
  Future<DashboardCount> getWorldwideCount() async {

    final response = await http.get(WORLDWIDE_COUNT_API_URL);
    print("Call Success => "+response.statusCode.toString());
    print("Call Success => "+response.body.toString());
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final totalCases = jsonResponse['cases'];
      final totalDeaths = jsonResponse['deaths'];
      final totalRecovered = jsonResponse['recovered'];
      final totalActive = jsonResponse['active'];

      DashboardCount dashboardCount = DashboardCount(
        totalConfirmedCasesCount: totalCases.toString(),
        totalActiveCasesCount: totalActive.toString(),
        totalDeathCount: totalDeaths.toString(),
        totalRecoveredCasesCount: totalRecovered.toString()
      );
      return dashboardCount;
    } else {
      throw Exception();
    }
  }

/*   @override
  Future<List> getCountries() async{
    final response = await http.get(COUNTRIES_LIST_API_URL);
    if(response.statusCode==200){
      print("Call Success => "+response.body.toString());
     return convert.jsonDecode(response.body);
    }else{
      throw new Exception('Failed to get countries');
    }
  } */



  


}