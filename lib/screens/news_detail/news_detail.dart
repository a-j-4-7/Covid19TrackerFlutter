import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsUrl;

  const NewsDetailPage({Key key, @required this.newsUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("==========URL=======" + newsUrl);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: WebView(
            initialUrl: this.newsUrl ?? "",
          ),
        ),
      ),
    );
  }
}
