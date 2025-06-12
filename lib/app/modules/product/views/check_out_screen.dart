import 'package:antoinette/app/modules/payment/controllers/payment_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/product/controllers/product_order_controller.dart';
import 'package:antoinette/app/modules/product/model/product_details_model.dart';
import 'package:antoinette/app/modules/product/widgets/checkout_user_info.dart';
import 'package:antoinette/app/modules/product/widgets/price_row.dart';
import 'package:antoinette/app/modules/profile/controllers/profile_controller.dart';
import 'package:antoinette/app/modules/profile/views/add_address.dart';
import 'package:antoinette/app/utils/app_colors.dart';
import 'package:antoinette/app/utils/responsive_size.dart';
import 'package:antoinette/app/widgets/costom_app_bar.dart';
import 'package:antoinette/app/widgets/gradiant_elevated_button.dart';
import 'package:antoinette/app/widgets/show_snackBar_message.dart';
import 'package:antoinette/get_storage.dart';
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

  int quantity = 1;
  late String myUserId;
  String deliveryAddress = '';
  String? selectedShippingMethod = 'standard';

  double price = 0.0;
  double totalPrice = 0.0;
  double mainTotalPrice = 0.0;
  int discount = 0;
  int item = 1;

  Map<String, dynamic>? shippingInfo;

  @override
  void initState() {
    super.initState();
    profileController.getProfileData();
    // Fetch initial shipping information
    _loadShippingInfo();
    myUserId = profileController.profileData?.id ?? '';
    price = (widget.productModel.amount ?? 0.0) * quantity;
    discount = widget.productModel.discount ?? 0;
    _calculateTotalPrice();
  }

  void _loadShippingInfo() {
    setState(() {
      shippingInfo =
          StorageUtil.getData('shipping-information') as Map<String, dynamic>?;
      deliveryAddress = shippingInfo != null
          ? '${shippingInfo!['street_address']}, ${shippingInfo!['appartment']}, ${shippingInfo!['town_city']}, ${shippingInfo!['state']}, ${shippingInfo!['country']}'
          : profileController.profileData?.homeAddress ??
              'Please update your address';
    });
  }

  void _calculateTotalPrice() {
    totalPrice = (price + 5.0) * ((100 - discount) / 100);
    mainTotalPrice = double.parse(totalPrice.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(builder: (controller) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox24,
                CustomAppBar(name: 'Checkout'),
                heightBox8,
                Text(
                  'Shipping information',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                // Show InkWell only when shippingInfo is null or empty
                if (shippingInfo == null || shippingInfo!.isEmpty)
                  InkWell(
                    onTap: () async {
                      // Navigate to AddAddressScreen and wait for result
                      await Get.to(() => const AddAdderssScreen());
                      // Reload shipping info after returning
                      _loadShippingInfo();
                    },
                    child: Row(children: [
                      Text(
                        '+ Add Shipping Information',
                        style: GoogleFonts.poppins(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.iconButtonThemeColor),
                      ),
                    ]),
                  ),
                // Show Card with CheckoutUserInfo only when shippingInfo is not null and not empty
                if (shippingInfo != null && shippingInfo!.isNotEmpty)
                  Stack(
                    children: [
                      Card(
                        color: Colors.white,
                        elevation: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CheckoutUserInfo(
                            name: shippingInfo!['full_name']?.toString() ??
                                controller.profileData?.name ??
                                'Name',
                            number: shippingInfo!['phone_number']?.toString() ??
                                controller.profileData?.contactNumber ??
                                '+49 176 12345678',
                            streetAddress:
                                shippingInfo!['street_address']?.toString() ??
                                    '',
                            appartment:
                                shippingInfo!['appartment']?.toString() ?? '',
                            town: shippingInfo!['town_city']?.toString() ?? '',
                            state: shippingInfo!['state']?.toString() ?? '',
                            country: shippingInfo!['country']?.toString() ?? '',
                          ),
                        ),
                      ),
                      Positioned(
                          right: 10,
                          top: 10,
                          child: InkWell(
                            onTap: () {
                              // Navigate to AddAddressScreen and wait for result
                              Get.to(() => const AddAdderssScreen());
                              // Reload shipping info after returning
                              _loadShippingInfo();
                            },
                            child: CircleAvatar(
                                radius: 18.r,
                                backgroundColor: AppColors.iconButtonThemeColor,
                                child: const Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.white,
                                )),
                          ))
                    ],
                  ),
                heightBox4,
                Text(
                  'Choose Shipping Method',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile<String>(
                      activeColor: AppColors.iconButtonThemeColor,
                      value: 'standard',
                      groupValue: selectedShippingMethod,
                      title: Text(
                        'Standard Delivery',
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      onChanged: (value) {
                        setState(() {
                          selectedShippingMethod = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      activeColor: AppColors.iconButtonThemeColor,
                      value: 'express',
                      groupValue: selectedShippingMethod,
                      title: Text(
                        'Express Delivery',
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      onChanged: (value) {
                        setState(() {
                          selectedShippingMethod = value;
                        });
                      },
                    ),
                    RadioListTile<String>(
                      activeColor: AppColors.iconButtonThemeColor,
                      value: 'next_day',
                      groupValue: selectedShippingMethod,
                      title: Text(
                        'Next Day Delivery',
                        style: GoogleFonts.poppins(fontSize: 14.sp),
                      ),
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: const VisualDensity(vertical: -4),
                      onChanged: (value) {
                        setState(() {
                          selectedShippingMethod = value;
                        });
                      },
                    ),
                  ],
                ),
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
                  price: price.toStringAsFixed(2),
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'Shipping Fee',
                  price: '₦5.00',
                  nameSize: 14,
                  priceSize: 14,
                ),
                heightBox8,
                PriceRow(
                  name: 'Discount',
                  price: '$discount%',
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
                  price: mainTotalPrice.toStringAsFixed(2),
                  nameSize: 16,
                  priceSize: 16,
                ),
                SizedBox(height: 230),
                Container(
                  height: 70.h,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SizedBox(
                            width: 159.w,
                            height: 42.h,
                            child: GetBuilder<ProductOrderController>(
                              builder: (orderController) {
                                bool isLoading = orderController.inProgress;
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    IgnorePointer(
                                      ignoring: isLoading,
                                      child: GradientElevatedButton(
                                        onPressed: () {
                                          if (deliveryAddress ==
                                              'Please update your address') {
                                            showSnackBarMessage(
                                              context,
                                              'Please fill-up your address',
                                              true,
                                            );
                                          } else {
                                            productOrderFunction(
                                              profileController
                                                      .profileData?.id ??
                                                  '',
                                              '5',
                                              shippingInfo?['full_name']
                                                      ?.toString() ??
                                                  profileController
                                                      .profileData?.name ??
                                                  'Name',
                                              '10-10-2024',
                                              deliveryAddress,
                                              shippingInfo?['phone_number']
                                                      ?.toString() ??
                                                  profileController.profileData
                                                      ?.contactNumber ??
                                                  '+49 176 12345678',
                                              profileController
                                                      .profileData?.email ??
                                                  '',
                                            );
                                          }
                                        },
                                        text: isLoading ? '' : 'Place order',
                                      ),
                                    ),
                                    if (isLoading)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      ),
                                  ],
                                );
                              },
                            )),
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
      height: 95.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
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
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: widget.productModel.images?.isNotEmpty == true
                          ? NetworkImage(
                              '${widget.productModel.images?[0].url}')
                          : const NetworkImage(
                              'https://defaultimageurl.com/default.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                widthBox8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard delivery',
                      style: GoogleFonts.poppins(fontSize: 14.sp),
                    ),
                    heightBox14,
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (quantity > 1) {
                                quantity--;
                                price = (widget.productModel.amount ?? 0.0) *
                                    quantity;
                                item--;
                                _calculateTotalPrice();
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: Colors.grey,
                            child: const Icon(Icons.remove),
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
                            setState(() {
                              if (widget.productModel.quantity! > quantity) {
                                quantity++;
                                price = (widget.productModel.amount ?? 0.0) *
                                    quantity;
                                item++;
                                _calculateTotalPrice();
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 13.r,
                            backgroundColor: AppColors.iconButtonThemeColor,
                            child: const Icon(Icons.add, color: Colors.white),
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
              child: Text(
                price.toStringAsFixed(2),
                style: GoogleFonts.poppins(fontSize: 20.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> productOrderFunction(
    String userId,
    String deliveryCharge,
    String billingName,
    String pickupDate,
    String address,
    String phoneNumber,
    String email,
  ) async {
    final bool isSuccess = await productOrderController.orderProduct(
      widget.productModel.sId!,
      quantity,
      price,
      mainTotalPrice,
      discount.toString(),
      userId,
      mainTotalPrice,
      deliveryCharge,
      billingName,
      pickupDate,
      address,
      phoneNumber,
      email,
    );

    if (isSuccess) {
      if (mounted) {
        paymentService.payment(
          context,
          'Order',
          userId,
          productOrderController.orderResponseData!.id!,
        );
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, productOrderController.errorMessage!, true);
      }
    }
  }
}
