import 'package:flutter/foundation.dart';

class NewsDTO {
  final String source;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;

  NewsDTO(
      {@required this.source,
      @required this.title,
      @required this.description,
      @required this.url,
      @required this.urlToImage,
      @required this.publishedAt});

  String get getSource => this.source;

  String get getTitle => this.title;

  String get getDescription => this.description;

  String get getUrl => this.url;

  String get getUrlToImage => this.urlToImage;

  String get getPublishedAt => this.publishedAt;

  factory NewsDTO.fromJson(Map<String, dynamic> json) {
    return NewsDTO(
      source: json['source']['name'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
    );
  }


}
