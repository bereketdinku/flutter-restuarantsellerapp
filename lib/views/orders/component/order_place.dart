import '../../../const/const.dart';
import '../../../widgets/text_stryle.dart';

Widget orderPlaceDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: "$title1", color: purpleColor),
            boldText(text: "$d1", color: red)
            // "$title1".text.fontFamily(semibold).make(),
            // "$d1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: "$title2", color: fontGrey),
              boldText(text: "$d2", color: fontGrey)
              // "$title2".text.fontFamily(semibold).make(),
              // "$d2".text.make()
            ],
          ),
        )
      ],
    ),
  );
}
