import 'package:flutter/material.dart';

class AgreeConditionCheck extends StatefulWidget {
  const AgreeConditionCheck({
    super.key,
    required this.ontap,
  });

  final VoidCallback ontap;

  @override
  State<AgreeConditionCheck> createState() => _AgreeConditionCheckState();
}

class _AgreeConditionCheckState extends State<AgreeConditionCheck> {
  bool isChecked = false;

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
          },
        ),
        // Wrap the RichText with a Flexible widget
        Flexible(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: 'I agree to the ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: 'Terms & Conditions ',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black)),
                TextSpan(
                    text: 'and ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
