import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:seller_app/controller/product_controller.dart';
import 'package:seller_app/services/store_services.dart';
import 'package:seller_app/views/products/add_product.dart';
import 'package:seller_app/views/products/product_detail.dart';
import 'package:seller_app/widgets/appbar_widget.dart';

import '../../const/const.dart';
import '../../widgets/loading_indicator.dart';
import '../../widgets/text_stryle.dart';
import 'package:intl/intl.dart' as intl;

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          child: const Icon(Icons.add),
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategorylist();

            Get.to(() => const AddProduct());
          },
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                          data.length,
                          (index) => ListTile(
                                onTap: () {
                                  Get.to(() => ProductDetails(
                                        data: data[index],
                                      ));
                                },
                                leading: Image.network(data[index]['p_imgs'][0],
                                    width: 100, height: 100, fit: BoxFit.cover),
                                title: boldText(
                                    text: "${data[index]['p_name']}",
                                    color: fontGrey),
                                subtitle: Row(
                                  children: [
                                    normaltext(
                                        text: "${data[index]['p_price']}",
                                        color: darkgrey),
                                    10.widthBox,
                                    boldText(
                                        text: data[index]['is_featured'] == true
                                            ? "Featured"
                                            : '',
                                        color: green)
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                    child: Icon(Icons.more_vert_rounded),
                                    menuBuilder: () => Column(
                                          children: List.generate(
                                              popupMenuTitles.length,
                                              (i) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          popupmenuIconsList[i],
                                                          color: data[index][
                                                                          'featured_id'] ==
                                                                      currentUser!
                                                                          .uid &&
                                                                  i == 0
                                                              ? green
                                                              : darkgrey,
                                                        ),
                                                        5.widthBox,
                                                        normaltext(
                                                            text: data[index][
                                                                            'featured_id'] ==
                                                                        currentUser!
                                                                            .uid &&
                                                                    i == 0
                                                                ? "Add feature"
                                                                : popupMenuTitles[
                                                                    i],
                                                            color: darkgrey)
                                                      ],
                                                    ),
                                                  ).onTap(() {
                                                    switch (i) {
                                                      case 0:
                                                        if (data[index][
                                                                'is_featured'] ==
                                                            true) {
                                                          controller
                                                              .removeFeatured(
                                                                  data[index]
                                                                      .id);
                                                          VxToast.show(context,
                                                              msg: "Removed");
                                                        } else {
                                                          controller
                                                              .addFeatured(
                                                                  data[index]
                                                                      .id);
                                                          VxToast.show(context,
                                                              msg: "Added");
                                                        }
                                                        break;
                                                      case 1:
                                                        break;
                                                      case 2:
                                                        controller
                                                            .removeProduct(
                                                                data[index].id);
                                                        VxToast.show(context,
                                                            msg:
                                                                "Product removed");
                                                        break;
                                                      default:
                                                    }
                                                  })),
                                        ).box.white.rounded.width(200).make(),
                                    clickType: VxClickType.singleClick),
                              )),
                    ),
                  ),
                );
              }
            }));
  }
}
