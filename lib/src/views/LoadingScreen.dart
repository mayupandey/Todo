import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:todoapp/src/constant/StaticImageAssets.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: LottieBuilder.asset(loadingLottie));
  }
}
