import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  final bool applyCenter;
  final Color? color;
  const CustomLoader(
      {Key? key, this.width = 100, this.applyCenter = true, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (applyCenter) {
      return const Center(child: CircularProgressIndicator());
    }
    return const CircularProgressIndicator();
  }
}
