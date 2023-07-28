import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/widgets/text_stryle.dart';

import '../../const/const.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

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
          title:
              boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                height: 300,
                autoPlay: true,
                aspectRatio: 16 / 9,
                itemCount: data['p_imgs'].length,
                itemBuilder: ((context, index) {
                  return Image.network(
                    data['p_imgs'][index],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                })),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 16.0),
                  10.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      boldText(
                          text: "${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0)
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    // value: 4,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    maxRating: 5,
                    count: 5,
                    // stepInt: true,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(text: "${data['p_price']}", color: red, size: 18.0),
                  10.heightBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: normaltext(text: "Color", color: fontGrey),
                          ),
                          Row(
                            children: List.generate(
                                data['p_colors'].length,
                                (index) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VxBox()
                                            .size(40, 40)
                                            .roundedFull
                                            .color(
                                                Color(data['p_colors'][index]))
                                            .margin(const EdgeInsets.symmetric(
                                                horizontal: 4))
                                            .make()
                                            .onTap(() {}),
                                      ],
                                    )),
                          )
                        ],
                      ),
                      10.heightBox,
                      Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: boldText(text: "Quantity", color: fontGrey),
                          ),
                          normaltext(
                              text: "${data['p_quantity']} items",
                              color: fontGrey)
                        ],
                      )
                    ],
                  ).box.white.padding(const EdgeInsets.all(8)).make(),
                  Divider(),
                  20.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normaltext(text: "${data['p_desc']}", color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
