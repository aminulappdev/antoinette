import 'package:antoinette/app/modules/profile/controllers/content_controller.dart';
import 'package:antoinette/app/modules/profile/views/info_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AgreeConditionCheck extends StatefulWidget {
  const AgreeConditionCheck({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<bool> onChanged;

  @override
  State<AgreeConditionCheck> createState() => _AgreeConditionCheckState();
}

class _AgreeConditionCheckState extends State<AgreeConditionCheck> {
  bool isChecked = false;
  final ContentController contentController = Get.find<ContentController>();
  @override
  void initState() {
    contentController.getContent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChanged(isChecked); // notify parent
          },
        ),
        GetBuilder<ContentController>(builder: (controller) {
          return Flexible(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'I agree to the ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, InfoScreen.routeName,
                            arguments: {
                              'appBarTitle': 'Terms & Conditions',
                              'data':
                                  '${controller.contentlist?[0].termsAndConditions}'
                            });
                      },
                    text: 'Terms & Conditions ',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: 'and ',
                    style: TextStyle(color: Colors.black),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, InfoScreen.routeName,
                            arguments: {
                              'appBarTitle': 'Privacy and Policies',
                              'data':
                                  '${controller.contentlist?[0].privacyPolicy}'
                            });
                      },
                    text: 'Privacy Policy',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
