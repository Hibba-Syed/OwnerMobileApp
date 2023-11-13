import '../Utils/utils.dart';

class CustomButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final Widget? icon;
  final Color textColor;
  final TextAlign? textAlign;
  final VoidCallback function;
  final int maxLines;
  final bool invert;
  final double? width;
  final double? height;
  final EdgeInsets padding;
  final FontWeight fontWeight;
  final double fontsize;
  const CustomButton(
      {Key? key,
      this.buttonColor = primaryColor,
      required this.text,
      this.textAlign,
      this.width,
      this.icon,
      this.height = 50,
      this.fontsize = 13,
      this.maxLines = 5,
      this.padding = const EdgeInsets.all(10),
      this.textColor = kWhite,
      required this.function,
      this.invert = false,
      this.fontWeight = FontWeight.bold})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: invert == true
                ? Border.all(color: primaryColor, width: 1)
                : null,
            color: invert == true ? null : buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 10,
              ),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontsize,
              ),
              textAlign: textAlign,
              maxLines: maxLines,
            ),
          ],
        ),
      ),
    );
  }
}
