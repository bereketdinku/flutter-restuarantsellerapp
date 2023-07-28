import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/controller/profile_controller.dart';
import 'package:seller_app/widgets/custom_textfeild.dart';
import 'package:seller_app/widgets/loading_indicator.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import '../../const/const.dart';

class ShoppingSetting extends StatelessWidget {
  const ShoppingSetting({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: shopSetting, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                          shopname: controller.shopNameController,
                          shopaddress: controller.shopAddressController,
                          shopwebsite: controller.shopWebsiteController,
                          shopmobile: controller.shopMobileController,
                          shopdesc: controller.shopDescController);
                      VxToast.show(context, msg: "Shop updated");
                    },
                    child: normaltext(text: save))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  hint: nameHint,
                  label: "Name",
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: "Address",
                  hint: shopAddressHint,
                  controller: controller.shopAddressController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: shopwebsiteHint,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  label: shopmobile,
                  hint: shopMobileHint,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  isDesc: true,
                  label: description,
                  hint: shopdescription,
                  controller: controller.shopDescController),
            ],
          ),
        ),
      ),
    );
  }
}
