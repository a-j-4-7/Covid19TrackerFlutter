import 'package:covid19_tracker/data/countryDTO.dart';
import 'package:covid19_tracker/data/newsDTO.dart';
import 'package:covid19_tracker/myservices/apiservice.dart';
import 'package:covid19_tracker/utils/apiexception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

const COUNTRIES_API_URL = 'https://corona.lmao.ninja/v2/countries?sort=cases';
const ERROR_MSG = 'Something went wrong';
const PAGE_SIZE = 20;
const NEWS_API_ORG_API_KEY = 'f710c74edd924727b90828d54f639bb8';

class ApiServiceImpl extends ApiService {
  @override
  Future<List<CountryDTO>> fetchCountries() async {
    http.Response response = await http.get(COUNTRIES_API_URL);
    if (response.statusCode == 200) {
      List parsedResponse = convert.jsonDecode(response.body) as List;
      if (parsedResponse.length > 0) {
        List<CountryDTO> countryList = parsedResponse
            .map((element) => CountryDTO.fromJson(element))
            .toList();
        return countryList;
      } else {
        throw ApiException('No Countries Found');
      }
    } else {
      throw ApiException(ERROR_MSG);
    }
  }

  @override
  Future<List<NewsDTO>> fetchNews(int pageNumber) async {
    final String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final String url =
        'https://newsapi.org/v2/everything?q=corona OR covid&pageSize=$PAGE_SIZE&page=$pageNumber&from=$todaysDate&language=en&sort=popularity&apiKey=$NEWS_API_ORG_API_KEY';
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> parsedResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      if (parsedResponse['status'] == 'ok') {
        List articleList = parsedResponse['articles'];
        if (articleList.length > 0) {
           return articleList.map((element) => NewsDTO.fromJson(element)).toList();
        } else {
          throw ApiException('No articles available');
        }
      } else {
        throw ApiException(ERROR_MSG);
      }
    } else {
      throw ApiException(ERROR_MSG);
    }
  }
}
