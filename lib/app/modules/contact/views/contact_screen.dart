import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/delete_contact_controller.dart';
import 'package:antoinette/app/modules/contact/views/add_contact_screen.dart';
import 'package:antoinette/app/modules/contact/views/edit_contact_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactScreen extends StatefulWidget {
  static const String routeName = '/contact-screen';
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final AllContactController allContactController = AllContactController();
  final DeleteContactController deleteContactController =
      DeleteContactController();

  @override
  void initState() {
    Get.find<AllContactController>().getContactList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(16.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Trusted Contacts'),
                heightBox12,
                GetBuilder<AllContactController>(builder: (controller) {
                  if (controller.inProgress) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return SizedBox(
                      height: 550,
                      child: ListView.builder(
                        itemCount: controller.contactList?.length,
                        itemBuilder: (context, index) {
                          Map<String,dynamic> value = {
                            'number' : controller.contactList?[index].contractNumber,
                            'contactId' : controller.contactList?[index].sId,
                          };
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 180.w,
                                child: Text(
                                  '${controller.contactList?[index].name}',
                                  style: GoogleFonts.poppins(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Text(
                                '${controller.contactList?[index].contractNumber}',
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            EditContactScreen.routeName,
                                            arguments: value);
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 28.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border:
                                                Border.all(color: Colors.blue)),
                                        child: Icon(
                                          Icons.edit,
                                          size: 20.h,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    widthBox8,
                                    InkWell(
                                      onTap: () {
                                        deleteContact(
                                            '${controller.contactList?[index].sId}');
                                      },
                                      child: Container(
                                        height: 28.h,
                                        width: 28.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.redAccent)),
                                        child: Icon(
                                          Icons.delete,
                                          size: 20.h,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ));
                }),
                GradientElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddContactScreen.routeName);
                    },
                    text: '+ Add Contact')
              ],
            )),
      ),
    );
  }

  Future<void> deleteContact(String id) async {
    final bool isSuccess = await deleteContactController.deleteContactById(id);

    if (isSuccess) {
      if (mounted) {
        showSnackBarMessage(context, 'Contact added');
        Get.find<AllContactController>().getContactList();
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, deleteContactController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        // print('Error show ----------------------------------');
        showSnackBarMessage(
            context, deleteContactController.errorMessage!, true);
      }
    }
  }
}
