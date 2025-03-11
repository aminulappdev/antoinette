import 'package:antoinette/app/modules/contact/views/add_contact_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact-screen';
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool togggleActive = false;
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Add Trusted Contacts'),
                heightBox12,
                SizedBox(
                    height: 550,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ToggleButton(
                              isToggled: isToggled,
                              onToggle: (value) {},
                            ),
                            Text(
                              'Sunan 0197365233',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 28.h,
                                    width: 28.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border: Border.all(color: Colors.blue)),
                                    child: Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  widthBox4,
                                  Container(
                                    height: 28.h,
                                    width: 28.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        border:
                                            Border.all(color: Colors.redAccent)),
                                    child: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Colors.redAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    )),
                GradientElevatedButton(onPressed: () {
                           Navigator.pushNamed(context, AddContactScreen.routeName);
                }, text: '+ Add Contact')
              ],
            )),
      ),
    );
  }
}
