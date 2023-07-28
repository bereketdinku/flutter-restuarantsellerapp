import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/views/products/component/product_dropdown.dart';
import 'package:seller_app/views/products/component/product_image.dart';
import 'package:seller_app/widgets/custom_textfeild.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import '../../controller/product_controller.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    return Obx(
      () => Scaffold(
          backgroundColor: purpleColor,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                )),
            title: boldText(text: "Add product", size: 16.0),
            actions: [
              // controller.isLoading(false);

              TextButton(
                  onPressed: () async {
                    controller.isLoading(true);
                    await controller.uploadImages();
                    await controller.uploadProduct(context);
                    Get.back();
                  },
                  child: boldText(text: save, color: white)),
            ],
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. BMW",
                    label: "Product name",
                    controller: controller.pnameController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice product",
                    label: "Description",
                    isDesc: true,
                    controller: controller.pdescController),
                10.heightBox,
                customTextField(
                    hint: "eg. 20",
                    label: "Quantity",
                    controller: controller.pquantityController),
                10.heightBox,
                customTextField(
                    hint: "eg. 20",
                    label: "price",
                    controller: controller.ppriceController),
                10.heightBox,
                productDropdown("Category", controller.categoryList,
                    controller.categoryvalue, controller),
                10.heightBox,
                productDropdown("Subcategory", controller.subcategoryList,
                    controller.subcategoryvalue, controller),
                10.heightBox,
                const Divider(
                  color: white,
                ),
                normaltext(text: "First image will be your display images"),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      3,
                      (index) => controller.pImageslist[index] != null
                          ? Image.file(
                              controller.pImageslist[index],
                              width: 70,
                            )
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            })),
                ),
                5.heightBox,
                const Divider(
                  color: white,
                ),
                10.heightBox,
                boldText(text: "Choose product colors"),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 4.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        7,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomPrimaryColor)
                                    .roundedFull
                                    .size(50, 50)
                                    .make(),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
