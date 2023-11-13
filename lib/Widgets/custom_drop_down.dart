import 'package:flutter/material.dart';
import 'package:iskaanowner/Widgets/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;
  final String value;
  const CustomDropDown(
      {super.key,
      required this.items,
      required this.onChanged,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
        isDense: true,
        hint: CustomText(text: value),
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        items: items,
        onChanged: onChanged);
  }
}
