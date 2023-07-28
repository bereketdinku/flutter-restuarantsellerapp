import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/orders/order_details.dart';
import 'package:seller_app/widgets/appbar_widget.dart';
import 'package:seller_app/widgets/text_stryle.dart';
import 'package:intl/intl.dart' as intl;

import '../../controller/order_controller.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: List.generate(
                20,
                (index) => ListTile(
                      onTap: () {
                        Get.to(() => const OrderDetails());
                      },
                      textColor: textfieldGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(text: "Product title", color: fontGrey),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(
                                  text: intl.DateFormat()
                                      .add_yMEd()
                                      .format(DateTime.now()),
                                  color: darkgrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              boldText(text: unpaid, color: red),
                            ],
                          )
                        ],
                      ),
                      trailing: boldText(
                          text: "40.0", color: purpleColor, size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make()),
          ),
        ),
      ),
    );
  }
}
