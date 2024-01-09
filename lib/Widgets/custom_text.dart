import 'package:auto_size_text/auto_size_text.dart';
import 'package:iskaanowner/Utils/utils.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? fontWeight;
  final double fontSize;
  final int maxLines;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  const CustomText(
      {Key? key,
      required this.text,
      this.color,
      this.fontWeight = FontWeight.w500,
      this.fontSize = 16,
      this.textAlign,
      this.textDecoration,
      this.maxLines = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      style: TextStyle(
          color: color ?? const Color(0xff575757),
          fontWeight: fontWeight,
          fontSize: fontSize,
          decoration: textDecoration),
      overflow: TextOverflow.ellipsis,
    );
  }
}
