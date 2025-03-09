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
  bool _isDropdownOpen = false;
  String _selectedMonth = 'January';

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen; 
    });
  }

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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              backgroundImage: AssetImage(AssetsPath.sad),
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
                              backgroundImage: AssetImage(AssetsPath.happy),
                            ),
                          ),
                          Positioned(
                            top: 4,
                            left: 54,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(AssetsPath.angry),
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
                              backgroundImage: AssetImage(AssetsPath.tired),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 27,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _selectedMonth,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: _toggleDropdown,
                                      child: CircleAvatar(
                                        radius: 8,
                                        backgroundColor: Colors.white,
                                        child: Center(
                                          child: Icon(
                                            _isDropdownOpen
                                                ? Icons.arrow_drop_up
                                                : Icons.arrow_drop_down,
                                            color: Colors.purple,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (_isDropdownOpen) ...[
                              // Dropdown list of months
                              Column(
                                children: [
                                  for (var month in [
                                    'January',
                                    'February',
                                    'March',
                                    'April',
                                    'May',
                                    'June',
                                    'July',
                                    'August',
                                    'September',
                                    'October',
                                    'November',
                                    'December',
                                  ])
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMonth = month;
                                          _isDropdownOpen = false;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 2, horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.purple.shade100,
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          child: Text(
                                            month,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              )
                            ],
                            heightBox12,
                            Row(
                              children: [
                                Column(
                                  children: [
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                    heightBox10,
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                    heightBox10,
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                  ],
                                ),
                                widthBox14,
                                Column(
                                  children: [
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                    heightBox10,
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                    heightBox10,
                                    StatusCard(
                                      percent: '30%',
                                      emojiPath: AssetsPath.angry,
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final String emojiPath;
  final String percent;
  const StatusCard({
    super.key,
    required this.emojiPath,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 64,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 13,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(emojiPath),
            ),
            widthBox4,
            Text(percent)
          ],
        ),
      ),
    );
  }
}
