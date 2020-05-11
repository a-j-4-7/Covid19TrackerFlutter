import 'package:covid19_tracker/constants/mystyles.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailPage extends StatefulWidget {
  final String newsUrl;

  const NewsDetailPage(
      {Key key, @required this.newsUrl})
      : super(key: key);

  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  int stackIndex = 0;

  @override
  Widget build(BuildContext context) {
    print("==========URL=======" + widget.newsUrl);

    return SafeArea(
      child: Scaffold(
        body: Container(
            child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 24,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'News In Detail',
                        style: MyStyles.headerTextStyle
                            .copyWith(color: Colors.black87),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: IndexedStack(
                index: stackIndex,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  WebView(
                    initialUrl: this.widget.newsUrl ?? "",
                    onPageFinished: (pageFinished) {
                      setState(() {
                        stackIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
