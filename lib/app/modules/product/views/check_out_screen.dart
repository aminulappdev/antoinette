
import 'package:antoinette/app/modules/payment/controllers/payment_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/product/controllers/product_order_controller.dart';
import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/modules/product/widgets/checkout_user_info.dart';
import 'package:antoinette/app/modules/product/widgets/price_row.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/assets_path.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutScreen extends StatefulWidget {
  final ProductModel productModel;
  static const String routeName = '/checkout-screen';
  const CheckOutScreen({super.key, required this.productModel});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {

  final PaymentController paymentController = PaymentController();
  final ProductOrderController productOrderController =
      Get.find<ProductOrderController>();
  ProfileController profileController = Get.find<ProfileController>();
  final PaymentService paymentService = PaymentService();

  int selectedButtonIndex = 0;
  String deliveryAddress = '';
  final List<String> buttonNames = ['Home', 'Office', 'Delivery'];
  int quantity = 1;

  late String myUserId;

  double price = 0.0;
  double totalPrice = 0;
  double mainTotalPrice = 0;
  int discount = 0;
  int item = 1;

  @override
  void initState() {
    profileController.getProfileData();
    deliveryAddress = profileController.profileData!.homeAddress!;
    myUserId = profileController.profileData!.id!;
    price = widget.productModel.amount!;
    discount = widget.productModel.discount!;
    //  price = 20;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    totalPrice = (price + 50) * ((100 - discount) / 100);
    mainTotalPrice = double.parse(totalPrice.toStringAsFixed(2));
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        // address = controller.profileData!.homeAddress!;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                // Custom AppBar
                CustomAppBar(name: 'Checkout'),
                heightBox8,
    
                // Checkout User Info
                CheckoutUserInfo(
                  name: 'Sunan Rahman',
                  number: '+49 176 12345678',
                ),
                heightBox8,
    
                // Row with Home, Office, Delivery buttons
                Row(
                  children: List.generate(3, (index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedButtonIndex =
                                index; // Update selected button
                            if (selectedButtonIndex == 0) {
                              deliveryAddress =
                                  controller.profileData!.homeAddress!;
                            } else if (selectedButtonIndex == 1) {
                              deliveryAddress =
                                  controller.profileData!.officeAddress!;
                            } else if (selectedButtonIndex == 2) {
                              deliveryAddress =
                                  controller.profileData!.deliveryAddress!;
                            }
                          });
                        },
                        child: Container(
                          height: 19.h,
                          width: 54.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: selectedButtonIndex == index
                                ? Colors.blue // Change color on selection
                                : const Color.fromARGB(
                                    255, 218, 211, 211), // Default color
                          ),
                          child: Center(
                            child: Text(
                              buttonNames[index],
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: selectedButtonIndex == index
                                      ? Colors.white
                                      : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                heightBox8,
    
                // Display the selected text below
                SizedBox(
                  width: 170,
                  child: Text(
                    deliveryAddress,
                    style: GoogleFonts.poppins(fontSize: 10.sp),
                  ),
                ),
                heightBox8,
    
                // Delivery section
                SizedBox(
                    width: 170,
                    child: Text(
                      'Delivery',
                      style: GoogleFonts.poppins(fontSize: 10.sp),
                    )),
    
                heightBox12,
                priceCalculator(context),               
                heightBox12,
                Text(
                  'Price Details',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                heightBox12,
                PriceRow(
                  name: 'Price ($item item)',
                  price: double.parse(price.toStringAsFixed(2)).toString(),
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'Shipping Fee',
                  price: '\$5.00',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'Discount',
                  price: '20%',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox4,
                Container(
                  height: 1.5.h,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                heightBox12,
                PriceRow(
                  name: 'Total Payment:',
                  price: mainTotalPrice.toString(),
                  nameSize: 16,
                  priceSize: 16,
                ),
                SizedBox(
                  height: 230,
                ),
    
                // Place Order Button
                Container(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SizedBox(
                          width: 159.w,
                          height: 42.h,
                          child: GradientElevatedButton(
                              onPressed: () {
                                controller.profileData?.sId!;
    
                                '10';
                                controller.profileData?.name!;
                                '10-10-2024';
                                controller.profileData?.homeAddress!;
                                controller.profileData?.contactNumber!;
                                controller.profileData?.email!;
    
                                onTapToNextButton(
                                  controller.profileData!.sId!,
                                  '10',
                                  controller.profileData!.name!,
                                  '10-10-2024',
                                  deliveryAddress,
                                  controller.profileData?.contactNumber!,
                                  controller.profileData?.email!,
                                );
                              },
                              text: 'Place order'),
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
 
  Container priceCalculator(BuildContext context) {
    return Container(
      height: 91.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 77.h,
                  width: 75.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(AssetsPath.medichine),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(12.r)),
                ),
                widthBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stander delivery',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    heightBox14,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print('minus');
                            setState(() {
                              if (quantity > 1) {
                                double? minus = widget.productModel.amount;
                                quantity--;
                                price = double.parse(price.toStringAsFixed(2)) -
                                    double.parse(minus!.toStringAsFixed(2));
                                item--;
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.grey,
                            child: Icon(Icons.remove),
                          ),
                        ),
                        widthBox8,
                        Text(
                          quantity.toString(),
                          style: GoogleFonts.poppins(fontSize: 21.sp),
                        ),
                        widthBox8,
                        GestureDetector(
                          onTap: () {
                            print('minus');
                            setState(() {
                              if (widget.productModel.quantity! > quantity) {
                                double? plus = widget.productModel.amount;
                                quantity++;
                                price = double.parse(price.toStringAsFixed(2)) +
                                    double.parse(plus!.toStringAsFixed(2));
                                
                                item++;
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: AppColors.iconButtonThemeColor,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  double.parse(price.toStringAsFixed(2)).toString(),
                  style: GoogleFonts.poppins(fontSize: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTapToNextButton(
      String userId,
      String deliveryCharge,
      String billingName,
      String pickupDate,
      String adress,
      phoneNumber,
      email) async {
    final bool isSuccess = await productOrderController.orderProduct(
        widget.productModel.sId!,
        quantity,
        price,
        totalPrice,
        discount.toString(),
        userId,
        totalPrice,
        deliveryCharge,
        billingName,
        pickupDate,
        adress,
        phoneNumber,
        email);

    if (isSuccess) {
      print('Reference id is...........');
      print(productOrderController.orderResponseData!.id!);

      if (mounted) {     
           paymentService.payment(
          context,
          'Order',
          userId,
          productOrderController.orderResponseData!.id!,
        );
      
      } else {
        if (mounted) {
          showSnackBarMessage(
              context, productOrderController.errorMessage!, true);
        }
      }
    } else {
      if (mounted) {
        print('Error show ----------------------------------');
        showSnackBarMessage(
            context, productOrderController.errorMessage!, true);
      }
    }
    // Navigator.pushNamed(context, MainButtonNavbarScreen.routeName);
  }

}
