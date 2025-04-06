import 'package:antoinette/app/modules/contact/controllers/add_contact_controller.dart';
import 'package:antoinette/app/modules/contact/views/contact_screen.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  AddContactController addContactController = AddContactController();
  bool togggleActive = false;
  bool isToggled = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox8,
                  Text('Number',
                      style: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff626262))),
                  heightBox8,
                  TextFormField(
                    controller: numberCtrl,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter number';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey)),
                  ),
                  heightBox30,
                  GradientElevatedButton(onPressed: onTapToNextButton, text: 'Save')
                ],
              ),
            )),
      ),
    );
  }

  Future<void> onTapToNextButton() async {
    if (_formKey.currentState!.validate()) {
      final bool isSuccess =
          await addContactController.addContact(nameCtrl.text, numberCtrl.text);

      if (isSuccess) {
        if (mounted) {
          showSnackBarMessage(context, 'Contact added');
          Navigator.pushNamed(context, ContactScreen.routeName);
        } else {
          if (mounted) {
            showSnackBarMessage(
                context, addContactController.errorMessage!, true);
          }
        }
      } else {
        if (mounted) {
          print('Error show ----------------------------------');
          showSnackBarMessage(
              context, addContactController.errorMessage!, true);
        }
      }
    }
  }
}
