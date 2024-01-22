import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class RowText extends StatelessWidget {
  final String text;
  final String? text2;
  final Color? color;
  final void Function()? onTap;
  const RowText({
    Key? key,
    required this.text,
    this.onTap,
    this.text2,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: text,
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.width * 0.035,
          textAlign: TextAlign.left,
        ),
        const Gap(20),
        Expanded(
          child: InkWell(
            onTap: onTap,
            child: CustomText(
              text: text2 ?? "See all",
              color: color ?? context.read<AppThemeCubit>().state.primaryColor,
              textAlign: TextAlign.right,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
