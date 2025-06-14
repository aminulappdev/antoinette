
import 'package:antoinette/app/modules/contact/controllers/add_contact_controller.dart';
import 'package:antoinette/app/modules/contact/controllers/all_contact_controller.dart';
import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddContactScreen extends StatefulWidget {
  static const String routeName = '/add-contact-screen';
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController numberCtrl = TextEditingController();
  AddContactController addContactController = Get.put(AddContactController());
  ProfileController profileController = Get.find<ProfileController>();

  late String userId;
  bool togggleActive = false;
  bool isToggled = false;
  String selectedCountryCode = '+234'; // Default to Nigeria

  // List of 19 countries (India removed, Nigeria first, Bangladesh included) with country codes and min digits
  final List<Map<String, dynamic>> countryCodes = [
    {'country': 'Nigeria', 'code': '+234', 'minDigits': 10},
    {'country': 'Bangladesh', 'code': '+880', 'minDigits': 10}, // Adjusted minDigits to 10 (excluding leading 0)
    {'country': 'China', 'code': '+86', 'minDigits': 11},
    {'country': 'United States', 'code': '+1', 'minDigits': 10},
    {'country': 'Indonesia', 'code': '+62', 'minDigits': 10},
    {'country': 'Pakistan', 'code': '+92', 'minDigits': 10},
    {'country': 'Brazil', 'code': '+55', 'minDigits': 11},
    {'country': 'Russia', 'code': '+7', 'minDigits': 10},
    {'country': 'Mexico', 'code': '+52', 'minDigits': 10},
    {'country': 'Japan', 'code': '+81', 'minDigits': 10},
    {'country': 'Ethiopia', 'code': '+251', 'minDigits': 9},
    {'country': 'Philippines', 'code': '+63', 'minDigits': 10},
    {'country': 'Egypt', 'code': '+20', 'minDigits': 10},
    {'country': 'Vietnam', 'code': '+84', 'minDigits': 10},
    {'country': 'DR Congo', 'code': '+243', 'minDigits': 9},
    {'country': 'Turkey', 'code': '+90', 'minDigits': 10},
    {'country': 'Iran', 'code': '+98', 'minDigits': 10},
    {'country': 'Germany', 'code': '+49', 'minDigits': 10},
    {'country': 'Thailand', 'code': '+66', 'minDigits': 9},
  ];

  @override
  void initState() {
    userId = profileController.profileData!.id!;
    super.initState();
  }

  // Function to clean phone number for Bangladesh (remove leading 0)
  String cleanPhoneNumber(String input, String countryCode) {
    if (countryCode == '+880' && input.startsWith('0')) {
      return input.substring(1); // Remove leading 0 for Bangladesh
    }
    return input;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heightBox24,
              CustomAppBar(name: 'Add Trusted Contacts'),
              heightBox12,
              Text(
                'Name',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff626262),
                ),
              ),
              heightBox8,
              TextFormField(
                controller: nameCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.name,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter name',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              heightBox8,
              Text(
                'Phone Number',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff626262),
                ),
              ),
              heightBox8,
              Row(
                children: [
                  // Dropdown for country code
                  Container(
                    width: 120.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: DropdownButton<String>(
                      value: selectedCountryCode,
                      isExpanded: true,
                      underline: SizedBox(),
                      items: countryCodes.map((Map<String, dynamic> country) {
                        return DropdownMenuItem<String>(
                          value: country['code'],
                          child: Text(
                            '${country['country']} (${country['code']})',
                            style: GoogleFonts.poppins(fontSize: 12.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCountryCode = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Phone number input field
                  Expanded(
                    child: TextFormField(
                      controller: numberCtrl,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.phone,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter phone number';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Enter a valid phone number';
                        }
                        // Find the selected country's minimum digits
                        final selectedCountry = countryCodes.firstWhere(
                          (country) => country['code'] == selectedCountryCode,
                        );
                        final minDigits = selectedCountry['minDigits'] as int;
                        // Clean the input for validation
                        final cleanedNumber = cleanPhoneNumber(value, selectedCountryCode);
                        if (cleanedNumber.length < minDigits) {
                          return '${selectedCountry['country']} numbers require at least $minDigits digits';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
              heightBox30,
              GetBuilder<AddContactController>(
                builder: (controller) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      GradientElevatedButton(
                        onPressed: controller.inProgress
                            ? () {}
                            : () => onTapToNextButton(),
                        text: controller.inProgress ? '' : 'Save',
                      ),
                      if (controller.inProgress)
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      // Clean the phone number based on country code
      final String cleanedNumber = cleanPhoneNumber(numberCtrl.text, selectedCountryCode);
      // Combine country code and cleaned phone number
      final String fullPhoneNumber = '$selectedCountryCode$cleanedNumber';

      final bool isSuccess = await addContactController.addContact(
        nameCtrl.text,
        fullPhoneNumber,
        userId,
      );

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Contact added');
          Get.find<AllContactController>().getContactList();
          Navigator.pushNamed(context, ContactScreen.routeName);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(context, addContactController.errorMessage!, true);
        }
      }
    }
  }
}
