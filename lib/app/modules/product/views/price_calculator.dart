// // price_calculator.dart
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:antoinette/app/utils/app_colors.dart'; // Adjust the import path if necessary
// import 'package:antoinette/app/utils/assets_path.dart'; // Adjust the import path if necessary

// class PriceCalculator extends StatelessWidget {
//   final double price;
//   final int quantity;
//   final int item;
//   final Function(int) onQuantityChange;
//   final String imagePath; // To set the image for the delivery item

//   const PriceCalculator({
//     Key? key,
//     required this.price,
//     required this.quantity,
//     required this.item,
//     required this.onQuantityChange,
//     required this.imagePath,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 91,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(20)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Container(
//                   height: 77,
//                   width: 75,
//                   decoration: BoxDecoration(
//                       image: DecorationImage(
//                           image: AssetImage(imagePath),
//                           fit: BoxFit.fill),
//                       borderRadius: BorderRadius.circular(12)),
//                 ),
//                 SizedBox(width: 8),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Standard delivery',
//                       style: GoogleFonts.poppins(fontSize: 14),
//                     ),
//                     SizedBox(height: 14),
//                     Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             if (quantity > 1) {
//                               onQuantityChange(-1);
//                             }
//                           },
//                           child: CircleAvatar(
//                             radius: 13,
//                             backgroundColor: Colors.grey,
//                             child: Icon(Icons.remove),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Text(
//                           quantity.toString(),
//                           style: GoogleFonts.poppins(fontSize: 21),
//                         ),
//                         SizedBox(width: 8),
//                         GestureDetector(
//                           onTap: () {
//                             onQuantityChange(1);
//                           },
//                           child: CircleAvatar(
//                             radius: 13,
//                             backgroundColor: AppColors.iconButtonThemeColor,
//                             child: Icon(
//                               Icons.add,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: Text(
//                 price.toStringAsFixed(2),
//                 style: GoogleFonts.poppins(fontSize: 20),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
