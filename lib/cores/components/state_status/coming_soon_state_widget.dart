import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../navigator/navigator.dart';

import '../../utils/utils.dart';
import '../components.dart';

class COmingSoonStateWidget extends StatelessWidget {
  static const String routeName = '/comingSoonStateWidget';

  final String title;
  final String message;
  final VoidCallback? onTap;

  const COmingSoonStateWidget({
    super.key,
    this.title = "Coming Soon",
    this.message = "This Feature Is Currently Unavailable",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        verticalSpace(20),
        TextWidget(
          title,
          fontSize: sp(20),
          fontWeight: FontWeight.w400,
        ),
        verticalSpace(5),
        // ColoredBox(
        //   color: kcGrey100,
        Lottie.asset(
          "assets/lottie/state_status/coming-soon.json",
          height: h(150),
          width: w(150),
          repeat: false,
          fit: BoxFit.fill,
        ),
        // ),
        verticalSpace(20),
        SizedBox(
          width: sw(75),
          child: TextWidget(
            message,
            fontSize: sp(15),
            fontWeight: FontWeight.w400,
            textAlign: TextAlign.center,
          ),
        ),
        verticalSpace(25),
        Button(text: "Okay", onTap: onTap ?? AppRouter.instance.goBack),
        verticalSpace(),
      ],
    );
  }
}
