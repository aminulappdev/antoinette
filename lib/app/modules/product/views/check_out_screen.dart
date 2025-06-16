import 'package:antoinette/app/modules/payment/controllers/payment_controller.dart';
import 'package:antoinette/app/modules/payment/controllers/payment_services.dart';
import 'package:antoinette/app/modules/product/controllers/delivery_charge_controller.dart';
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
  final ProfileController profileController = Get.find<ProfileController>();
  final PaymentService paymentService = PaymentService();
  final DeliveryChargeController deliveryChargeController =
      Get.find<DeliveryChargeController>();

  int quantity = 1;
  late String myUserId;
  String? selectedShippingMethod = 'SD';
  String? deliveryMethod = 'Standard Delivery';

  dynamic price = 0.0;
  dynamic totalPrice = 0.0;
  dynamic mainTotalPrice = 0.0;
  int discount = 0;
  int item = 1;
  double deliveryCharge = 0.0;

  Map<String, dynamic>? shippingInfo;
  bool isLoadingDeliveryCharges = true;

  @override
  void initState() {
    super.initState();
    // Defer data fetching to avoid build phase issues
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileController.getProfileData();
      await deliveryChargeController.deliveryCharge();
      if (mounted) {
        setState(() {
          isLoadingDeliveryCharges = false;
          myUserId = profileController.profileData?.id ?? '';
          price = (widget.productModel.amount ?? 0.0) * quantity;
          discount = widget.productModel.discount ?? 0;
          _loadShippingInfo();
          _calculateTotalPrice();
        });
      }
    });
  }

  void _loadShippingInfo() {
    shippingInfo =
        StorageUtil.getData('shipping-information') as Map<String, dynamic>?;
    // Set default shipping method based on shopAddress and userState
    final String shopAddress = widget.productModel.storeAddress ?? '';
    final String userState = shippingInfo?['state']?.toString() ?? '';
    if (shopAddress == userState) {
      selectedShippingMethod = 'IT';
      deliveryMethod = 'In State';
    } else {
      selectedShippingMethod = 'OT';
      deliveryMethod = 'Out State';
    }
  }

  void _calculateTotalPrice() {
    if (selectedShippingMethod == 'IT' &&
        deliveryChargeController.deliverChargeData != null) {
      deliveryCharge =
          deliveryChargeController.deliverChargeData![0].charge?.toDouble() ??
              0.0;
    } else if (selectedShippingMethod == 'OT' &&
        deliveryChargeController.deliverChargeData != null) {
      deliveryCharge =
          deliveryChargeController.deliverChargeData![1].charge?.toDouble() ??
              0.0;
    } else if (selectedShippingMethod == 'SD' &&
        deliveryChargeController.deliverChargeData != null) {
      deliveryCharge =
          deliveryChargeController.deliverChargeData![2].charge?.toDouble() ??
              0.0;
    }
    totalPrice = (price + deliveryCharge) * ((100 - discount) / 100);
    mainTotalPrice = double.parse(totalPrice.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    final String shopAddress = widget.productModel.storeAddress ?? '';
    final String userState = shippingInfo?['state']?.toString() ?? '';
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
                heightBox5,
                if (shippingInfo == null || shippingInfo!.isEmpty)
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.iconButtonThemeColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await Get.to(() => const AddAdderssScreen());
                            if (mounted) {
                              setState(() {
                                _loadShippingInfo();
                              });
                            }
                          },
                          child: Text(
                            '+ Add Shipping Information',
                            style: GoogleFonts.poppins(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.iconButtonThemeColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
                            note: shippingInfo!['note']?.toString() ?? '',
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () async {
                            await Get.to(() => const AddAdderssScreen());
                            if (mounted) {
                              setState(() {
                                _loadShippingInfo();
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 18.r,
                            backgroundColor: AppColors.iconButtonThemeColor,
                            child: const Icon(Icons.edit,
                                size: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                heightBox4,
                Text(
                  'Choose Shipping Method',
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp, fontWeight: FontWeight.w500),
                ),
                isLoadingDeliveryCharges
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile<String>(
                            activeColor: AppColors.iconButtonThemeColor,
                            value: 'IT',
                            groupValue: selectedShippingMethod,
                            title: Text(
                              'In State - ₦${deliveryChargeController.deliverChargeData?[0].charge ?? 0}',
                              style: GoogleFonts.roboto(fontSize: 13.sp),
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -4),
                            onChanged: shopAddress == userState
                                ? (value) {
                                    setState(() {
                                      selectedShippingMethod = value;
                                      deliveryMethod = 'In State';
                                      _calculateTotalPrice();
                                    });
                                  }
                                : null, // Disable if shopAddress != userState
                          ),
                          RadioListTile<String>(
                            activeColor: AppColors.iconButtonThemeColor,
                            value: 'OT',
                            groupValue: selectedShippingMethod,
                            title: Text(
                              'Out Town - ₦${deliveryChargeController.deliverChargeData?[1].charge ?? 0}',
                              style: GoogleFonts.roboto(fontSize: 13.sp),
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -4),
                            onChanged: shopAddress != userState
                                ? (value) {
                                    setState(() {
                                      selectedShippingMethod = value;
                                      deliveryMethod = 'Out State';
                                      _calculateTotalPrice();
                                    });
                                  }
                                : null, // Disable if shopAddress == userState
                          ),
                          RadioListTile<String>(
                            activeColor: AppColors.iconButtonThemeColor,
                            value: 'SD',
                            groupValue: selectedShippingMethod,
                            title: Text(
                              'Standard Delivery - ₦${deliveryChargeController.deliverChargeData?[2].charge ?? 0}',
                              style: GoogleFonts.roboto(fontSize: 13.sp),
                            ),
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            visualDensity: const VisualDensity(vertical: -4),
                            onChanged: (value) {
                              setState(() {
                                selectedShippingMethod = value;
                                deliveryMethod = 'Standard Delivery';
                                _calculateTotalPrice();
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
                  price: '₦${(deliveryCharge).toStringAsFixed(2)}',
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
                                        productOrderFunction(
                                          profileController.profileData?.id ??
                                              '',
                                        );
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
                          ),
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
                      image: widget.productModel.images.isNotEmpty == true
                          ? NetworkImage('${widget.productModel.images[0].url}')
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
                      deliveryMethod!,
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
  ) async {
    final bool isSuccess = await productOrderController.orderProduct(
        productId: widget.productModel.id!,
        quantity: quantity,
        price: price,
        totalPrice: totalPrice,
        amount: totalPrice,
        discount: discount.toString(),
        userId: userId,
        deliveryCharge: deliveryCharge.toDouble(),
        billingName: shippingInfo?['full_name']?.toString() ?? '',
        streetAddress: shippingInfo?['street_address']?.toString() ?? '',
        phoneNumber: shippingInfo?['phone_number']?.toString() ?? '',
        apartment: shippingInfo?['appartment']?.toString() ?? '',
        town: shippingInfo?['town_city']?.toString() ?? '',
        state: shippingInfo?['state']?.toString() ?? '',
        country: shippingInfo?['country']?.toString() ?? '',
        note: shippingInfo?['note']?.toString() ?? '');

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