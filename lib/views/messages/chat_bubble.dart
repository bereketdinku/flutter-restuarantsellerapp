import 'package:seller_app/const/const.dart';
import 'package:seller_app/widgets/text_stryle.dart';

Widget chatBubble() {
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: const BoxDecoration(
            color: purpleColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            normaltext(text: "Your message here..."),
            10.heightBox,
            normaltext(text: "10:45PM")
          ],
        ),
      ));
}
