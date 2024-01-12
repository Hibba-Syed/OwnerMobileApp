import 'package:iskaanowner/Utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final Widget? label;
  final TextInputType? keyboardType;
  final int? maxLines;
  final String? Function(String?)? validator;
  final String? hintText;
  final void Function(String)? onChanged;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final bool? readOnly;
  final Color? fillColor;
  final void Function()? onTap;
  const CustomTextField(
      {super.key,
      this.prefix,
      this.suffix,
      this.label,
      this.contentPadding,
      this.hintText,
      this.maxLines = 1,
      this.validator,
      this.keyboardType,
      this.readOnly,
      this.obscureText = false,
      this.onChanged,
      this.initialValue,
      this.onTap,
      this.fillColor = kWhite});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      maxLines: maxLines,
      // enabled: enabled,
      onTap: onTap,
      initialValue: initialValue,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(vertical: 15),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: kBlack.withOpacity(0.7))),
        filled: true,
        prefixIcon: prefix,
        fillColor: fillColor,
        label: label,
        suffixIcon: suffix,
        hintText: hintText,
      ),
    );
  }
}
