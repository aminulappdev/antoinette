import 'package:antoinette/app/modules/order/controllers/all_orders_controllers.dart';
import 'package:antoinette/app/modules/order/widget/my_order_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({super.key});

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final AllOrderController allOrderController = Get.find<AllOrderController>();
  @override
  void initState() {
    allOrderController.getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<AllOrderController>(builder: (controller) {
          if (controller.inProgress) {
            return Center(child: CircularProgressIndicator());
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: controller.ordersData?.length,
              itemBuilder: (context, index) {
                return MyOrderCard(
                  imagePath: '',
                  price: '${controller.ordersData?[index].amount}',
                  productName: '${controller.ordersData?[index].status}',
                  quantity: '${controller.ordersData?[index].deliveryCharge}',
                  isShowSeconBTN:  controller.ordersData?[index].status == 'pending' ? false : true,
                  status: '${controller.ordersData?[index].status}',
                  mainBTNOntap: () {},
                  secondBTNOntap: () {}, 
                  secondBTNName: 'Buy Again',
                );
              },
            ),
          );
        })
      ],
    );
  }
}
