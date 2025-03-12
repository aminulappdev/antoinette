import 'package:antoinette/app/modules/Letters/views/podcast_details.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PodcastScreen extends StatelessWidget {
  const PodcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended for You',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
            SizedBox(
              height: 534.h,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PodcastDetailsScreen.routeName);
                      },
                      child: Container(
                        height: 104,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                height: 84,
                                width: 73,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(AssetsPath.womenBookRead),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              widthBox4,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    child: Text(
                                      'The Science of Self-Care',
                                      style: GoogleFonts.poppins(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.grey)
                                          ),
                                          child: Center(
                                            child: Text('Episod 12',style: GoogleFonts.poppins(fontSize: 10),),
                                          ),
                                        ),
                                        Container(
                                          height: 30,
                                          width: 64,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            border: Border.all(color: Colors.grey)
                                          ),
                                          child: Center(
                                            child: Text('12 min',style: GoogleFonts.poppins(fontSize: 10),),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              widthBox40,
                              CircleAvatar(
                                radius: 21,
                                backgroundColor: Color(0xffA57EA5),
                                child: Icon(Icons.play_arrow),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
