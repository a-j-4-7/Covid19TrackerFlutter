import 'dart:io';

import 'package:covid19_tracker/data/countryDTO.dart';
import 'package:covid19_tracker/data/worldwidecount.dart';
import 'package:covid19_tracker/data/newsDTO.dart';
import 'package:covid19_tracker/services/apiservice.dart';
import 'package:covid19_tracker/utils/failure.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:intl/intl.dart';

const WORLDWIDE_COUNT_API_URL = 'https://corona.lmao.ninja/v2/all';
const COUNTRIES_API_URL = 'https://corona.lmao.ninja/v2/countries?sort=cases';
const ERROR_MSG = 'Something went wrong';
const PAGE_SIZE = 20;
const NEWS_API_ORG_API_KEY = 'f710c74edd924727b90828d54f639bb8';

class ApiServiceImpl extends ApiService {
  @override
  Future<List<CountryDTO>> fetchCountries() async {
    try {
      http.Response response = await http.get(COUNTRIES_API_URL);
      print(response);
      if (response.statusCode == 200) {
        List parsedResponse = convert.jsonDecode(response.body) as List;
        if (parsedResponse.length > 0) {
          List<CountryDTO> countryList = parsedResponse
              .map((element) => CountryDTO.fromJson(element))
              .toList();
          return countryList;
        } else {
          throw Failure('No Countries Found');
        }
      } else {
        throw Failure(ERROR_MSG);
      }
    } on SocketException {
      throw Failure('Connection Failed');
    } on HttpException {
      throw Failure('Http Error');
    } on Exception {
      throw Failure('Unknown Exception');
    }
  }

  @override
  Future<List<NewsDTO>> fetchNews(int pageNumber) async {
    try {
      final String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final String url =
          'https://newsapi.org/v2/everything?q=corona OR covid&pageSize=$PAGE_SIZE&page=$pageNumber&from=$todaysDate&language=en&sort=popularity&apiKey=$NEWS_API_ORG_API_KEY';
      print(url);
      http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        print('200 OK Response');
        Map<String, dynamic> parsedResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;
        if (parsedResponse['status'] == 'ok') {
          print('Status OK');
          List articleList = parsedResponse['articles'];
          if (articleList.length > 0) {
            return articleList
                .map((element) => NewsDTO.fromJson(element))
                .toList();
          } else {
            print('Empty articles[]');
            throw Failure('No articles available');
          }
        } else {
          print('Status NOT OK');
          throw Failure(ERROR_MSG);
        }
      } else {
        print('NOT 200 Response');
        throw Failure(ERROR_MSG);
      }
    } on SocketException {
      throw Failure('Connection Failed');
    } on HttpException {
      throw Failure('Http Error');
    } on Exception {
      throw Failure('Unknown Exception');
    }
  }

  @override
  Future<WorldwideCount> fetchWorldwideCount() async {
    try {
      http.Response response = await http.get(WORLDWIDE_COUNT_API_URL);
      print(response);
      if (response.statusCode == 200) {
        Map<String, dynamic> parsedResponse = convert.jsonDecode(response.body) as Map<String, dynamic>;
        print(WorldwideCount.fromJson(parsedResponse));
        return WorldwideCount.fromJson(parsedResponse);
      } else {
        throw Failure(ERROR_MSG);
      }
    } on SocketException {
      throw Failure('Connection Failed');
    } on HttpException {
      throw Failure('Http Error');
    } on Exception {
      throw Failure('Unknown Exception');
    }
  }
}
