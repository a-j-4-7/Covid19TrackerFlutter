import 'package:covid19_tracker/constants/mycolors.dart';
import 'package:covid19_tracker/data/newsDTO.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsListTile extends StatelessWidget {
  final NewsDTO newsItem;
  final Function(String) onNewsItemPressed;

  const NewsListTile({Key key, this.newsItem, this.onNewsItemPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onNewsItemPressed(newsItem.getUrl);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 16,
        ),
        color: Colors.white,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 12,
                ),
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FadeInImage(
                    fit: BoxFit.fill,
                    placeholder: AssetImage('assets/img_placeholder.png'),
                    image: NetworkImage(
                      newsItem.getUrlToImage ?? "",
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Text(
                        'FROM : ${newsItem.getSource.toUpperCase()}' ??
                            "NO SOURCE",
                        style: GoogleFonts.poppins(
                            fontSize: 12, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: MyColors.headerBgLight,
                      ),
                      child: Text(
                        formatDate(newsItem.getPublishedAt) ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: MyColors.headerBg,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      newsItem.getTitle ?? "",
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      newsItem.getDescription ?? "",
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String formatDate(String dateToBeFormatted) {
    try {
      List<String> split = dateToBeFormatted.split('T');
      return '${split[0]}  ${split[1].replaceAll('Z', '')}';
    } catch (error) {
      return 'NO DATE';
    }
  }
}
