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
  final bool obsureText;
  final EdgeInsetsGeometry? contentPadding;
  final String? initialValue;
  final bool? enabled;
  final Color? fillColor;
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
      this.enabled,
      this.obsureText = false,
      this.onChanged,
      this.initialValue,
      this.fillColor = kWhite});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      enabled: enabled,
      initialValue: initialValue,
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      obscureText: obsureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        contentPadding:
            contentPadding ?? const EdgeInsets.symmetric(horizontal: 20),
        filled: true,
        prefixIcon: prefix,
        fillColor: fillColor,
        label: label,
        suffixIcon: suffix,
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kTransparent),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
