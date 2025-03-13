import 'package:antoinette/app/modules/Letters/views/letter_bar.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:flutter/material.dart';

class LetterScreen extends StatefulWidget {
  static const String routeName = '/letter-screen';
  const LetterScreen({super.key});

  @override
  State<LetterScreen> createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(name: 'Letters to you'),
              LetterBar(),           
            ],
          ),
        ),
      ),
    );
  }
}