import '../Utils/utils.dart';

class RowText extends StatelessWidget {
  final String text;
  final String? text2;
  final void Function()? onTap;
  const RowText({Key? key, required this.text, this.onTap, this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          fontWeight: FontWeight.bold,
          fontsize: 14,
        ),
        InkWell(
          onTap: onTap,
          child: CustomText(
            text: text2 ?? "See all",
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
