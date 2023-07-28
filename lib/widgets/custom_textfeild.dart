import 'package:seller_app/widgets/text_stryle.dart';

import '../const/const.dart';

Widget customTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    style: const TextStyle(color: white),
    maxLines: isDesc ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normaltext(
        text: label,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGery),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)),
    ),
  );
}
