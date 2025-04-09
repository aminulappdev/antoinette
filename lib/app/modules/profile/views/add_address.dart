import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAdderssScreen extends StatefulWidget {
  final String type;
  static const String routeName = '/profile-add-address-screen';
  const AddAdderssScreen({super.key, required this.type});

  @override
  State<AddAdderssScreen> createState() => _AddAdderssScreenState();
}
class _AddAdderssScreenState extends State<AddAdderssScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController addressCtrl = TextEditingController();
  UpdateProfileController updateProfileController = UpdateProfileController();

  
  bool isChecked = false; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(name: 'Add Address'),
                heightBox12,
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address',
                          style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff626262))),
                      heightBox8,
                      TextFormField(
                        controller: addressCtrl,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          helperText: 'Your Address',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     // Home
                      //     Checkbox(
                      //       shape: const CircleBorder(),
                      //       value: selectedIndex == 0,
                      //       activeColor:
                      //           selectedIndex == 0 ? Colors.purple : Colors.grey,
                      //       onChanged: (_) {
                      //         setState(() {
                      //           selectedIndex = 0;
                      //         });
                      //       },
                      //     ),
                      //     const Text('Home'),
                      //     widthBox12,
            
                      //     // Office
                      //     Checkbox(
                      //       shape: const CircleBorder(),
                      //       value: selectedIndex == 1,
                      //       activeColor:
                      //           selectedIndex == 1 ? Colors.purple : Colors.grey,
                      //       onChanged: (_) {
                      //         setState(() {
                      //           selectedIndex = 1;
                      //         });
                      //       },
                      //     ),
                      //     const Text('Office'),
                      //     widthBox12,
            
                      //     // Delivery
                      //     Checkbox(
                      //       shape: const CircleBorder(),
                      //       value: selectedIndex == 2,
                      //       activeColor:
                      //           selectedIndex == 2 ? Colors.purple : Colors.grey,
                      //       onChanged: (_) {
                      //         setState(() {
                      //           selectedIndex = 2;
                      //         });
                      //       },
                      //     ),
                      //     const Text('Delivery'),
                      //   ],
                      // ),
                      heightBox12,
                      GradientElevatedButton(onPressed: onTapToNextButton, text: 'Save')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

   Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess = await updateProfileController.updateProfile(
          address: addressCtrl.text, addressIndex: widget.type);

      if (isSuccess) {
        if (mounted) {
          Get.find<ProfileController>().getProfileData();
          showSnackBarMessage(context, 'Address updated');
          
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, updateProfileController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          print('Error show ----------------------------------');
          showSnackBarMessage(
              context, updateProfileController.errorMessage!, true);
        }
      }
    }
  }
}
