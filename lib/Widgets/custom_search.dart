import 'package:flutter/cupertino.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class CustomSearch extends StatelessWidget {
  final bool enabled;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onSubmitted;
  final bool autofocus;
  final dynamic function;
  final String? initialValue;
  final Color? fillColor;
  const CustomSearch({
    Key? key,
    this.enabled = true,
    this.function,
    this.onEditingComplete,
    this.autofocus = false,
    this.onSubmitted,
    this.onChanged,
    this.fillColor,
    this.hintText,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kTransparent,
      child: TextFormField(
        initialValue: initialValue,
        autofocus: autofocus,
        enabled: enabled,
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
          hintText: hintText ?? "Search by keyword",
          isDense: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kTransparent)),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kTransparent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kTransparent)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: kTransparent)),
          fillColor: fillColor ?? kWhite,
          filled: true,
        ),
        onFieldSubmitted: onSubmitted,
      ),
    );
  }
}
