import '../const/const.dart';
import 'text_stryle.dart';

Widget Button({title, color, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0));
}
