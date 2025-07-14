import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/controllers/update_profile_controller.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/custom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAdderssScreen extends StatefulWidget {
  static const String routeName = '/profile-add-address-screen';
  const AddAdderssScreen({
    super.key,
  });

  @override
  State<AddAdderssScreen> createState() => _AddAdderssScreenState();
}

class _AddAdderssScreenState extends State<AddAdderssScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController numberCtrl = TextEditingController();
  TextEditingController streetCtrl = TextEditingController();
  TextEditingController appartmentCtrl = TextEditingController();
  TextEditingController townCtrl = TextEditingController();
  TextEditingController countryCtrl = TextEditingController();
  TextEditingController noteCtrl = TextEditingController();

  String? selectedState;
  Map<String, dynamic> shippingInfo = {};
  bool isChecked = false;

  // List of Nigerian states
  final List<String> nigerianStates = [
    'Abia',
    'Adamawa',
    'Akwa Ibom',
    'Anambra',
    'Bauchi',
    'Bayelsa',
    'Benue',
    'Borno',
    'Cross River',
    'Delta',
    'Ebonyi',
    'Edo',
    'Ekiti',
    'Enugu',
    'FCT',
    'Gombe',
    'Imo',
    'Jigawa',
    'Kaduna',
    'Kano',
    'Katsina',
    'Kebbi',
    'Kogi',
    'Kwara',
    'Lagos',
    'Nasarawa',
    'Niger',
    'Ogun',
    'Ondo',
    'Osun',
    'Oyo',
    'Plateau',
    'Rivers',
    'Sokoto',
    'Taraba',
    'Yobe',
    'Zamfara'
  ];

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().getProfileData();
    // Load existing shipping information from storage
    final storedShippingInfo =
        StorageUtil.getData('shipping-information') as Map<String, dynamic>?;
    if (storedShippingInfo != null) {
      shippingInfo = storedShippingInfo;
      // Set initial values for controllers
      nameCtrl.text = storedShippingInfo['full_name']?.toString() ?? '';
      numberCtrl.text = storedShippingInfo['phone_number']?.toString() ?? '';
      streetCtrl.text = storedShippingInfo['street_address']?.toString() ?? '';
      appartmentCtrl.text = storedShippingInfo['appartment']?.toString() ?? '';
      townCtrl.text = storedShippingInfo['town_city']?.toString() ?? '';
      countryCtrl.text = storedShippingInfo['country']?.toString() ?? '';
      noteCtrl.text = storedShippingInfo['note']?.toString() ?? '';
      // Set initial state for dropdown
      selectedState = storedShippingInfo['state']?.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return Padding(
          padding: EdgeInsets.all(16.0.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      heightBox24,
                      CustomAppBar(name: 'Shipping information'),
                      heightBox12,
                      Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Full Name',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              controller: nameCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter name';
                                }
                                return null;
                              },
                            ),
                            heightBox12,
                            Text('Phone Number',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: numberCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter number';
                                }
                                return null;
                              },
                            ),
                            heightBox12,
                            Text('Street Address',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              controller: streetCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter street';
                                }
                                return null;
                              },
                            ),
                            heightBox12,
                            Text('Appartment/Suite (Optional)',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              controller: appartmentCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            heightBox12,
                            Text('Town/City',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              controller: townCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter town';
                                }
                                return null;
                              },
                            ),
                            heightBox12,
                            Text('Country',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              controller: countryCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'Enter country';
                                }
                                return null;
                              },
                            ),
                            heightBox12,
                            Text('State',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            DropdownButtonFormField<String>(
                              value: selectedState,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                              ),
                              hint: Text('Select State',
                                  style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff626262))),
                              items: nigerianStates.map((String state) {
                                return DropdownMenuItem<String>(
                                  value: state,
                                  child: Text(state,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400)),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedState = newValue;
                                });
                              },
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Select a state';
                                }
                                return null;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            heightBox12,
                            Text('Delivery note (Optional)',
                                style: GoogleFonts.poppins(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff626262))),
                            heightBox8,
                            TextFormField(
                              maxLines: 2,
                              controller: noteCtrl,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            heightBox12,
                            GetBuilder<UpdateProfileController>(
                              builder: (controller) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    GradientElevatedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          // Populate shippingInfo map
                                          shippingInfo = {
                                            'full_name': nameCtrl.text,
                                            'phone_number': numberCtrl.text,
                                            'street_address': streetCtrl.text,
                                            'appartment': appartmentCtrl.text,
                                            'town_city': townCtrl.text,
                                            'country': countryCtrl.text,
                                            'state': selectedState ?? '',
                                            'note': noteCtrl.text,
                                          };

                                          // Save to storage
                                          await StorageUtil.saveData(
                                              'shipping-information',
                                              shippingInfo);

                                          // Navigate back
                                          Get.back();
                                        }
                                      },
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    // Dispose controllers to prevent memory leaks
    nameCtrl.dispose();
    numberCtrl.dispose();
    streetCtrl.dispose();
    appartmentCtrl.dispose();
    townCtrl.dispose();
    countryCtrl.dispose();
    noteCtrl.dispose();
    super.dispose();
  }
}
