import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticleDetailsScreen extends StatefulWidget {
  static const String routeName = '/article-details-screen';
  const ArticleDetailsScreen({super.key});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ArticleDetailsScreen.routeName);
                  },
                  child: Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(AssetsPath.womenBookRead)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor:
                                  Color(0xff000000).withOpacity(0.1),
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              radius: 21,
                              backgroundColor:
                                  Color(0xff000000).withOpacity(0.1),
                              child: Icon(
                                Icons.favorite_border_sharp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                'Mind & Body Space: The Connection Between Mental and Physical Well-being',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Author: Dr. Sophia Williams',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                  Text(
                    'Published Date: Feb 7, 2025',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
              heightBox4,
              Text(
                'Introduction',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10),textAlign: TextAlign.justify,
              ),
              heightBox4,
              Text(
                'The Science Behind the Mind-Body Connection',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10),textAlign: TextAlign.justify,
              ),
              heightBox4,
              Text(
                'Sleep: The Foundation of Mental & Physical Wellness',
                style: GoogleFonts.poppins(fontSize: 15),
              ),
              heightBox4,
              Text(
                'In our fast-paced world, mental and physical health are often treated as separate entities. However, science continues to reveal that our mind and body are deeply interconnected. Stress, anxiety, and emotional struggles can manifest as physical symptoms, just as physical habits—like movement and nutrition—can significantly impact mental well-being. Welcome to Mind & Body Space, where we explore how to create harmony between the two.',
                style: GoogleFonts.poppins(fontSize: 10),textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
