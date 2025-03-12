import 'package:antoinette/app/modules/therapy/views/text_therapy_screen.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HealingNoteScreen extends StatefulWidget {
  static const String routeName = '/healing-note-screen';
  const HealingNoteScreen({super.key});

  @override
  State<HealingNoteScreen> createState() => _HealingNoteScreenState();
}

class _HealingNoteScreenState extends State<HealingNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Healing notes'),
                heightBox24,
                CustomSearchBar(shouldBackButton: false, shouldfontButton: false),
                heightBox12,
                SizedBox(
                  height: 650,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, TextTherapyScreen.routeName);
                        },
                        child: Container(
                          height: 66,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: DecorationImage(image: AssetImage(AssetsPath.doctor),fit: BoxFit.fill)
                                  ),
                                ),
                                widthBox8,
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Dr. Jane Smith',style: GoogleFonts.poppins(fontSize: 16,fontWeight: FontWeight.w500),),
                                      heightBox12,
                                      Text('That sounds tough. Stress from work can ',style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w400),),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
