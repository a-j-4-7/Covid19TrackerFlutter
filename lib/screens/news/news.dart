import 'dart:convert';
import 'package:covid19_tracker/common/errorplaceholder.dart';
import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:covid19_tracker/data/newsDTO.dart';
import 'package:covid19_tracker/screens/news/news_list_tile.dart';
import 'package:covid19_tracker/screens/news_detail/news_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

const NEWS_API_ORG_API_KEY = 'f710c74edd924727b90828d54f639bb8';
const PAGE_SIZE = 20;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map newsMap;
  int _pageNumber = 1;
  String todaysDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool isLoading = true;
  bool isLastPageReached = false;
  ScrollController _scrollController = ScrollController();
  List listOfNews = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (!isLastPageReached) {
          print("PAGINATION TRIGGERED");
          _pageNumber += 1;
          fetchNewsForToday();
          return;
        }
        print('======================LAST PAGE REACHED=====================');
      }
    });
    fetchNewsForToday();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'Covid-19 News',
                  style:
                      MyStyles.headerTextStyle.copyWith(color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              if (isLoading) ...[
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ] else ...[
                Expanded(
                    child: newsMap != null
                        ? _buildNewsListView()
                        : Center(
                            child: ErrorPlaceholder(
                              errorMsg: 'No News Available',
                              iconData: Icons.warning,
                            ),
                          ))
              ]
            ],
          ),
        ),
      ),
    );
  }

  fetchNewsForToday() async {
    print('check page number $_pageNumber');
    String url =
        'https://newsapi.org/v2/everything?q=corona OR covid&pageSize=$PAGE_SIZE&page=$_pageNumber&from=$todaysDate&language=en&sort=popularity&apiKey=$NEWS_API_ORG_API_KEY';
    print('URL======>$url');
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        if (!mounted) return;
        setState(() {
          isLoading = false;
          newsMap = jsonDecode(response.body);
          print('NEWS MAP =>' + newsMap.toString());
          var status = newsMap['status'];
          if (status.toString() == 'error') isLastPageReached = true;
          var totalResults = newsMap['totalResults'];
          print('NEWS MAP =>' + status.toString());
          print('NEWS MAP =>' + totalResults.toString());
        });
        return;
      }
      isLastPageReached = true;
      throw Exception('HTTP ERROR');
    } catch (exception) {
      print('EXCEPTIONNNNNNNNNNNNNNNNNNN' + exception.toString());
    }
    /* finally {
      setState(() {
        isLoading = false;
      });
    } */
  }

  Widget _buildNewsListView() {
    /*  var status = newsMap['status'];
    if (status.toString() == 'error')isLastPageReached = true;
    var totalResults = newsMap['totalResults'];
    print('NEWS MAP =>' + status.toString());
    print('NEWS MAP =>' + totalResults.toString()); */

    List articleList = newsMap['articles'] as List;

    listOfNews.addAll(articleList
        .map((article) => NewsDTO(
            source: article['source']['name'],
            title: article['title'],
            description: article['description'],
            url: article['url'],
            urlToImage: article['urlToImage'],
            publishedAt: article['publishedAt']))
        .toList());

    print(articleList.toString());
    print(articleList.length.toString());
    print('MAPPED LIST SIZE =>' + listOfNews.length.toString());
    return ListView.builder(
      itemCount: listOfNews.length,
      shrinkWrap: true,
      controller: _scrollController,
      physics: BouncingScrollPhysics(),
      itemBuilder: (ctx, index) => NewsListTile(
        newsItem: listOfNews[index],
        onNewsItemPressed: (newsUrl) {
          print("==========URL=======" + newsUrl);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsDetailPage(
                      newsUrl: newsUrl,
                    )),
          );
        },
      ),
    );
  }
}
