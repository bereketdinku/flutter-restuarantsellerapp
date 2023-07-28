import 'package:seller_app/widgets/text_stryle.dart';
import 'package:intl/intl.dart' as intl;
import '../const/const.dart';

AppBar appbarWidget(title) {
  return AppBar(
    actions: [
      normaltext(
          text: intl.DateFormat('EEE,MMM d,' 'yy').format(DateTime.now()),
          color: darkgrey)
    ],
    automaticallyImplyLeading: false,
    title: boldText(text: title, size: 18.0, color: darkgrey),
  );
}
