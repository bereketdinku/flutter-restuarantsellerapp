import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';

import '../../widgets/button.dart';
import '../../widgets/text_stryle.dart';
import 'component/order_place.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkgrey,
            )),
        title: boldText(text: "Order details", color: fontGrey, size: 16.0),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        width: context.screenWidth,
        child: Button(color: green, onPress: () {}, title: "Confirm Order"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(children: [
            //order delivery status section
            Visibility(
              visible: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "Order status", color: purpleColor, size: 16.0),
                  SwitchListTile(
                    activeColor: green,
                    value: true,
                    onChanged: (value) {},
                    title: boldText(text: "Placed", color: fontGrey),
                  ),
                  SwitchListTile(
                    activeColor: green,
                    value: true,
                    onChanged: (value) {},
                    title: boldText(text: "Confirmed", color: fontGrey),
                  ),
                  SwitchListTile(
                    activeColor: green,
                    value: false,
                    onChanged: (value) {},
                    title: boldText(text: "on Delivery", color: fontGrey),
                  ),
                  SwitchListTile(
                    activeColor: green,
                    value: false,
                    onChanged: (value) {},
                    title: boldText(text: "Delivered", color: fontGrey),
                  )
                ],
              )
                  .box
                  .padding(const EdgeInsets.all(8))
                  .outerShadowMd
                  .white
                  .border(color: lightGery)
                  .roundedSM
                  .make(),
            ),

            //order details section
            Column(
              children: [
                orderPlaceDetails(
                    d1: "data['order_code']",
                    d2: "data['shipping_method']",
                    title1: "Order Code",
                    title2: "Shipping Method"),
                orderPlaceDetails(
                    d1: DateTime.now(),
                    d2: "data['payment_method']",
                    title1: "Order Date",
                    title2: "Payment Method"),
                orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // "Shipping Address".text.fontFamily(semibold).make(),
                          boldText(
                              text: "Shipping Address", color: purpleColor),
                          "{data['order_by_name']}".text.make(),
                          "{data['order_by_email']}".text.make(),
                          "{data['order_by_address']}".text.make(),
                          "{data['order_by_city']}".text.make(),
                          "{data['order_by_state']}".text.make(),
                          "{data['order_by_phone']}".text.make(),
                          "{data['order_by_postal']}".text.make()
                        ],
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // "Total Amount".text.fontFamily(semibold).make(),
                            boldText(text: "Total Amount", color: purpleColor),
                            boldText(text: "400", color: red, size: 16.0)
                            // "{data['total_amount']}"
                            //     .text
                            //     .fontFamily(semibold)
                            //     .color(redColor)
                            //     .make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.outerShadowMd.white.border(color: lightGery).roundedSM.make(),
            const Divider(),
            10.heightBox,
            boldText(text: "Orders product", color: fontGrey, size: 16.0),
            10.heightBox,
            ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(3, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                        title1: "data['orders'][index]['title']",
                        title2: "data['orders'][index]['tprice']",
                        d1: "{data['orders'][index]['qty']}X",
                        d2: "Refundable"),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child:
                          Container(width: 30, height: 10, color: purpleColor),
                    ),
                    const Divider(),
                  ],
                );
              }).toList(),
            )
                .box
                .shadowMd
                .white
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
          ]),
        ),
      ),
    );
  }
}
