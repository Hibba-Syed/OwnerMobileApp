import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  final bool applyCenter;
  const CustomLoader({Key? key, this.width = 100, this.applyCenter = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (applyCenter) {
      return const Center(child: CircularProgressIndicator.adaptive()
          // LottieBuilder.asset(
          //   "assets/progress_indicator.json",
          //   width: width,
          // ),
          );
    }
    return const CircularProgressIndicator.adaptive();
  }
}
