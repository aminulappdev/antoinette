
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PriceRow extends StatelessWidget {
  final String name;
  final String price;
  final double nameSize;
  final double priceSize;
  const PriceRow({
    super.key,
    required this.name,
    required this.price,
    required this.nameSize,
    required this.priceSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: GoogleFonts.poppins(fontSize: nameSize),
        ),
        Text(
          price,
          style: GoogleFonts.poppins(fontSize: priceSize),
        ),
      ],
    );
  }
}