import 'package:antoinette/app/modules/product/widgets/checkout_user_info.dart';
import 'package:antoinette/app/modules/product/widgets/deliveryCard.dart';
import 'package:antoinette/app/modules/product/widgets/delivery_option_row.dart';
import 'package:antoinette/app/modules/product/widgets/delivery_price_calculator.dart';
import 'package:antoinette/app/modules/product/widgets/price_row.dart';
import 'package:antoinette/app/modules/session/views/session_details.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutScreen extends StatefulWidget {
  static const String routeName = '/checkout-screen';
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(name: 'Checkout'),
                heightBox8,
                CheckoutUserInfo(
                  name: 'Sunan Rahman',
                  number: '+49 176 12345678',
                  status: 'home',
                  address: '123 Main Street, Berlin, Germany, 10115',
                  editOntap: () {},
                  addressArrowOntap: () {},
                ),
                heightBox12,
                DeliveryOptionRow(
                  name: 'Delivery Oction',
                  ontap: () {},
                ),
                heightBox8,
                DeliveryCard(
                  deliveryType: 'Standard Delivery',
                  date: 'By 30 Dec - 3 jan',
                  price: '\$5.00',
                ),
                heightBox12,
                DeliveryPriceCalulator(
                  deliveryType: 'Standard Delivery',
                  quantity: '1',
                  price: '\$5.00',
                  minusTap: () {},
                  plusTap: () {},
                ),
                heightBox12,
                Text(
                  'Price Details',
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500),
                ),
                heightBox12,
                PriceRow(
                  name: 'Price (1 item)',
                  price: '\$89.99',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'Shiping Fee',
                  price: '\$89.99',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox4,
                Container(
                  height: 1.5,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                heightBox12,
                PriceRow(
                  name: 'Total Payment:',
                  price: '\$89.99',
                  nameSize: 16,
                  priceSize: 16,
                ),
                SizedBox(
                  height: 230,
                ),
                Container(
                  height: 70,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: 159,
                          height: 42,
                          child: GradientElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, SessionDetailsScreen.routeName);
                              }, text: 'Place order'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
