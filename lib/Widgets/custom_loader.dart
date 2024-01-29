import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  const CustomLoader({Key? key, this.width = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator()
        // LottieBuilder.asset(
        //   "assets/progress_indicator.json",
        //   width: width,
        // ),
        );
  }
}
