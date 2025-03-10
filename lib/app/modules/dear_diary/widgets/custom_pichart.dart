import 'package:antoinette/app/utils/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

// ignore: must_be_immutable
class CustomPiChart extends StatelessWidget {
   CustomPiChart({
    super.key,
    
  });

  List<Color> colors = [
    Color(0XFF344BFD).withOpacity(0.30),
    Color(0XFFC000E7).withOpacity(0.30),
    Color(0XFFFF9318).withOpacity(0.30),
    Color(0XFF5AE205).withOpacity(0.30),
    Color(0XFFFF3434).withOpacity(0.30),
    Color(0XFFE9BD0F).withOpacity(0.30),
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
    return Stack(
      children: [
        PieChart(
          colorList: colors,
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 800),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
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
          left: 104.w,
          bottom: 32.h,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.sad),
          ),
        ),
        Positioned(
          left: 4.w,
          bottom: 32.h,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.muscle),
          ),
        ),
        Positioned(
          left: 4.w,
          bottom: 100.h,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.happy),
          ),
        ),
        Positioned(
          top: 4.h,
          left: 54.w,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.angry),
          ),
        ),
        Positioned(
          left: 104.w,
          top: 30.h,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.angle),
          ),
        ),
        Positioned(
          left: 54.w,
          bottom: 4.h,
          child: CircleAvatar(
            radius: 15.r,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AssetsPath.tired),
          ),
        ),
      ],
    );
  }
}
