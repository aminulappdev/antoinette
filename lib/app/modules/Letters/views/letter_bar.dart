import 'package:antoinette/app/modules/Letters/views/article_page.dart';
import 'package:antoinette/app/modules/Letters/views/podcast_screen.dart';
import 'package:antoinette/app/modules/Letters/views/videos_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class LetterBar extends StatefulWidget {
  const LetterBar({super.key});

  @override
  State<LetterBar> createState() => _LetterBarState();
}

class _LetterBarState extends State<LetterBar> {
  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: () {
                    selectedPage = 0;
                    setState(() {});
                  },
                  child: Text(
                    'Articles',
                    style: TextStyle(
                        decorationColor: Color(0xffD9A48E),
                        decoration: selectedPage == 0
                            ? TextDecoration.underline
                            : TextDecoration.none,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: selectedPage == 0
                            ? Color(0xffD9A48E)
                            : Color(0xff959595)),
                  )),
              widthBox12,
              GestureDetector(
                onTap: () {
                  selectedPage = 1;
                  setState(() {});
                },
                child: Text('Podcasts',
                    style: TextStyle(
                      decorationColor: Color(0xffD9A48E),
                      decoration: selectedPage == 1
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: selectedPage == 1
                          ? Color(0xffD9A48E)
                          : Color(0xff959595),
                    )),
              ),
              widthBox12,
              GestureDetector(
                onTap: () {
                  selectedPage = 2;
                  setState(() {});
                },
                child: Text('Videos',
                    style: TextStyle(
                      decorationColor: Color(0xffD9A48E),
                      decoration: selectedPage == 2
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: selectedPage == 2
                          ? Color(0xffD9A48E)
                          : Color(0xff959595),
                    )),
              )
            ],
          ),
          heightBox8,
          CustomSearchBar(shouldBackButton: false, shouldfontButton: false),
          heightBox8,
          if (selectedPage == 0) ...{
            ArticleScreen(),
          } else if (selectedPage == 1) ...{
            PodcastScreen()
          } else if (selectedPage == 2) ...{
            VideosScreen()
          }
        ],
      ),
    );
  }
}
