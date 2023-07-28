import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/text_stryle.dart';
import '../../../controller/product_controller.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
        child: DropdownButton(
            hint: normaltext(text: "$hint", color: fontGrey),
            value: dropvalue == '' ? null : dropvalue.value,
            items: list.map((e) {
              return DropdownMenuItem(
                child: e.toString().text.make(),
                value: e,
              );
            }).toList(),
            onChanged: (newvalue) {
              if (hint == "Category") {
                controller.subcategoryvalue.value = '';
                controller.populateSubCategory(newvalue.toString());
              }
              dropvalue.value = newvalue.toString();
            })).box.white.roundedSM.make(),
  );
}
