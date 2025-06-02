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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
  PhoneNumber? phoneNumber;

  @override
  void initState() {
    userId = profileController.profileData!.id!;
    super.initState();
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
              Text('Name',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff626262))),
              heightBox8,
              TextFormField(
                controller: nameCtrl,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter name';
                  }

                  return null;
                },
                decoration:
                    InputDecoration(hintStyle: TextStyle(color: Colors.grey)),
              ),
              heightBox8,
              Text('Phone Number',
                  style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff626262))),
              heightBox8,
              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  setState(() {
                    phoneNumber = number;
                  });
                },
                onInputValidated: (bool value) {
                  // Optionally handle validation here
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.DIALOG,
                ),
                hintText: 'Enter your phone number',
                ignoreBlank: false,
                textFieldController: numberCtrl,
                formatInput: false,
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter phone number';
                  }
                  return null;
                },
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
      if (phoneNumber == null || phoneNumber!.phoneNumber == null) {
        showSnackBarMessage(context, 'Please enter a valid phone number');
        return;
      }

      final bool isSuccess = await addContactController.addContact(
          nameCtrl.text, phoneNumber!.phoneNumber!, userId);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Contact added');
          Get.find<AllContactController>().getContactList();
          Navigator.pushNamed(context, ContactScreen.routeName);
        }
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, addContactController.errorMessage!, true);
        }
      }
    }
  }
}
