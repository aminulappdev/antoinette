import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

class DearDiaryScreen extends StatefulWidget {
  static const String routeName = '/dear-diary-screen';
  const DearDiaryScreen({super.key});

  @override
  State<DearDiaryScreen> createState() => _DearDiaryScreenState();
}

class _DearDiaryScreenState extends State<DearDiaryScreen> {
  List<Color> colors = [
    Color(0XFF5AE205).withOpacity(0.30),
    Color(0XFFFF3434).withOpacity(0.30),
    Color(0XFFE9BD0F).withOpacity(0.30),
    Color(0XFF344BFD).withOpacity(0.30),
    Color(0XFFC000E7).withOpacity(0.30),
    Color(0XFFFF9318).withOpacity(0.30),
  ];
  Map<String, double> dataMap = {
    "Flutter": 1,
    "React": 1,
    "Xamarin": 1,
    "Ionic": 1,
    "Happy": 1,
    "Sad": 1,
  };
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(name: 'Dear Diary'),
              heightBox12,
              CustomSearchBar(
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
                    children: [
                      Stack(
                        children: [
                          PieChart(
                            colorList: colors,
                            dataMap: dataMap,
                            animationDuration: Duration(milliseconds: 800),
                            chartLegendSpacing: 32,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            initialAngleInDegree: 0,
                            chartType: ChartType.ring,
                            ringStrokeWidth: 40,
                            legendOptions: LegendOptions(
                              showLegendsInRow: false,
                              legendPosition: LegendPosition.left,
                              showLegends: false,
                            ),
                            chartValuesOptions: ChartValuesOptions(
                              showChartValueBackground: true,
                              showChartValues: false,
                              showChartValuesInPercentage: false,
                              showChartValuesOutside: false,
                              decimalPlaces: 1,
                            ),
                          ),
                          Positioned(
                            left: 104,
                            bottom: 32,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.happy),
                            ),
                          ),
                           Positioned(
                            left: 4,
                            bottom: 32,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.muscle),
                            ),
                          ),
                           Positioned(
                            left: 4,
                            bottom: 100,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.sad),
                            ),
                          ),
                           Positioned(
                            top: 4,
                            left: 54,

                            child: CircleAvatar(
                              
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.tired),
                            ),
                          ),
                           Positioned(
                            left: 104,
                            top: 30,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.angle),
                            ),
                          ),
                           Positioned(
                            left: 54,
                            bottom: 4,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.angry),
                            ),
                          ),
                           

                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
