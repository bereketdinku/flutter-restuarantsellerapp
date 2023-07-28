import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/text_stryle.dart';

Widget productImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .makeCentered()
      .box
      .color(lightGery)
      .size(70, 70)
      .make();
}
