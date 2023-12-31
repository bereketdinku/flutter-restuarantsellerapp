import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/products/product_detail.dart';
import 'package:seller_app/widgets/appbar_widget.dart';
import 'package:seller_app/widgets/dashboard_button.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';
import 'package:intl/intl.dart' as intl;

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                data = data.sortedBy(((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p-wishlist'].length)));
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: products,
                                count: "${data.length}",
                                icon: icProducts),
                            dashboardButton(context,
                                title: orders, count: 7, icon: icOrders)
                          ],
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            dashboardButton(context,
                                title: rating, count: 77, icon: icStar),
                            dashboardButton(context,
                                title: totalSell, count: 7, icon: icOrders)
                          ],
                        ),
                        10.heightBox,
                        Divider(),
                        10.heightBox,
                        boldText(text: popular, color: darkgrey),
                        20.heightBox,
                        Expanded(
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            children: List.generate(
                                data.length,
                                (index) => data[index]['p_wishlist'].length == 0
                                    ? SizedBox()
                                    : ListTile(
                                        onTap: () {
                                          Get.to(() => ProductDetails(
                                                data: data[index],
                                              ));
                                        },
                                        leading: Image.network(
                                          data[index]['p_imgs'][0],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        title: boldText(
                                            text: "${data[index]['p_name']}",
                                            color: darkgrey),
                                        subtitle: normaltext(
                                            text: "${data[index]['p_price']}",
                                            color: darkgrey),
                                      )),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
