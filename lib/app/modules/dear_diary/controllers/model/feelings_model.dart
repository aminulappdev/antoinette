import 'package:flutter/material.dart';

class FeelingsModel {
  final String emojiPath;
  final String name;
  final Color bgColor;
  final Color borderColor;
  final Color fontColor;
  final VoidCallback ontap;

  FeelingsModel(
    this.name,
    this.bgColor,
    this.borderColor,
    this.ontap, {
    required this.fontColor,
    required this.emojiPath,
  });
}
