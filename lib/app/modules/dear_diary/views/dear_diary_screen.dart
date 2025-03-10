import 'package:antoinette/app/modules/dear_diary/widgets/custom_pichart.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/health_condition_card.dart';
import 'package:antoinette/app/modules/dear_diary/widgets/mental_status.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DearDiaryScreen extends StatefulWidget {
  static const String routeName = '/dear-diary-screen';
  const DearDiaryScreen({super.key});

  @override
  State<DearDiaryScreen> createState() => _DearDiaryScreenState();
}

class _DearDiaryScreenState extends State<DearDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Dear Diary'),
                heightBox12,
                CustomSearchBar(
                  shouldfontButton: true,
                  shouldBackButton: false,
                ),
                
                heightBox12,
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 185,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomPiChart(),
                        MentalStatusWidget(
                          toogleOntap: () {},
                          anglePercent: '30%',
                          angryPercent: '30%',
                          happyPercent: '30%',
                          musclePercent: '30%',
                          sadPercent: '30%',
                          tiredPercent: '30%',
                        )
                      ],
                    ),
                  ),
                ),
                heightBox8,
                HealthConditionCard(
                  iconPath: AssetsPath.angle,
                  status: 'HAPPY',
                  day: 'Monday',
                  time: '9:00 AM',
                  description:
                      'Today was a good day! The sun felt warm on my face, and I laughed so much with my friends. I want to remember this feeling—light, joyful, and full of possibility.',
                  lockOntap: () {},
                  moreHorizOntap: () {},
                  themeColor: Color(0xffD9A48E).withAlpha(20),
                ),
                heightBox8,
                HealthConditionCard(
                  iconPath: AssetsPath.angle,
                  status: 'HAPPY',
                  day: 'Monday',
                  time: '9:00 AM',
                  description:
                      'Today was a good day! The sun felt warm on my face, and I laughed so much with my friends. I want to remember this feeling—light, joyful, and full of possibility.',
                  lockOntap: () {},
                  moreHorizOntap: () {},
                  themeColor: Color(0xffD9A48E).withAlpha(20),
                ),
                heightBox8,
                HealthConditionCard(
                  iconPath: AssetsPath.angle,
                  status: 'HAPPY',
                  day: 'Monday',
                  time: '9:00 AM',
                  description:
                      'Today was a good day! The sun felt warm on my face, and I laughed so much with my friends. I want to remember this feeling—light, joyful, and full of possibility.',
                  lockOntap: () {},
                  moreHorizOntap: () {},
                  themeColor: Color(0xffD9A48E).withAlpha(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
